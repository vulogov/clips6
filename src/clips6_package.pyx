def SIGN(key_file, data):
    import OpenSSL.crypto
    import base64

    if check_file_read(key_file) != True:
        raise ShellError, "Can not access private key %s"%key_file

    try:
        st_key = open(key_file, 'rt').read()
        key = OpenSSL.crypto.load_privatekey(OpenSSL.crypto.FILETYPE_PEM, st_key)
        sign = OpenSSL.crypto.sign(key, data, "sha256")
        return base64.b64encode(sign)
    except:
        raise ShellError, "Can not sign with %s"%key_file

def VERIFY(cert_file, data, sign):
    import OpenSSL.crypto
    import base64

    sig = base64.b64decode(sign)
    if check_file_read(cert_file) != True:
        raise ShellError, "Can not access certificate %s"%cert_file

    try:
        st_cert = open(cert_file, 'rt').read()
        cert = OpenSSL.crypto.load_certificate(OpenSSL.crypto.FILETYPE_PEM, st_cert)
        OpenSSL.crypto.verify(cert, sig, data, "sha256")
    except:
        return False
    return True


class CLIPS6_PACKAGE:
    def __init__(self, name, loader):
        self.NAME = name
        self.loader = loader
    def mk_package(self, path):
        pkg = {}
        pkg["TIME"] = time.time()
        pkg["NAME"] = self.NAME
        print pkg
    def reload(self):
        return
