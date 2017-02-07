import imp, posixpath

cdef public clips6_load_module(void* env, char *module):
    m_name = posixpath.basename(module).split(".")[0]
    if check_file_read(module) == True:
        fp = open(module)
        mod = imp.load_module(m_name, fp, module, ('.so', 'rb', 3))
        try:
            _mod = mod.CLIPS6_MODULE
        except:
            return False
        for m in _mod.keys():
            clips6_dl(env, module, _mod[m][0], m, _mod[m][1], _mod[m][2])
        return True
    return False