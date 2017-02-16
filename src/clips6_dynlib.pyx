import imp, posixpath


cdef public clips6_load_directory(void* env, char *path):
    m_name = posixpath.basename(path)
    m_file = "%s/%s.module"%(path, m_name)
    if check_directory(path) == True and check_file_read(m_file):
        module = read_file_into_buffer(m_file)
        for mod in module:
            try:
                n, ext = mod.split(".")
            except:
                return False
            f_path = "%s/%s"%(path, mod)
            if ext == "so":
                if clips6_load_module(env, f_path) == False:
                    return False
            elif ext == "clp":
                if EnvLoad(env, f_path) != 1:
                    return False
            else:
                continue
        return True
    return False


cdef public clips6_load_module(void* env, char *module):
    m_name = posixpath.basename(module).split(".")[0]
    if check_file_read(module) == True:
        fp = open(module)
        mod = imp.load_module(m_name, fp, module, ('.so', 'rb', 3))
        init_res = clips6_function_int(env, module, "init_clips6_%s"%m_name)
        try:
            _mod = mod.CLIPS6_MODULE
        except:
            return False
        for m in _mod.keys():
            clips6_dl(env, module, _mod[m][0], m, _mod[m][1], _mod[m][2])
        return True
    return False