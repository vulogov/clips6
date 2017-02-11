import atexit



class ROUTER:
    def __init__(self):
        self.c = -1
        self.buffer = ""
    def read(self):
        return self.buffer
    def Read(self):
        out = self.buffer
        self.buffer = ""
        return out
    def Write(self, buf):
        self.buffer = self.buffer + buf
class ROUTERCTL:
    def __init__(self):
        self.routers = {}
    def register(self, name):
        if name not in self.routers.keys():
            self.routers[name] = ROUTER()
            return True
        return False
    def remove(self, name):
        if name not in self.routers.keys():
            return False
        del self.routers[name]
        return True
    def router(self, name):
        if name not in self.routers.keys():
            return self.routers[name]
        return None

ROUTERS = ROUTERCTL()

cdef public void clips6_bufrouters_unload():
    global ROUTERS

    for r in ROUTERS.routers.keys():
        ROUTERS.remove(r)



atexit.register(clips6_bufrouters_unload)

cdef extern int _RegisterIO(char *logicalName)

def  RegisterIO(logicalName):
    global ROUTERS

    ## First, regitster IO buffer in ROUTERS
    if ROUTERS.register(logicalName) == True:
        ## Then let the CLIPS know that the buffer exists
        if _RegisterIO(logicalName) == 1:
            return 1
    return 0


cdef public int  FindCLP6IO(void *theEnv, char *logicalName):
    global ROUTERS

    if ROUTERS.routers.has_key(logicalName) == True:
        return (TRUE)
    return (FALSE)

cdef public int  ExitCLP6IO(void *theEnv, int code):
    global ROUTERS

    clips6_bufrouters_unload()

cdef public int  PrintCLP6IO(void *theEnv,const char *logicalName,const char *buffer):
    global ROUTERS

    r = ROUTERS.router(logicalName)
    if r == None:
        return (FALSE)
    r.Write(buffer)
    return (TRUE)

cdef public int  GetcCLP6IO(void *theEnv,const char *logicalName):
    global ROUTERS

    r = ROUTERS.router(logicalName)
    if r == None or r.c == -1:
        return (FALSE)
    try:
        ret = ord(r.buffer[r.c])
        r.c += 1
        return ret
    except:
        return -1
    return (TRUE)

cdef public int  UngetcCLP6IO(void *theEnv,int param, const char *logicalName):
    global ROUTERS

    r = ROUTERS.router(logicalName)
    if r == None:
        return (FALSE)
    r.buffer = r.buffer + chr(param)
    return (TRUE)