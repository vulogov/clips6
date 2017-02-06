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
