param(
    [string]$Namespace = 'statusscope-local',
    [string]$Context = 'docker-desktop',
    [Parameter(Mandatory = $true)][string]$FirebaseServiceAccount
)
$ErrorActionPreference = 'Stop'
if ($Namespace -notmatch '^[a-z0-9]([-a-z0-9]*[a-z0-9])?$') { throw 'Invalid namespace' }
if (-not (Test-Path -LiteralPath $FirebaseServiceAccount -PathType Leaf)) { throw 'Firebase service account file not found' }
function Invoke-Kube {
    & kubectl --context $Context @args
    if ($LASTEXITCODE -ne 0) { throw "kubectl failed: $args" }
}
function Apply-Object($Object) {
    $Object | ConvertTo-Json -Depth 12 -Compress | & kubectl --context $Context apply -f -
    if ($LASTEXITCODE -ne 0) { throw 'Could not apply Kubernetes object' }
}
Apply-Object @{apiVersion='v1'; kind='Namespace'; metadata=@{name=$Namespace}}
$existing = Invoke-Kube -n $Namespace get secret statusscope-mysql --ignore-not-found -o name
if (-not $existing) {
    $password = [Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(32))
    $rootPassword = [Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(32))
    Apply-Object @{
        apiVersion='v1'; kind='Secret'; metadata=@{name='statusscope-mysql'; namespace=$Namespace}; type='Opaque'
        stringData=@{username='statusscope'; password=$password; 'root-password'=$rootPassword}
    }
    $password = $null
    $rootPassword = $null
} else { Write-Host 'Keeping the existing database credentials.' }
$firebase = Invoke-Kube -n $Namespace get secret statusscope-firebase --ignore-not-found -o name
if (-not $firebase) {
    Invoke-Kube -n $Namespace create secret generic statusscope-firebase "--from-file=service-account.json=$FirebaseServiceAccount"
} else { Write-Host 'Keeping the existing Firebase secret.' }
$manifest = Join-Path $PSScriptRoot '../k8s/infrastructure/mysql.yml'
Invoke-Kube -n $Namespace apply -f $manifest
Invoke-Kube -n $Namespace rollout status statefulset/statusscope-mysql --timeout=300s
Write-Host "MySQL is ready in $Namespace. Application deployments reuse this database and its volume."
