cdef class SHELL(BASEENV):
    def __cinit__(self):
        BASEENV.Cinit(self)
    cdef create(self, void* env):
        BASEENV.Create(self, <void*>env)
    def STRATEGY(self, stra=None):

        if self.isReady() != True:
            raise EvalError,"SHELL() is not ready"
        if stra != None:
            SetStrategy(<void*>self.env, stra)
            return stra
        else:
            return GetStrategy(<void*>self.env)

    def EVAL(self, cmd):
        cdef DATA_OBJECT res

        if self.isReady() != True:
            raise EvalError,"SHELL() is not ready"

        try:
            if Eval(<void*>self.env, cmd, &res) == 1:
                return clp2py(res)
        except:
            raise EvalError,"Error in: %s"%cmd
        raise EvalError,"Error in: %s"%cmd
    def RUN(self, limit=-1):
        if self.isReady() != True:
            raise ShellError(),"SHELL() is not ready"
        return Run(<void*>self.env, limit)
    def EXEC(self, cmd):
        if self.isReady() != True:
            raise EvalError, "SHELL() is not ready"
        RouteCommand(<void*>self.env, cmd, 1)
        FlushPPBuffer(<void*>self.env)
        return True
