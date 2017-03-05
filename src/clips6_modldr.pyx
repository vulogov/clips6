import os
import tempfile
import uuid
import shutil
import time
import posixpath
import platform
import msgpack
import anydbm

class PLATFORM:
    def getARCHITECTURE(self):
        return platform.architecture()[0]
    def getDISTNAME(self):
        return platform.dist()[0]
    def getDISTVER(self):
        return platform.dist()[1]
    def getPLATFORM(self):
        return platform.machine()
    def getUNAME(self):
        return platform.uname()

class MODLDR(PLATFORM):
    def __init__(self, name, env):
        self.NAME = name
        self.CLIPS6_FACTS_PATH = []
        self.CLIPS6_RULES_PATH = []
        self.CLIPS6_PYTHON_PATH = []
        self.CLIPS6_MODULES_PATH = []
        self.CLIPS6_MODULES_TMP_CACHE = "/tmp"
        self.CLIPS6_PACKAGES = {}
        self.HOME = "/tmp"
        self.USER = "nobody"
        self.PVTDIR = "%s/.clips6"%self.HOME
        self.KEYRING = "%s/keyring"%self.PVTDIR
        self.CLIPS6_ENABLE_CACHE = False
        self.HOME = None
        self.TMPDIR = None
        self.KRDB = None
        self.env = env
        self.reload()
    def reload(self):
        self.check_cache_enable()
        self.set_cache_temp_directory()
        self._set_from_env("CLIPS6_FACTS_PATH")
        self._set_from_env("CLIPS6_RULES_PATH")
        self._set_from_env("CLIPS6_PYTHON_PATH")
        self._set_from_env("CLIPS6_MODULES_PATH")
        for m in self.CLIPS6_PACKAGES.keys():
            self.CLIPS6_PACKAGES[m].reload()
        return True
    def init_user_environment(self, _kw, **kw):
        if len(kw.keys()) > 0:
            _k = kw
        else:
            _k = _kw
        self.USER = get_from_env("USER", default="nobody", kw=_k)
        self.HOME = get_from_env("CLIPS6_HOME", "HOME", default="/tmp", kw=_k)
        self.PVTDIR = get_from_env("CLIPS6_PRIVATE_DIR", default="%s/.clips6"%self.HOME, kw=_k)
        self.KEYRING = get_from_env("CLIPS6_KEYRING", default="%s/keyring"%self.PVTDIR, kw=_k)
        self.KEYNAME = get_from_env("CLIPS6_KEYNAME", default="default", kw=_k)
        if check_directory_write(self.PVTDIR) == False:
            try:
                os.makedirs(self.PVTDIR)
            except KeyboardInterrupt:
                return False
        try:
            self.KRDB = KEYRING(self)
        except KeyboardInterrupt:
            return False
        if check_file_write(self.KEYRING) == False:
            return False
        os.chmod(self.PVTDIR, 0700)
        os.chmod(self.KEYRING, 0600)
        return True
    def create(self, path, key_file):
        name = get_directory_name(path)
        if name == None:
            raise PkgError, "Can not get a package name in %s"%path
        p = CLIPS6_PACKAGE(name, self)
        res =  p.mk_package(posixpath.abspath(path))
        print 3,res
        if res == False:
            raise PkgError, "Can not generate a package in %s"%path
        print res
        #env = PACKET(self)
        #sign, data = SIGN(key_file, p.package.data)
        #env["SIGNATURE"] = sign
        #env["DATA"] = data
        return ""
    def set_cache_temp_directory(self):
        if self.TMPDIR != None:
            self.drop_cache_tmp_directory()
        try:
            self.CLIPS6_MODULES_TMP_CACHE = os.environ["CLIPS6_MODULES_TMP_CACHE"]
        except:
            self.CLIPS6_MODULES_TMP_CACHE = "/tmp"
        if self.CLIPS6_ENABLE_CACHE == True:
            self.CLIPS6_MODULES_TMP_CACHE = "%s/.clips6/.modcache"%self.HOME
        elif check_directory_write("/dev/shm") == True:
            self.CLIPS6_MODULES_TMP_CACHE = "/dev/shm/.clips6_modcache"
        elif check_directory_write("/tmp"):
            self.CLIPS6_MODULES_TMP_CACHE = "/tmp/.clips6_modcache"
        else:
            return False
        try:
            os.makedirs(self.CLIPS6_MODULES_TMP_CACHE)
        except:
            pass
        tempfile.tempdir = self.CLIPS6_MODULES_TMP_CACHE
        self.TMPDIR = tempfile.mkdtemp(str(uuid.uuid4()), "clips6_%s_%d_"%(self.NAME, time.time()))
        return True
    def drop_cache_tmp_directory(self):
        if check_directory_write(self.CLIPS6_MODULES_TMP_CACHE):
            shutil.rmtree(self.TMPDIR, True)
            self.TMPDIR = None
    def check_cache_enable(self):
        try:
            if int(os.environ["CLIPS6_ENABLE_CACHE"]) == 1:
                return self.enableCache()
        except:
            return False
    def enableCache(self):
        try:
            self.USER = os.environ["USER"]
        except:
            return False
        try:
            self.HOME = os.environ["HOME"]
        except:
            return False
        for d in ["/", "/clips6", "/lib", "/rules", "/facts"]:
            p = "%s/.clips6%s"%(self.HOME, d)
            if check_directory_write(p) == False:
                try:
                    os.mkdir(p)
                except:
                    return False
        self.CLIPS6_ENABLE_CACHE = True
        return True
    def disableCache(self):
        self.CLIPS6_ENABLE_CACHE = False
    def _env2list(self, name):
        res = []
        try:
            e = os.environ[name]
        except:
            return []
        for d in e.strip().split(":"):
            if check_directory(d) == False:
                continue
            res.append(d)
        return d
    def _set_from_env(self, name):
        v = self._env2list(name)
        setattr(self, name, v)
    def stop(self):
        self.drop_cache_tmp_directory()
