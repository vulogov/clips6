import uuid

cdef class FACT(BASEENV):
    cdef void* fact

    def __cinit__(self):
        BASEENV.Cinit(self)
    cdef create(self, void* env, void* fact):
        BASEENV.Create(self, <void*>env)
        self.fact = fact
        if self.env != NULL and self.fact != NULL:
            EnvIncrementFactCount(self.env, self.fact)
        else:
            self.ready = False
            raise FactError, "FACT() not reaady in create()"
    def Print(self):
        cdef char buf[4096];

        if self.isReady() != True:
            raise FactError, "FACT() is not ready"

        EnvGetFactPPForm(<void*>self.env, <char*>buf, 4096, <void*>self.fact)
        return buf
    def __repr__(self):
        return self.Print()
    def EXISTS(self):
        if self.isReady() != True:
            raise FactError, "FACT() is not ready"
        if EnvFactExistp(<void*>self.env, <void*>self.fact) == 1:
            return True
        return False
    def RETRACT(self):
        if self.isReady() != True:
            raise FactError, "FACT() is not ready"
        if EnvRetract(<void*>self.env, <void*>self.fact) == 1:
            EnvDecrementFactCount(<void*>self.env, <void*>self.fact)
            return True
        return False
    def KEYS(self):
        cdef DATA_OBJECT slots
        cdef void* val

        if self.isReady() != True:
            raise FactError, "FACT() is not ready"
        EnvFactSlotNames(<void*>self.env, <void*>self.fact, &slots)
        if slots.type != MULTIFIELD:
            raise ValueError,"Expected MULTIFIELD, acquired %d"%slots.type
        out = []
        for i in  range(1,GetDOLength(<DATA_OBJECT>slots)+1):
            if GetMFType(<void*>slots.value, i) not in  [SYMBOL, STRING]:
                continue
            val = GetMFValue(<void*>slots.value, i)
            if val == NULL:
                continue
            out.append(ValueToString(val))
        return out
    def __getitem__(self, key):
        cdef DATA_OBJECT data

        if self.isReady() != True:
            raise FactError, "FACT() is not ready"
        keys = self.KEYS()
        if key not in keys:
            raise KeyError,key
        ix = keys.index(key)+1
        if EnvGetFactSlot(<void*>self.env, <void*>self.fact, key, &data) == 1:
            return clp2py(data)
        raise ValueError,key

    def IMPLIED(self):
        cdef DATA_OBJECT data

        if self.isReady() != True:
            raise FactError, "FACT() is not ready"

        if EnvGetFactSlot(<void*>self.env, <void*>self.fact, NULL, &data) == 1:
            return clp2py(data)
        return None
    def __dealloc__(self):
        if self.isReady() == True:
            EnvDecrementFactCount(self.env, self.fact)


cdef class FACTS(BASEENV):
    cdef object transactions
    def __cinit__(self):
        BASEENV.Cinit(self)
        self.transactions = {}
    cdef create(self, void* env):
        BASEENV.Create(self, <void*>env)
    def FACTS(self):
        f = EnvGetNextFact(<void*>self.env, NULL)
        if f == NULL:
            return []
        fact = FACT()
        fact.create(<void*>self.env, <void*>f)
        res = [fact,]
        while True:
            f = EnvGetNextFact(<void*>self.env, <void*>f)
            if f == NULL:
                break
            fact = FACT()
            fact.create(<void*>self.env, <void*>f)
            res.append(fact)
        return res
    def ASSERT(self, fact, trid=None):
        if self.isReady() != True:
            raise FactError, "FACTS() is not ready for Assert"
        if trid == None:
            f = FACT()
            f.create(<void*>self.env, <void*>EnvAssertString(<void*>self.env, fact))
            return f
        else:
            if trid not in self.transactions.keys():
                return False
            self.transactions[trid].append(fact)
            return True
    def ASSERTS(self, facts):
        if EnvLoadFactsFromString(<void*>self.env, facts, -1) == 0:
            return False
        return True
    def BEGIN(self):
        trid = uuid.uuid4()
        self.transactions[trid] = []
        return trid
    def COMMIT(self, trid):
        if trid not in self.transactions.keys():
            return False
        facts = '\n'.join(self.transactions[trid])
        return self.ASSERTS(facts)
