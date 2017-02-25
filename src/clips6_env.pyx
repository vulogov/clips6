import uuid
import time
import os


class ENVCTL:
    def __init__(self):
        self.default = None
        self._lock = 0
        self.max_lock = 3600
        self.envs = {}
    def wait_for_lock(self, w=180):
        s = time.time()
        while True:
            if self._lock == 0:
                self._lock = time.time()
                return True
            if (time.time() - s) > w:
                return False
            time.sleep(1)
    def lock(self):
        if not self.wait_for_lock():
            return False
        self._lock = time.time()
        return True
    def unlock(self):
        if self._lock != 0:
            self._lock = 0
    def register(self, e):
        if e.IS_REGISTERED():
            return True
        try:
            self.envs[e.NAME()] = e
        except:
            return False
        return True
    def __getitem__(self, name):
        if name not in self.envs.keys():
            raise EnvError, "REquested environment %s not found"%name
        return self.envs[name]
    def names(self):
        return self.envs.keys()
    def environments(self):
        return self.envs.values()
    def is_registered(self, name):
        return self.envs.has_key(name)
    def set_current(self, e):
        self.default = e.NAME()
    def current(self):
        if self.default == None or self.default not in self.names():
            return None
        return self[self.default]

E = ENVCTL()


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
    cdef object ctl
    cdef char*  name
    cdef object set_current
    cdef public object loader
    def __cinit__(self, name=str(uuid.uuid4()), **kw):
        global E
        BASEENV.Cinit(self)
        self.env = <void*>CreateEnvironment()
        self.facts = []
        self.name = name
        self.set_current = True
        self.ready = False
        if kw.has_key("set_current"):
            self.set_current = kw["set_current"]
        if kw.has_key("E"):
            self.ctl = kw["E"]
        else:
            self.ctl = E
        if self.env != NULL:
            self.ready = True
            self.ctl.register(self)
            if self.set_current == True and self.IS_REGISTERED():
                self.CURRENT()
            self.CLEAR()
            self.loader = MODLDR(self.name)
            _k = {}
            if kw.has_key("LDR"):
                _k = kw["LDR"]
            self.ready = self.loader.init_user_environment(_k)
            if self.loader.reload() != True:
                self.ready = False
            else:
                self.RESET()
                self.ready = True
        else:
            self.loader = None
            self.ready = False
    def RELOAD(self, _kw, **kw):
        _k = _kw
        if len(kw.keys()) > 0:
            _k = kw
        if self.ready != True:
            raise EnvError, "Environment is not ready for  RELOAD()"
        self.CLEAR()
        self.loader.init_user_environment(_k)
        self.loader.reload()
        self.RESET()
    def IS_REGISTERED(self):
        if self.ready != True:
            raise EnvError, "Environment is not ready for the IS_REGISTERED()"
        return self.ctl.is_registered(self.name)
    def NAME(self):
        return self.name
    def currentModule(self):
        if self.ready != True:
            raise EnvError, "Environment is not ready for the currentModule()"
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
    def CURRENT(self):
        if self.ready != True:
            raise EnvError, "Environment not ready for the CURRENT()"
        if self.IS_REGISTERED() != True:
            return False
        if self.ctl.lock() != True:
            return False
        SetCurrentEnvironment(<void*>self.env)
        self.ctl.set_current(self)
        self.ctl.unlock()
        return True
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
        self.loader.stop()

def MAKE(name=str(uuid.uuid4())):
    global E
    if E.is_registered(name) == True:
        e = E[name]
        e.CURRENT()
        return e
    return ENV(name, set_default=True)
def ADD(name):
    global E
    if E.is_registered(name) == True:
        return E[name]
    return ENV(name, set_default=True)
def CURRENT():
    global E
    return E.current()

