
# Alpine docker with OpenSSL with GOST engine

`/ # openssl engine gost -c`

```
[gost89, gost89-cnt, gost89-cnt-12, gost89-cbc, kuznyechik-ecb, kuznyechik-cbc, kuznyechik-cfb, kuznyechik-ofb, kuznyechik-ctr, magma-ecb, kuznyechik-mgm, magma-cbc, magma-ctr, magma-ctr-acpkm, magma-ctr-acpkm-omac, magma-mgm, kuznyechik-ctr-acpkm, kuznyechik-ctr-acpkm-omac, magma-kexp15, kuznyechik-kexp15, md_gost94, gost-mac, md_gost12_256, md_gost12_512, gost-mac-12, magma-mac, kuznyechik-mac, kuznyechik-ctr-acpkm-omac, gost2001, id-GostR3410-2001DH, gost-mac, gost2012_256, gost2012_512, gost-mac-12, magma-mac, kuznyechik-mac, magma-ctr-acpkm-omac, kuznyechik-ctr-acpkm-omac]
```

`/ # openssl ciphers | tr ':' '\n' | grep GOST`

```
GOST2012-MAGMA-MAGMAOMAC
GOST2012-KUZNYECHIK-KUZNYECHIKOMAC
LEGACY-GOST2012-GOST8912-GOST8912
IANA-GOST2012-GOST8912-GOST8912
GOST2001-GOST89-GOST89
```


```
/ # openssl version
OpenSSL 3.1.2 1 Aug 2023 (Library: OpenSSL 3.1.2 1 Aug 2023)
```


```
/ # openssl engine
(rdrand) Intel RDRAND engine
(dynamic) Dynamic engine loading support
(gost) Reference implementation of GOST engine
```
