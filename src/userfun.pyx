import atexit


cdef public void clips6_unload():
    global E

    for _env in E.environments():
        _env.stop()


atexit.register(clips6_unload)

cdef public void EnvUserFunctions(void *env):
    return



cdef public void UserFunctions(void *env):
    return

