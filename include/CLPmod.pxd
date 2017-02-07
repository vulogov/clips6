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
    int ArgCountCheck(void* env, char* functionName, int restr, int count)
    int ArgRangeCheck(void* env, char* functionName, int min, int max)
    int RtnArgCount(void* env)
    char*    RtnLexeme(void* env, int argumentPosition)
    double   RtnDouble(void* env, int argumentPosition)
    long     RtnLong(void* env, int argumentPosition)
    void*    RtnUnknown(void* env, int argumentPosition, DATA_OBJECT *data)
    ## Datatypes
    char  *ValueToString(void* value)
    double ValueToDouble(void* value)
    long   ValueToLong(void* value)
    int    ValueToInteger(void* value)
    int    GetDOLength(DATA_OBJECT argument)
    int    GetMFType(void* multifieldPtr,int fieldPosition)
    void*  GetMFValue(void* multifieldPtr,int fieldPosition)

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

    if ArgCountCheck(env, function, AT_LEAST, position) == 0:
        return None
    RtnUnknown(env, position, &data)
    if data.type == EXTERNAL_ADDRESS:
        obj = <object>data.value
        return <object>obj
    return None

cdef inline getArgument(void* env, char* function, int position):
    cdef DATA_OBJECT data

    if ArgCountCheck(env, function, AT_LEAST, position) == 0:
        return None
    RtnUnknown(env, position, &data)
    if data.type == FLOAT:
        return RtnDouble(env, position)
    elif data.type == INTEGER:
        return RtnLong(env, position)
    elif data.type in [SYMBOL, STRING]:
        return RtnLexeme(env, position)
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
