from cpython.cobject cimport PyCObject_FromVoidPtr

cdef  class VOID_PTR:
     cdef void* data
     def  __cinit__(self):
         self.data = NULL
     def isReady(self):
         if self.data == NULL:
             return False
         return True
     #@staticmethod
     cdef  set(self, void* ptr):
         self.data = ptr
     cdef  inline void* get(self):
         return <void*>self.data
     def object(self):
         if self.data == NULL:
             raise ShellError, "Can not convert NULL pointer to a Python object"
         return PyCObject_FromVoidPtr(self.data, NULL)
     def __repr__(self):
         return "<CLP:VOID *0x%x>"%<unsigned long>self.data

cdef inline Environment(void* env):
    from clips6 import E
    print E.default
    return None
