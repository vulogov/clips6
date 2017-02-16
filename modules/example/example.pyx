cimport CLPmod as clp
from clips6 import ENV


CLIPS6_MODULE={
    "example": ["example", "", "i"]
}

cdef public int example(void* env):
    return 41


cdef public int init_clips6_example(void* env):
    cdef void* current_env


    #print "init_clips6_dummy(...)"

    return 1

