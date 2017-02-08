## Work with functions
cdef extern char* clips6_dl(void* env, char *dl_name, char *symname, char *fun_name, char *params, char *retval)



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
    def __repr__(self):
        return "<CLP:VOID *0x%x>"%<int>self.data

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


class EvalError(RuntimeError):
    pass
class ShellError(RuntimeError):
    pass
class FactError(RuntimeError):
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
    int   Load(void* env, char* name)
    int   Build(void* env, char* constructString)
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
    void *AssertString(void* env, char* fact)
    void * AssertString(void * env, char * fact)
    int  LoadFactsFromString(void* env, char* nputString,int maximumPosition)
    void PPFact(void* factPtr,char* logicalName,int ignoreDefaultFlag)
    void  GetFactPPForm(void* env, char* buffer,int bufferLength,void* factPtr)
    void IncrementFactCount(void* env, void* fact)
    void DecrementFactCount(void* env, void* fact)
    long  FactExistp(void* env, void* factPtr);
    void *GetNextFact(void* env, void* factPtr);
    int  Retract(void* env, void* factPtr)
    int GetFactListChanged(void* env)
    void SetFactListChanged(void* env, int changedFlag)
    void FactSlotNames(void* env, void* factPtr, DATA_OBJECT* theValue)
    int GetFactSlot(void* env, void* factPtr, char* slotName, DATA_OBJECT* theValue)
    ## Work with evaluations
    int EnvEval(void* env, char* expressionString, DATA_OBJECT* result)
    ## Work with the routers
    void  InitializeDefaultRouters(void *)
    int   DeactivateRouter(void* env, char *routerName)
    int   ActivateRouter(void* env, char *routerName)
    ## Debug functions
    int   Watch(void* env, char* item)
    int   Unwatch(void* env, char* item)
    long  MemUsed(void* env)

