cdef public void EnvUserFunctions(void *env):
    print "EnvUserFunction()"



cdef public void UserFunctions(void *env):
    print "UserFunction()"
    return

