# How to create self-signed certificate for the clips6 Package 

### BIG FAT WARNING

I am [providing](../etc/ca) default clips6 package private key and certificate as the part of the clips6 package. **PLEASE DO NOT UNDER ANY CIRCUMSTANCES USE KEY AND CERTIFICATE PROVIDED FOR ANYTHING, BUT DEVELOPMENT**. They are there only as an example.

### Private key

First, you shall create a private key as:

```bash
openssl genrsa -out clips6.key 2048
Generating RSA private key, 2048 bit long modulus
........................+++
........+++
e is 65537 (0x10001)
```

Please note, your new private key is stored into a file _clips6.key_. **Keep it secret ! Keep it safe !**

### Cretificate request

```bash
openssl req -new -key clips6.key -out clips6.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:US
State or Province Name (full name) []:New York
Locality Name (eg, city) [Default City]:New York
Organization Name (eg, company) [Default Company Ltd]:ACME Corp
Organizational Unit Name (eg, section) []:Operations
Common Name (eg, your name or your server's hostname) []:clips6
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```

Please note, you are passing the filename with your private key to the parameter _-key_ and your _Certificate Request_ will be stored in _clips6.csr_. Please nore, there is no challenge password. As of now, challenge password for the certtificates are not supported by _clips6 Packages_. In the future ? Definitely "YES".

### Generate the Certificate from the request

```bash
openssl x509 -req -days 36600 -in clips6.csr -signkey clips6.key -out clips6.crt
Signature ok
subject=/C=US/ST=New York/L=New York/O=ACME Corp/OU=Operations/CN=clips6
Getting Private key
```

Please note, you are passing the CSR filename to a parameter _-in_ and private key to a parameter _-signkey_. Your certificate will be stored in the file _clips6.crt_

### Check, if you like this certificate

```bash
openssl x509 -in clips6.crt -text -noout
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number: 14490796461860690859 (0xc919a69b45b19bab)
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=US, ST=New York, L=New York, O=ACME Corp, OU=Operations, CN=clips6
        Validity
            Not Before: Feb 20 17:29:22 2017 GMT
            Not After : May  7 17:29:22 2117 GMT
        Subject: C=US, ST=New York, L=New York, O=ACME Corp, OU=Operations, CN=clips6
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:ba:9d:4e:93:1d:b7:0f:9c:80:b2:ad:b7:45:34:
                    f0:01:9e:6f:69:1f:49:3e:64:a0:0c:fd:c8:73:e4:
                    19:d4:fe:11:f5:c4:3a:fc:f7:37:2c:c6:20:d6:7c:
                    cf:a0:5c:89:bf:60:d4:5a:51:5a:14:ac:7b:a1:1c:
                    23:47:8d:59:a3:df:ad:5b:99:1a:ab:66:72:f7:2b:
                    79:bc:73:13:a9:be:98:96:2c:18:be:de:e2:18:7b:
                    60:8e:43:23:08:e6:60:d3:9f:c8:9e:78:00:39:0d:
                    50:95:4b:e1:69:53:e6:89:c1:61:a3:b7:77:1f:78:
                    57:45:8e:59:35:33:9d:75:d8:9b:37:fd:71:33:3b:
                    9b:dc:16:6f:16:f1:8b:5f:ca:98:bf:cb:5e:62:4f:
                    4a:f7:d4:ad:8b:a6:f2:9d:9c:09:4c:3f:d9:a6:72:
                    ff:40:6a:4b:1f:a4:3e:a7:e6:47:a1:1a:50:72:1b:
                    39:b9:ad:9a:8e:1a:df:68:ee:ab:7e:17:20:d9:1c:
                    76:e7:a7:7d:f4:29:bc:4d:7b:3b:89:4f:43:62:ce:
                    83:b9:9b:c1:2e:9d:52:eb:67:4f:f8:3d:d5:b5:83:
                    f1:5d:63:d4:37:00:49:3a:64:84:56:70:61:65:4d:
                    06:a7:46:83:00:32:da:ca:f4:f6:77:86:ac:d0:07:
                    05:37
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha1WithRSAEncryption
         7d:0f:22:1d:8b:52:01:41:cc:b5:4f:05:ee:7a:df:15:d1:10:
         a4:46:41:f0:4a:08:15:55:25:7c:90:a9:20:cd:8b:c0:ca:8f:
         74:89:94:39:91:4e:88:fa:39:17:4b:49:2a:0f:b2:9a:88:04:
         34:34:d3:51:75:0a:3c:7c:da:fc:b1:84:49:4e:13:c3:40:95:
         43:8c:74:d6:80:5a:f9:30:0c:4f:db:00:3a:a2:dc:c4:2c:20:
         18:58:d2:b0:6d:f9:12:cb:c7:e9:e2:38:d7:c6:fa:6f:36:91:
         7f:6c:a5:86:af:02:95:cb:ed:6c:67:80:7e:34:b7:17:a5:5f:
         bc:51:00:e1:bd:4f:c3:89:ff:12:83:aa:2b:45:89:8c:13:34:
         cd:a8:e0:f6:96:ad:c6:41:28:35:7d:f2:c3:db:61:77:71:cc:
         96:ea:b1:55:cd:9b:48:e1:ed:35:5e:04:26:03:7c:a9:52:1f:
         1a:a7:d7:1e:b4:2f:06:19:9e:f8:12:01:cf:85:29:3e:8e:6a:
         4b:27:1b:11:39:9b:86:0e:87:7d:8d:9c:f7:ba:e3:27:13:72:
         70:6d:5b:dd:99:d2:e4:e3:12:8c:a6:ed:3c:bc:bb:c3:1e:c2:
         aa:e8:70:a8:50:a6:60:e6:a0:14:3b:fe:81:b2:50:cc:4f:28:
         c5:39:73:9c

```