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
        self.parser.add_argument("--private", "-P", type=str, default="/usr/local/etc/clips6/ca/clips6.key",
                                 help="Location of the private key")
        self.parser.add_argument("--certificate", "-C", type=str, default="/usr/local/etc/clips6/ca/clips6.crt",
                                 help="Location of the certificate")
        self.parser.add_argument("--create", "-c", action="store_true", help="Create clips6 package")
        self.parser.add_argument("--verify", "-v", action="store_true", help="Verify package signature")
        self.parser.add_argument("--signature", "-s", action="store_true", help="Display package signature")
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
    def init(self):
        self.parser = argparse.ArgumentParser(prog='clipst6pkg', description=_DESC, epilog=_EPILOG)
        self.ready = 3
        PyConfig.__init__(self)
        ClipsConfig.__init__(self)
        PkgConfig.__init__(self)
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
        return



def main():
    P = Packager()
    P.main()



if __name__ == '__main__':
    main()
