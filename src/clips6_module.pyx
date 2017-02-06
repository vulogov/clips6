cdef class MODULE(BASEENV):
    cdef void* module

    def __cinit__(self):
        BASEENV.Cinit(self)
    cdef create(self, void* env, void*  module):
        BASEENV.Create(self, <void *> env)
        self.module = module
        if self.module != NULL or self.env != NULL:
            self.ready = True
    def currentModule(self):
        if self.ready == True:
            SetCurrentModule(<void*>self.env, <void*>self.module)
            return True
        else:
            return False
    def __repr__(self):
        if self.ready == True:
            return "CLIPSMODULE(%s)"%GetDefmoduleName(<void*>self.env, <void*>self.module)
        else:
            return "CLIPSMODULE(UNKNOWN)"
    def Print(self):
        if self.ready == True:
            pp_out = GetDefmodulePPForm(<void*>self.env, <void*>self.module)
            if pp_out != NULL:
                return pp_out
            else:
                return ""
        else:
            return ""
