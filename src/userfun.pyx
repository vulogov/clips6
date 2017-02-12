import atexit

ENVIRONMENTS=[]

cdef public void clips6_unload():
    global ENVIRONMENTS

    DeallocateEnvironmentData()
    for _env in ENVIRONMENTS:
        _env.stop()

atexit.register(clips6_unload)

cdef public void EnvUserFunctions(void *env):
    #print "EnvUserFunction()"
    return



cdef public void UserFunctions(void *env):
    #print "UserFunction()"
    return

