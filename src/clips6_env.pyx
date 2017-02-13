cdef class BASEENV:
	cdef void * env
	cdef object ready

	def Cinit(self):
		self.ready = False
		self.env = NULL
	def isReady(self):
		if self.env == NULL:
			return False
		return self.ready
	cdef Create(self, void * env):
		if env != NULL:
			self.env = env
			self.ready = True

cdef class ENV(BASEENV):
	def __cinit__(self):
		global ENVIRONMENTS
		BASEENV.Cinit(self)
		self.env = <void*>CreateEnvironment()
		if self.env != NULL:
			self.ready = True
			ENVIRONMENTS.append(self)
	def currentModule(self):
		m = MODULE()
		m.create( < void * > self.env, <void *>EnvGetCurrentModule( <void *>self.env))
		return m

	def __getitem__(self, key):
		_m = <void *>EnvFindDefmodule( < void * > self.env, key)
		if _m == NULL:
			raise KeyError, key
		else:
			m = MODULE()
			m.create( <void *> self.env, <void *>_m)
			return m
	def RouterIO(self, logicalName):
		DropIO(self.env, logicalName)
		res = RegisterIO(self.env, logicalName)
		if res == 1:
			envRegisterIO(self, logicalName)
			return True
		return False
	def DropIO(self, logicalName):
		if DropIO(self.env, logicalName) == 1:
			return True
		return False
	def DLmodule(self, module):
		return clips6_load_module(self.env, module)
	def SHELL(self):
		if self.ready != True:
			return None
		s = SHELL()
		s.create(<void*>self.env)
		return s
	def IS_CHANGED(self):
		if EnvGetFactListChanged( <void *>self.env) == 0:
			return False
		EnvSetFactListChanged( <void *>self.env, 0)
		return True

	def CLEAR(self):
		EnvClear( <void *>self.env)
	def RESET(self):
		EnvReset( <void *> self.env)
	def LOAD(self, name):
		if name != None and check_file_read(name):
			if EnvLoad( <void *>self.env, name) == 1:
				return True
		return False
	def BUILD(self, constr):
		if EnvBuild( <void *> self.env, constr) == 1:
			return True
		return False

	def FACTS(self):
		if self.ready != True:
			return None
		f = FACTS()
		f.create( < void * > self.env)
		return f

	def stop(self):
		if self.ready == True:
			DestroyEnvironment(<void*>self.env)
