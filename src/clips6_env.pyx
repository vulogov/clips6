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
    cdef object facts
    def __cinit__(self, c=True):
        global ENVIRONMENTS
        BASEENV.Cinit(self)
        if c == True:
            self.env = <void*>CreateEnvironment()
        else:
            self.env = NULL
        self.facts = []
        if self.env != NULL:
            self.ready = True
            ENVIRONMENTS.append(self)
    cdef Derive(self, void* env):
        if self.ready == True:
            if self.env != NULL:
                self.stop()
            self.env = env
            self.facts = []
            ENVIRONMENTS.append(self)
            self.ready = True
    def currentModule(self):
        if self.ready != True:
            raise EnvError, "Environment not ready for the currentModule()"
        m = MODULE()
        m.create( < void * > self.env, <void *>EnvGetCurrentModule( <void *>self.env))
        return m

    def __getitem__(self, key):
        if self.ready != True:
            raise EnvError, "Environment not ready for the Module querying"
        _m = <void *>EnvFindDefmodule( < void * > self.env, key)
        if _m == NULL:
            raise KeyError, key
        else:
            m = MODULE()
            m.create( <void *> self.env, <void *>_m)
            return m
    def RouterIO(self, logicalName):
        if self.ready != True:
            raise EnvError, "Environment not ready for the RouterIO()"
        DropIO(self.env, logicalName)
        res = RegisterIO(self.env, logicalName)
        if res == 1:
            envRegisterIO(self, logicalName)
            return True
        return False
    def DropIO(self, logicalName):
        if self.ready != True:
            raise EnvError, "Environment not ready for the DropIO()"
        if DropIO(self.env, logicalName) == 1:
            return True
        return False
    def DLmodule(self, module):
        if self.ready != True:
            raise EnvError, "Environment not ready for the DLmodule()"
        if check_directory(module) == True:
            return clips6_load_directory(self.env, module)
        elif check_file_read(module) == True:
            return clips6_load_module(self.env, module)
        else:
            return False

    def SHELL(self):
        if self.ready != True:
            raise EnvError, "Environment not ready for the SHELL()"
        s = SHELL()
        s.create(<void*>self.env)
        return s
    def IS_CHANGED(self):
        if self.ready != True:
            return False
        if EnvGetFactListChanged( <void *>self.env) == 0:
            return False
        EnvSetFactListChanged( <void *>self.env, 0)
        return True
    def CLEAR(self):
        if self.ready == True:
            EnvClear( <void *>self.env)
        else:
            raise EnvError, "Environment not ready for the CLEAR()"
    def RESET(self):
        if self.ready == True:
            EnvReset( <void *> self.env)
        else:
            raise EnvError, "Environment not ready for the RESET()"
    def LOAD(self, name):
        if self.ready != True:
            raise EnvError, "Environment not ready for the LOAD()"
        if name != None and check_file_read(name):
            if EnvLoad( <void *>self.env, name) == 1:
                return True
        return False
    def BUILD(self, constr):
        if self.ready != True:
            raise EnvError, "Environment not ready for the BUILD()"
        if EnvBuild( <void *> self.env, constr) == 1:
            return True
        return False

    def FACTS(self):
        if self.ready != True:
            return None
        f = FACTS()
        f.create( < void * > self.env)
        self.facts.append(f)
        return f

    def stop(self):
        if self.ready != True:
            return
        for f in self.facts:
            f.stop()
        if self.ready == True:
            DestroyEnvironment(<void*>self.env)
