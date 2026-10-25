# The pipeline builds and tests this exact Quarkus distribution before packaging it.
# Local prerequisite: ./mvnw -B clean verify
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
RUN addgroup -S -g 10001 app && adduser -S -u 10001 -G app app
COPY --chown=10001:10001 target/quarkus-app/ /app/
USER 10001:10001
ENV QUARKUS_HTTP_HOST=0.0.0.0
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=120s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1:8080/q/health/live || exit 1
ENTRYPOINT ["java", "-jar", "/app/quarkus-run.jar"]
