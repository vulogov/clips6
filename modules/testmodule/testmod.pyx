cimport CLPmod as clp


CLIPS6_MODULE={
    "getclock": ["get_clock", "", "d"],
    "makeA": ["make_class", "", "a"],
    "call_a": ["call_a", "a", "a"],
    "call_b":["call_b", "a", "a"],
    "print_params": ["print_params", "sidm", "a"]
}

class A:
    def __init__(self):
        print "Class A Constructor is called"
    def a(self):
        print "Method a() called",self

cdef public double get_clock(void* env):
    import time
    return time.time()

cdef public double get_number_of_params(void* env):
    #return clp.ArgCountCheck(env, "rtn_args", clp.EXACTLY, 3)
    print "Check params",clp.ArgCountCheck(env, "rtn_args", clp.EXACTLY, 3)
    str_param = clp.RtnLexeme(env, 1)
    float_param = clp.RtnDouble(env, 2)
    int_param = clp.RtnLong(env, 3)
    print repr(str_param),repr(float_param), repr(int_param)
    print repr(float_param+float(int_param))
    return float_param+float(int_param)

cdef public object make_class(void* env):
    return A()

cdef public object call_a(void* env):
    cdef object a
    cdef clp.DATA_OBJECT data
    if clp.ArgCountCheck(env, "call_a", clp.EXACTLY, 1) != 1:
        return <object>(NULL)
    clp.RtnUnknown(env, 1, &data)
    if data.type == clp.EXTERNAL_ADDRESS:
        a = <object>data.value
        a.a()
        return <object>a
    else:
        return <object>(NULL)

cdef public object call_b(void* env):
    cdef object a
    a = clp.getPyObjectFromArgs(env, "call_b", 1)
    a.a()
    return a

cdef public object print_params(void* env):
    for i in range(1,5):
        print repr(clp.getArgument(env, "print_params", i))
    return <object>None


cdef public int init_clips_testmod(void* env):
    cdef void* current_env

    if env == NULL:
        return 1
    current_env = env

    return 0

