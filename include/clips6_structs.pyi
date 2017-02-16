from cpython.cobject cimport PyCObject_FromVoidPtr

cdef  class VOID_PTR:
    cdef void* data
    def  __cinit__(self):
        self.data = NULL
    def isReady(self):
        if self.data == NULL:
            return False
        return True
    cdef  set(self, void* ptr):
        self.data = ptr
    cdef  void* get(self):
        return <void*>self.data
    def object(self):
        if self.data == NULL:
            raise ShellError, "Can not convert NULL pointer to a Python object"
        return PyCObject_FromVoidPtr(self.data, NULL)
    def __repr__(self):
        return "<CLP:VOID *0x%x>"%<unsigned long>self.data

cdef  Environment(void* env):
    from clips6 import ENV
    e_ptr = VOID_PTR()
    e_ptr.set(env)
    e = ENV(False)
    e.Derive(e_ptr)
    return e
