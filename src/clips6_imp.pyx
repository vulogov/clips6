default_python_modules = {
    "os": ["OS interfaces",True],
    "sys": ["Python system module",True],
    "uuid": ["UUID generation module",True],
    "traceback": ["Exploring and printing traceback",True],
    "atexit": ["Execute function at program termination",True],
    "time": ["Functions for manupulating time", True],
    "msgpack": ["Packing data into a compact structures. Required by the CLIPS6 module load", True],
    "OpenSSL": ["Support encryption routines. Required by the CLIPS6 module load", True],
    "tempfile": ["Temporary files geneartion", True],
    "shutil": ["High-level shell utilities", True],
    "base64": ["BASE64 encoding/decoding", True],
    "zlib": ["Compression routines", True],
    "UserDict": ["USER dictionary class", True],
    "fnmatch": ["Filename matching patterns", True],
    "anydbm": ["Simple key-value storage", True],
    "posixpath": ["Manipulations with directory structure",True]
}

def query_module_in_pypi(mod_name, release):
    print "query_pypi()"
    return "None"

def require_module(mod_name, **kw):
    import imp
    import sys
    can_stop = True
    if kw.has_key("can_stop"):
        can_stop = kw["can_stop"]
    can_pypi = False
    if kw.has_key("can_pypi"):
        can_pypi = kw["can_pypi"]
    desc = "Please install requiired module %s"%mod_name
    if kw.has_key("desc"):
        desc = kw["desc"]
    release = None
    if kw.has_key("release"):
        release = kw["release"]
    try:
        file, filename, mod_type = imp.find_module(mod_name)
    except:
        if can_pypi:
            desc = query_module_in_pypi(mod_name, release)
        print "MISSED MODULE %s"%mod_name
        print "="*30 + '\n'
        print desc
        print
        if can_stop:
            sys.exit(99)
        else:
            return False
    return True

def check_python_modules(_mods, can_pypi=False):
    for m in _mods.keys():
        require_module(m, desc=_mods[m][0], can_exit=_mods[m][1], can_pypi=can_pypi)


