param(
    [string]$Namespace = 'statusscope-local',
    [string]$Context = 'docker-desktop',
    [string]$Registry = 'pkg.harness.io',
    [Parameter(Mandatory=$true)][string]$RegistryUser
)
$ErrorActionPreference = 'Stop'
$credential = Read-Host 'Registry token (not displayed)' -AsSecureString
$pointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($credential)
try {
    $token = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer)
    $auth = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("${RegistryUser}:$token"))
    $dockerConfig = @{auths=@{$Registry=@{auth=$auth}}} | ConvertTo-Json -Depth 8 -Compress
    @{
        apiVersion='v1'; kind='Secret'
        metadata=@{name='statusscope-registry'; namespace=$Namespace}
        type='kubernetes.io/dockerconfigjson'
        stringData=@{'.dockerconfigjson'=$dockerConfig}
    } | ConvertTo-Json -Depth 10 -Compress | kubectl --context $Context apply -f -
    if ($LASTEXITCODE -ne 0) { throw 'Could not configure the registry pull secret' }
} finally {
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer)
    $token=$null; $auth=$null; $dockerConfig=$null
}
