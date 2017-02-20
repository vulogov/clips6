
cdef extern from "clips.h":
    struct dataObject:
        void* supplimentalInfo
        unsigned short type
        void* value
        long begin
        long end
        dataObject* next
    ## DATATYPES
    cdef int FLOAT
    cdef int INTEGER
    cdef int SYMBOL
    cdef int STRING
    cdef int MULTIFIELD
    cdef int EXTERNAL_ADDRESS
    cdef int FACT_ADDRESS
    cdef int INSTANCE_NAME
    ctypedef dataObject DATA_OBJECT
    int EnvArgCountCheck(void* env, char* functionName, int restr, int count)
    int EnvArgRangeCheck(void* env, char* functionName, int min, int max)
    int EnvRtnArgCount(void* env)
    char*    EnvRtnLexeme(void* env, int argumentPosition)
    double   EnvRtnDouble(void* env, int argumentPosition)
    long     EnvRtnLong(void* env, int argumentPosition)
    void*    EnvRtnUnknown(void* env, int argumentPosition, DATA_OBJECT *data)
    ## Datatypes
    char  *ValueToString(void* value)
    double ValueToDouble(void* value)
    long   ValueToLong(void* value)
    int    ValueToInteger(void* value)
    int    GetDOLength(DATA_OBJECT argument)
    int    GetMFType(void* multifieldPtr,int fieldPosition)
    void*  GetMFValue(void* multifieldPtr,int fieldPosition)
    void*  EnvFalseSymbol(void* env)
    void*  EnvTrueSymbol(void* env)

    ## DATATYPES
    cdef int FLOAT
    cdef int INTEGER
    cdef int SYMBOL
    cdef int STRING
    cdef int MULTIFIELD
    cdef int EXTERNAL_ADDRESS
    cdef int FACT_ADDRESS
    cdef int INSTANCE_NAME

    ## Constraint
    cdef int EXACTLY
    cdef int AT_LEAST
    cdef int NO_MORE_THAN
    cdef int RANGE


cdef inline object getPyObjectFromArgs(void* env, char* function, int position):
    cdef object obj
    cdef DATA_OBJECT data

    if EnvArgCountCheck(env, function, AT_LEAST, position) == 0:
        return None
    EnvRtnUnknown(env, position, &data)
    if data.type == EXTERNAL_ADDRESS:
        obj = <object>data.value
        return <object>obj
    return None

cdef inline getArgument(void* env, char* function, int position):
    cdef DATA_OBJECT data

    if EnvArgCountCheck(env, function, AT_LEAST, position) == 0:
        return None
    EnvRtnUnknown(env, position, &data)
    if data.type == FLOAT:
        return EnvRtnDouble(env, position)
    elif data.type == INTEGER:
        return EnvRtnLong(env, position)
    elif data.type in [SYMBOL, STRING]:
        return EnvRtnLexeme(env, position)
    elif data.type == EXTERNAL_ADDRESS:
        return <object>data.value
    elif data.type == MULTIFIELD:
        res = []
        for v in range(1, GetDOLength( < DATA_OBJECT > data) + 1):
            _t = GetMFType( <void *> data.value, v)
            if _t == FLOAT:
                res.append(ValueToDouble( < void * > GetMFValue( < void * > data.value, v)))
            elif _t == INTEGER:
                res.append(ValueToLong( < void * > GetMFValue( < void * > data.value, v)))
            elif _t in [SYMBOL, STRING]:
                res.append(ValueToString( < void * > GetMFValue( < void * > data.value, v)))
            elif _t == EXTERNAL_ADDRESS:
                res.append(<object>GetMFValue(<void*>data.value, v))
            else:
                res.append(None)
        return res
    else:
        return None

cdef inline int TRUE():
    return 1

cdef inline int FALSE():
    return 0
