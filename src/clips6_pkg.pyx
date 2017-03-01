##
## This is a main file for the clips6 command
##

include "clips6.pyx"
import argparse
import sys
import posixpath


_DESC="""clips6 packaging tool VER(%s)"""%CLIPS6_VERSION
_EPILOG="""Generate/Query/Verify clips6 packages"""


class PyConfig:
    def __init__(self):
        self.parser.add_argument("--python", type=str, default=".",
                                 help="Semi-colon separated list of the directories containing Python Modules")
        self.ready -= 1
    def process(self):
        return

class ClipsConfig:
    def __init__(self):
        self.parser.add_argument("--clips", type=str, default=".",
                                 help="Semi-colon separated list of the directories containing clips6 modules and packages")
        self.ready -= 1
    def process(self):
        return

class PkgConfig:
    def __init__(self):
        self.parser.add_argument("--home", "-H", type=str,
                                 help="Location of the home directory for the .clips6 root")
        self.parser.add_argument("--keyname", "-K", type=str, default="default",
                                 help="Name of the private key from the keyring")
        self.parser.add_argument("--private", "-P", type=str, default="/usr/local/etc/clips6/ca/clips6.key",
                                 help="Location of the private key")
        self.parser.add_argument("--certificate", "-C", type=str, default="/usr/local/etc/clips6/ca/clips6.crt",
                                 help="Location of the certificate")
        self.parser.add_argument("--create", "-c", action="store_true", help="Create clips6 package")
        self.parser.add_argument("--verify", "-v", action="store_true", help="Verify package signature")
        self.parser.add_argument("--signature", "-s", action="store_true", help="Display package signature")
        self.parser.add_argument("--private_install", action="store_true", help="Install preivate key into a keyrings")
        self.parser.add_argument("--certificate_install", action="store_true", help="Install certificate into a keyrings")
        self.parser.add_argument("--keyring", action="store_true",
                                 help="Show keyring")
        self.parser.add_argument('path', metavar='N', type=str, nargs='*',
                                 help='Path to the clips6 module')
        self.parser.add_argument("--out", "-o", type=str, default=".", help="Destination directory")
        self.ready -= 1
    def process(self):
        self.args.out = posixpath.abspath(self.args.out)
        if check_directory_write(self.args.out) == False:
            print "Can not output to the directory: %s"%self.args.out
            self.ready += 1


class Packager(PyConfig, ClipsConfig, PkgConfig):
    def __init__(self):
        self.env = CURRENT()
        if self.env == None:
            self.env = MAKE()
        if self.env.isReady() == False:
            print "Environment isn't ready. Exit."
            sys.exit(98)
        print self.env.loader
        self.init()
        self.parse_args()
        self.process()
        if self.ready != 0:
            print "Argument processing is unsatisfactory. Exit."
            sys.exit(97)
        self.env_init()
    def init(self):
        self.parser = argparse.ArgumentParser(prog='clipst6pkg', description=_DESC, epilog=_EPILOG)
        self.ready = 3
        PyConfig.__init__(self)
        ClipsConfig.__init__(self)
        PkgConfig.__init__(self)
    def env_init(self):
        if self.args.home != None and check_directory_write(self.args.home) == True:
            self.env.RELOAD(CLIPS6_HOME=self.args.home)
    def parse_args(self):
        self.args = self.parser.parse_args()
        print self.args
    def process(self):
        PkgConfig.process(self)
        ClipsConfig.process(self)
        PyConfig.process(self)
    def main(self):
        if self.args.create == True:
            self.create()
            return
        if self.args.private_install == True:
            self.private_install()
            return
        if self.args.certificate_install == True:
            self.cert_install()
            return
        if self.args.keyring == True:
            self.ls_keyring()
            return

    def create(self):
        for d in self.args.path:
            try:
                pack, pkg = self.env.loader.create(d, self.args.private)
                pkg_fname = "%s/%s-%s-%s.package"%(self.args.out, pkg["NAME"],pkg["OS"],pkg["PLATFORM"])
                f = open(pkg_fname, "wb")
                f.write(pack)
                f.close()
            except:
                print "Can not generate package for the %s"%d
                break
    def private_install(self):
        if check_file_read(self.args.private) != True:
            print "Can not install a %s"%self.args.private
        if self.env.keyring.setPrivate(self.args.keyname, self.args.private) != True:
            print "Can not install a %s" % self.args.certificate
    def cert_install(self):
        if check_file_read(self.args.certificate) != True:
            print "Can not install a %s"%self.args.certificate
        if self.env.keyring.setPublic(self.args.keyname, self.args.certificate) != True:
            print "Can not install a %s" % self.args.certificate
    def ls_keyring(self):
        pri, cert = self.env.keyring.keys()
        print "Private keys:"
        print "-"*40
        for i in pri:
            print i
        print "\nCertificates:"
        print "-" * 40
        for i in cert:
            print i



def main():
    P = Packager()
    P.main()



if __name__ == '__main__':
    main()
