cdef class BASEENV:
    cdef void * env
    cdef object ready

    def Cinit(self):
        self.ready = False
        self.env = NULL
    def isReady(self):
        if self.env == NULL:
            return False
        return self.ready
    cdef Create(self, void * env):
        if env != NULL:
            self.env = env
            self.ready = True

cdef class ENV(BASEENV):
    def __cinit__(self):
        BASEENV.Cinit(self)
        self.env = <void*>CreateEnvironment()
        if self.env != NULL:
            self.ready = True
    def DLmodule(self, module):
        return clips6_load_module(self.env, module)
    def SHELL(self):
        if self.ready != True:
            return None
        s = SHELL()
        s.create(<void*>self.env)
        return s
