$CSRPath = "$($env:UserProfile)\$($env:COMPUTERNAME).csr"
$INFPath = "$($env:UserProfile)\$($env:COMPUTERNAME).inf"
$Signature = '$Windows NT$'

$INF =
@"
[Version]
Signature= "$Signature"

[NewRequest]
Subject = "O=mycompany, CN=mmaher"
KeySpec = 1
KeyLength = 2048
Exportable = FALSE
MachineKeySet = TRUE
SMIME = False
PrivateKeyArchive = FALSE
UserProtected = FALSE
UseExistingKeySet = FALSE
ProviderName = "Microsoft Strong Cryptographic Provider"
ProviderType = 1
RequestType = PKCS10
KeyUsage = 0xa0
FriendlyName = "Cert for $($env:Username)"
HashAlgorithm = "sha256"

[RequestAttributes]
CertificateTemplate = "ZeroTrustClientCert"
"@


#Write-Host "Certificate Request is being generated `r "
$INF | out-file -filepath $INFPath -force
certreq -new $INFPath $CSRPath

$csrStr = Get-Content -Raw -Path $CSRPath
#$csrStr | clip
#Write-Host "The CSR will be in your clipboard"


# https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc736326(v=ws.10)
#
