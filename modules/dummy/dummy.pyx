cimport CLPmod as clp


CLIPS6_MODULE={
    "dummy": ["dummy", "", "i"]
}

cdef public int dummy(void* env):
    return 42


cdef public int init_clips6_dummy(void* env):
    cdef void* current_env

    print "init_clips6_dummy(...)"

    return 1

