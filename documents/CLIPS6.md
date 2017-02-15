
# clips6 Module


## Data
- `ENVIRONMENTS = []` 
- `FALSE = 0` 
- `ROUTERS = <clips6.ROUTERCTL in...` 
- `TRUE = 1` 

## Functions

##### `check_directory(...)` 

> Check if parameter is directory and we do have READ access to it
> 
> 1. :param dname: Directory name
> 2. :return: True/False



##### `check_directory_write(...)` 

> Check if parameter is directory and we do have WRITE access to it
> 
> 1. :param dname: Directory name
> 2. :return: True/False



##### `check_file(...)` 

> Check if file exists and we can access it.
> 
> 1. :param fname: Filename
> 2. :param mode: Access mode
> 3. :return: True/False



##### `check_file_exec(...)` 

> Check if parameter is a file and we do have EXEC access to it
> 
> 1. :param fname: Filename
> 2. :return: True/False



##### `check_file_read(...)` 

> Check if parameter is a file and we do have READ access to it
> 
> 1. :param fname: Filename
> 2. :return: True/False



##### `check_file_write(...)` 

> Check if parameter is a file and we do have WRITE access to it
> 
> 1. :param fname: Filename
> 2. :return: True/False



##### `check_module(...)` 

> Check if parameter is a file, we do have READ access to it and it's size is greater than '0'
> 
> 1. :param fname: Filename
> 2. :return: True/False



##### `envRegisterIO(...)` 



##### `get_dir_content(...)` 

> Returning the list with directory content to which we do have READ access to
> 
> 1. :param dname: Directory name
> 2. :return: List



##### `rchop(...)` 

> Chopping a string ending:
> 
>     1. thestring: source string
>     2. ending: the tail which shall be removed



##### `repeat(...)` 

> Repeat function X until it returned True, otherwise number of times, with logging
> 
> 1. :param fun: Function
> 2. :param log_fun: Logging function
> 3. :param max_attempts: Maximum number of attempts
> 4. :param msg: Add to a message
> 5. :return: True/False



## clips6.BASEENV Objects



##### `__new__(...)` 

> T.__new__(S, ...) -> a new object with type S, a subtype of T



##### `__pyx_vtable__` 


##### `Cinit` 


##### `isReady` 


## clips6.ENV Objects



##### `__getitem__` 


##### `__new__(...)` 

> T.__new__(S, ...) -> a new object with type S, a subtype of T



##### `__pyx_vtable__` 


##### `BUILD` 


##### `CLEAR` 


##### `DLmodule` 


##### `DropIO` 


##### `FACTS` 


##### `IS_CHANGED` 


##### `LOAD` 


##### `RESET` 


##### `RouterIO` 


##### `SHELL` 


##### `currentModule` 


##### `stop` 


## clips6.EnvError Objects



##### `__qualname__` 


## clips6.EvalError Objects



##### `__qualname__` 


## clips6.FACT Objects



##### `__getitem__` 


##### `__new__(...)` 

> T.__new__(S, ...) -> a new object with type S, a subtype of T



##### `__pyx_vtable__` 


##### `__repr__` 


##### `EXISTS` 


##### `IMPLIED` 


##### `IS_IMPLIED` 


##### `KEYS` 


##### `Print` 


##### `RETRACT` 


## clips6.FACTS Objects



##### `__new__(...)` 

> T.__new__(S, ...) -> a new object with type S, a subtype of T



##### `__pyx_vtable__` 


##### `ASSERT` 


##### `ASSERTS` 


##### `BEGIN` 


##### `COMMIT` 


##### `FACTS` 


##### `stop` 


## clips6.FactError Objects



##### `__qualname__` 


## clips6.MODULE Objects



##### `__new__(...)` 

> T.__new__(S, ...) -> a new object with type S, a subtype of T



##### `__pyx_vtable__` 


##### `__repr__` 


##### `Print` 


##### `currentModule` 


## clips6.ROUTER Objects



##### `__init__(...)` 



##### `__qualname__` 


##### `Read(...)` 



##### `Write(...)` 



##### `read(...)` 



## clips6.ROUTERCTL Objects



##### `__init__(...)` 



##### `__qualname__` 


##### `envRegister(...)` 



##### `isRouter(...)` 



##### `register(...)` 



##### `remove(...)` 



##### `router(...)` 



## clips6.SHELL Objects



##### `__new__(...)` 

> T.__new__(S, ...) -> a new object with type S, a subtype of T



##### `__pyx_vtable__` 


##### `EVAL` 


##### `EXEC` 


##### `RUN` 


##### `STRATEGY` 


## clips6.ShellError Objects



##### `__qualname__` 


## clips6.VOID_PTR Objects



##### `__new__(...)` 

> T.__new__(S, ...) -> a new object with type S, a subtype of T



##### `__pyx_vtable__` 


##### `__repr__` 


##### `isReady` 


##### `object` 

