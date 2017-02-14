from cpython.cobject cimport PyCObject_FromVoidPtr

## Work with functions
cdef extern char* clips6_dl(void* env, char *dl_name, char *symname, char *fun_name, char *params, char *retval)
cdef extern int clips6_function_int(void *env, char *dl_name, char *symname)



cdef extern from "clips.h":
    struct dataObject:
        void* supplimentalInfo
        unsigned short type
        void* value
        long begin
        long end
        dataObject* next
    ctypedef dataObject DATA_OBJECT
    ## DATATYPES
    cdef int FLOAT
    cdef int INTEGER
    cdef int SYMBOL
    cdef int STRING
    cdef int MULTIFIELD
    cdef int EXTERNAL_ADDRESS
    cdef int FACT_ADDRESS
    cdef int INSTANCE_NAME
    ## STRATEGY
    cdef int DEPTH_STRATEGY
    cdef int BREADTH_STRATEGY
    cdef int LEX_STRATEGY
    cdef int MEA_STRATEGY
    cdef int COMPLEXITY_STRATEGY
    cdef int SIMPLICITY_STRATEGY
    cdef int RANDOM_STRATEGY


##
## Service structs and classes
##
cdef class VOID_PTR:
    cdef void* data
    def __cinit__(self):
        self.data = NULL
    def isReady(self):
        if self.data == NULL:
            return False
        return True
    cdef set(self, void* ptr):
        self.data = ptr
    cdef void* get(self):
        return self.data
    def object(self):
        if self.data == NULL:
            raise ShellError, "Can not convert NULL pointer to a Python object"
        return PyCObject_FromVoidPtr(self.data, NULL)
    def __repr__(self):
        return "<CLP:VOID *0x%x>"%<unsigned long>self.data

##
## STRATEGY modes
##

_DEPTH_STRATEGY=DEPTH_STRATEGY
_BREADTH_STRATEGY=BREADTH_STRATEGY
_LEX_STRATEGY=LEX_STRATEGY
_MEA_STRATEGY=MEA_STRATEGY
_COMPLEXITY_STRATEGY=COMPLEXITY_STRATEGY
_SIMPLICITY_STRATEGY=SIMPLICITY_STRATEGY
_RANDOM_STRATEGY=RANDOM_STRATEGY
TRUE=1
FALSE=0


class EvalError(RuntimeError):
    pass
class ShellError(RuntimeError):
    pass
class FactError(RuntimeError):
    pass
class EnvError(RuntimeError):
    pass


cdef extern from "commline.h":
    int RouteCommand(void* env, char* cmd, int printResult)
    void FlushPPBuffer(void * theEnv)

cdef extern from "clips.h":
    ## Datatypes
    char  *ValueToString(void* value)
    double ValueToDouble(void* value)
    long   ValueToLong(void* value)
    int    ValueToInteger(void* value)
    int    GetDOLength(DATA_OBJECT argument)
    int    GetMFType(void* multifieldPtr,int fieldPosition)
    void*  GetMFValue(void* multifieldPtr,int fieldPosition)
    ## Work with Environment
    void* CreateEnvironment()
    int   DeallocateEnvironmentData()
    int   DestroyEnvironment(void* theEnv)
    void  EnvClear(void* env)
    void  EnvReset(void* env)
    int   EnvLoad(void* env, char* name)
    int   EnvBuild(void* env, char* constructString)
    long int EnvRun(void* env, long runLimit)
    int   EnvSetStrategy(void* env, int value)
    int   EnvGetStrategy(void* env)
    ## Work with modules
    void *EnvGetCurrentModule(void* env)
    void *EnvSetCurrentModule(void* env, void* defmodulePtr)
    void *EnvFindDefmodule(void* env, char* defmoduleName)
    char *EnvGetDefmoduleName(void* env, void* defmodulePtr)
    char *EnvGetDefmodulePPForm(void* env, void* defmodulePtr)
    ## Work with Facts
    void *EnvAssertString(void* env, char* fact)
    void * EnvAssertString(void * env, char * fact)
    int  EnvLoadFactsFromString(void* env, char* nputString,int maximumPosition)
    void EnvPPFact(void* factPtr,char* logicalName,int ignoreDefaultFlag)
    void  EnvGetFactPPForm(void* env, char* buffer,int bufferLength,void* factPtr)
    void EnvIncrementFactCount(void* env, void* fact)
    void EnvDecrementFactCount(void* env, void* fact)
    long  EnvFactExistp(void* env, void* factPtr);
    void *EnvGetNextFact(void* env, void* factPtr);
    int  EnvRetract(void* env, void* factPtr)
    int EnvGetFactListChanged(void* env)
    void EnvSetFactListChanged(void* env, int changedFlag)
    void EnvFactSlotNames(void* env, void* factPtr, DATA_OBJECT* theValue)
    int EnvGetFactSlot(void* env, void* factPtr, char* slotName, DATA_OBJECT* theValue)
    ## Work with evaluations
    int EnvEval(void* env, char* expressionString, DATA_OBJECT* result)
    ## Work with the routers
    void  InitializeDefaultRouters(void *)
    int   EnvDeactivateRouter(void* env, char *routerName)
    int   EnvActivateRouter(void* env, char *routerName)
    ## Debug functions
    int   EnvWatch(void* env, char* item)
    int   EnvUnwatch(void* env, char* item)
    long  EnvMemUsed(void* env)

cdef extern from "clips6_io.h":
    int RegisterIO(void *theEnv, char *logicalName)
    int cRegisterIO(void *theEnv, char *logicalName)
    int DropIO(void *theEnv, char *logicalName)
    int cDropIO(void *theEnv, char *logicalName)

cdef extern from "clips6_f.h":
    int  cIsImplied(void* fact)