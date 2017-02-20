cimport CLPmod as clp


CLIPS6_MODULE={
    "require-python": ["require_python", "ss", "b"],
    "require-python-or-exit": ["require_python_or_exit", "ss", "b"]
}

cdef public int require_python(void* env):
    return clp.TRUE()
cdef public int  require_python_or_exit(void* env):
    return clp.TRUE()



cdef public int init_clips6_dummy(void* env):

    return 1

