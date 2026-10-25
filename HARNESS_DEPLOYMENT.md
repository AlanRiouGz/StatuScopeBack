# StatuScope: backend en Harness y Kubernetes local

## Arquitectura acordada

Dos repositorios, dos pipelines y un namespace compartido (`statusscope-local`).
El backend usa Quarkus 3.31.3, Maven y Java 17. El frontend usa Expo y Node 22.
La base MySQL 8.4 tiene un StatefulSet de una réplica y un volumen persistente de 5 GiB.
La base se administra fuera del despliegue canary/rolling de las aplicaciones.

| Aplicación | Registro Harness solicitado | Repositorio de imagen | Servicio Kubernetes |
| --- | --- | --- | --- |
| Backend | `statucopeback` | `statusscope-backend` | `statusscope-backend` |
| Frontend | `statuscopefront` | `statusscope-frontend` | `statusscope-frontend` |

Se conserva exactamente `statucopeback`, sin una segunda `s`: es el nombre solicitado.
Harness necesita el **identificador** del registro. Si su identificador difiere del nombre visible,
cambiar el parámetro `Registry`. Estas plantillas no crean registros ni conectores en Harness.

## Primera preparación local

Desde el repositorio del backend, con PowerShell 7:

```powershell
./scripts/setup-local-kubernetes.ps1 -FirebaseServiceAccount 'RUTA_ABSOLUTA_AL_JSON_DE_FIREBASE'
```

El script crea el namespace, genera contraseñas aleatorias sin imprimirlas, guarda las credenciales
en Secrets, instala MySQL y espera a que esté listo. Al repetirlo conserva los Secrets y el volumen.
El JSON debe pertenecer al mismo proyecto Firebase que usa el frontend. No se incluye en Git,
en el JAR ni en la imagen. MySQL no se publica fuera del clúster.

Para descargar imágenes privadas desde ambos registros:

```powershell
./scripts/set-registry-secret.ps1 -RegistryUser 'USUARIO_DEL_REGISTRO'
```

El token se solicita de forma oculta. Debe tener permiso de lectura en los dos registros.
Para credenciales diferentes por registro, crear Secrets distintos y ajustar `registrySecretName`
en los valores de cada servicio.

## Crear las pipelines en Harness

1. Publicar los cambios de cada repositorio en la rama que vaya a clonar Harness.
2. Crear registros Docker en Harness Artifact Registry con identificadores `statucopeback`
   y `statuscopefront`. Conservar organización/proyecto del YAML solo si siguen siendo los correctos.
3. Importar `.harness/pipeline-template.yml` de cada repositorio en **Templates**, tipo Pipeline.
   La raíz es `template:`, como en el ejemplo; no pegarla directamente como una `pipeline:`.
4. Crear una pipeline desde cada template y seleccionar su propio repositorio en Codebase.
   El conector `Docker_infra` se conserva del ejemplo y debe existir en el mismo alcance.
5. Crear un servicio CD Kubernetes por aplicación. Configurar la fuente de artefacto Harness
   Artifact Registry con su registro y repositorio de imagen de la tabla.
6. En el artefacto del servicio, fijar el tag mediante la expresión `<+pipeline.sequenceId>`.
   Así CD descarga la imagen publicada por **esa misma ejecución**, no una etiqueta anterior.
7. Añadir un manifiesto **K8s Manifest** desde el repositorio de la aplicación:
   carpeta `k8s/manifests`, archivo de valores `k8s/values.yml`, versión de Go template compatible
   con `int`, `quote` e `if`. Seleccionar la misma rama/revisión que CI para mantener coherencia.
   **No** configurar todo `k8s/` como carpeta de manifiestos: contiene infraestructura separada.
8. Seleccionar el entorno y la infraestructura que apuntan al clúster Docker Desktop y al namespace
   `statusscope-local`. El delegate/runner debe poder llegar al clúster y a `host.docker.internal`.
9. Backend: `Registry=statucopeback`, `Image_repository=statusscope-backend`.
   Frontend: `Registry=statuscopefront`, `Image_repository=statusscope-frontend` y los cuatro valores
   públicos de Firebase Web. Nunca usar la clave privada del Admin SDK como variable `EXPO_PUBLIC_*`.
10. Ejecutar primero backend y después frontend. Después pueden desplegarse de forma independiente.

Se mantienen Semgrep, Gitleaks, OWASP, Trivy, Grype y Nmap, condicionados por `STO_scans`.
Las pruebas siempre se ejecutan aunque `STO_scans=false`. ZAP y la aprobación siguen desactivados,
como en el ejemplo. Para simplificar la primera puesta en marcha puede elegirse `STO_scans=false`;
la licencia y la configuración del runner determinan la disponibilidad de los escáneres.
Se conserva el DinD del ejemplo y se limita su espera a 120 segundos.

Los puertos predeterminados son 30080 (web) y 30081 (backend). Deben ser distintos en otros
namespaces/entornos del mismo clúster, ya que los NodePort son globales al clúster.
El paso de validación obtiene el puerto del servicio exacto, en lugar de tomar el primer NodePort.

## Build local

```powershell
./mvnw.cmd -B -ntp clean verify
docker build -t statusscope-backend:local .
```

En CI/Linux se usa `sh ./mvnw`, independiente del permiso ejecutable almacenado por Windows.
JUnit queda en `target/surefire-reports/TEST-*.xml`; JaCoCo en `target/jacoco-report/jacoco.xml`.
El Dockerfile empaqueta **toda** la distribución `target/quarkus-app/`; no recompila ni cambia
el artefacto probado. Los archivos privados de credenciales se excluyen mediante Maven resources.

## Persistencia y cambios de esquema

En producción se usa MySQL y Hibernate `validate`; no se borran ni recrean las tablas al arrancar.
La migración `db/bootstrap/mysql/V0__initial_mysql_schema.sql` crea el esquema completo y la carga
base únicamente en una base **nueva**. Fue generada desde las entidades actuales con Hibernate,
y después se ejecutan V1–V7. `baseline-on-migrate=false` evita aceptar silenciosamente una base
existente con estructura desconocida. Las pruebas siguen usando H2 y no ejecutan esta V0 de MySQL.

Las siguientes modificaciones de entidades requieren nuevas migraciones versionadas: no editar V0
una vez aplicada. No ejecutar el script destructivo de desarrollo `dev_bootstrap_seed.sql` en esta base.
Un rollback de aplicación no revierte migraciones SQL: mantener compatibilidad entre versiones.
El PVC sobrevive a un reinicio de pod o a un despliegue de la app; eliminar el namespace/PVC o
restablecer Docker Desktop puede perder los datos. El volumen local no sustituye a un respaldo.

## Configuración adicional

Firebase se monta en `/var/run/secrets/firebase/service-account.json`.
Las claves de IA son opcionales para arrancar; las funciones que las requieren necesitan un Secret
`statusscope-llm` con `OPENAI_API_KEY` y/o `GEMINI_API_KEY` (y opcionalmente los modelos correspondientes).
El Deployment acepta ese Secret mediante `envFrom` y debe reiniciarse después de crearlo/cambiarlo.
No se han hecho llamadas reales a proveedores de IA durante la validación.

La nueva base no copia usuarios de otra MySQL. El seeder de usuarios de desarrollo está desactivado
en producción; usar el flujo de registro de la aplicación y definir después las cuentas administrativas.
Las pruebas de despliegue no sustituyen la comprobación de inicio de sesión con una cuenta real.

## Fuentes de referencia

- Quarkus: https://quarkus.io/guides/maven-tooling/
- Flyway y módulo MySQL: https://quarkus.io/guides/flyway/
- Salud: https://quarkus.io/guides/smallrye-health/
- Cobertura: https://quarkus.io/guides/tests-with-coverage/
- Base de Harness: Golden Java End-to-End Template aportado por el usuario.
