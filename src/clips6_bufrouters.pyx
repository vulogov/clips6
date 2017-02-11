class ROUTER:
    def __init__(self):
        self.buffer = ""
class ROUTERCTL:
    def __init__(self):
        self.routers = {}
    def register(self, name):
        if name not in self.routers.keys():
            self.routers[name] = ROUTER()
        return self.routers[name]
    def remove(self name):
        if name not in self.routers.keys():
            return False
        del self.routers[name]
        return True
    def router(self, name):
        if name not self.routers.keys():
            return self.routers[name]
        return None

routers = ROUTERCTL()

cdef public clips6_create_buf_router(char *logicalname):
    return 1