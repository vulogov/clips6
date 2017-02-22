import uuid
import zlib
import msgpack
import UserDict


def SIGN(key_file, data):
    import OpenSSL.crypto
    import base64

    if check_file_read(key_file) != True:
        raise PkgError, "Can not access private key %s"%key_file
    try:
        buf = zlib.compress(msgpack.dumps(data))
    except:
        raise PkgError, "Can not pack the data"

    try:
        st_key = open(key_file, 'rt').read()
        key = OpenSSL.crypto.load_privatekey(OpenSSL.crypto.FILETYPE_PEM, st_key)
        sign = OpenSSL.crypto.sign(key, buf, "sha256")
        return (base64.b64encode(sign), buf)
    except:
        raise PkgError, "Can not sign with %s"%key_file

def VERIFY(cert_file, data, sign):
    import OpenSSL.crypto
    import base64

    sig = base64.b64decode(sign)
    if check_file_read(cert_file) != True:
        raise PkgError, "Can not access certificate %s"%cert_file

    try:
        st_cert = open(cert_file, 'rt').read()
        cert = OpenSSL.crypto.load_certificate(OpenSSL.crypto.FILETYPE_PEM, st_cert)
        OpenSSL.crypto.verify(cert, sig, data, "sha256")
    except:
        return False
    return True

def UNPACK(cert_file, data, sign):
    import OpenSSL.crypto
    import base64

    if VERIFY(cert_file, data, sign) == True:
        return msgpack.loads(zlib.decompress(data))
    raise PkgError, "Can not unpack data"


class PACKET(UserDict.UserDict):
    def __init__(self):
        UserDict.UserDict.__init__(self)
        self['ID'] = str(uuid.uuid4())
        self["TIME"] = time.time()
    def dumps(self, key_file):
        return SIGN(key_file, self.data)
    def loads(self, key_file, data, sign):
        self.data = UNPACK(key_file, data)


class CLIPS6_PACKAGE:
    def __init__(self, name, loader):
        self.NAME = name
        self.loader = loader
        self.package = None
    def mk_package(self, path):
        pkg = PACKET()
        pkg["NAME"] = self.NAME
        pkg['ARCH'] = self.loader.getARCHITECTURE()
        pkg["UNAME"]= self.loader.getUNAME()
        pkg["PLATFORM"] = self.loader.getPLATFORM()
        pkg["OS"]   = self.loader.getDISTNAME()
        pkg["OS_VER"]   = self.loader.getDISTVER()
        _mod = posixpath.abspath("%s/%s.module"%(path, self.NAME))
        if check_file_read(_mod) == False:
            return False
        pkg["MODULE"] = read_file_into_buffer(_mod)
        if check_directory("%s/manifest"%path) == False:
            return False
        _man = posixpath.abspath("%s/manifest"%path)
        pkg["MANIFEST"] = read_dir_content(_man)
        _doc = posixpath.abspath("%s/documentation"%path)
        pkg["DOCUMENTATION"] = read_dir_content(_doc)
        _facts = posixpath.abspath("%s/facts" % path)
        pkg["FACTS"] = read_dir_content(_facts)
        _rules = posixpath.abspath("%s/rules" % path)
        pkg["RULES"] = read_dir_content(_rules)
        _m = {}
        for m in pkg["MODULE"]:
            _p = posixpath.abspath("%s/%s"%(path,m))
            if check_file_read(_p) == False:
                return False
            _m[m] = open(_p, "rb").read()
        pkg["PKG"] = _m
        self.package = pkg
        return True
    def reload(self):
        return
