cimport CLPmod as clp
include "clips6_constants.pyi"


CLIPS6_MODULE={
    "require-python": ["require_python", "ss", "w"],
    "require-python-or-exit": ["require_python_or_exit", "ss", "w"]
}

cdef public void* require_python(void* env):
    return (clp.TrueSymbol())
cdef public void*  require_python_or_exit(void* env):
    return (clp.TrueSymbol())



cdef public int init_clips6_dummy(void* env):

    return 1

