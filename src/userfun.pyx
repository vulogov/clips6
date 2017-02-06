cdef void EnvUserFunctions(void *env):
    print "EnvUserFunction()"
    return

cdef void UserFunctions(void *env):
    print "UserFunction()"
    return

