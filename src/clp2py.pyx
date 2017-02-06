cdef clp2py(DATA_OBJECT data):

    cdef VOID_PTR vdata = VOID_PTR()

    if data.type == FLOAT:
        return ValueToDouble(<void*>data.value)
    elif data.type == INTEGER:
        return ValueToLong(<void*>data.value)
    elif data.type in [SYMBOL, STRING]:
        return ValueToString(<void*>data.value)
    elif data.type == MULTIFIELD:
        res = []
        for v in range(1,GetDOLength(<DATA_OBJECT>data)+1):
            _t = GetMFType(<void*>data.value,v)
            if _t == FLOAT:
                res.append(ValueToDouble(<void*>GetMFValue(<void*>data.value, v)))
            elif _t == INTEGER:
                res.append(ValueToLong(<void*>GetMFValue(<void*>data.value, v)))
            elif _t in [SYMBOL, STRING]:
                res.append(ValueToString(<void*>GetMFValue(<void*>data.value, v)))
        return res
    elif data.type == EXTERNAL_ADDRESS:
        vdata.data = <void*>data.value
        return vdata
    else:
        return None
