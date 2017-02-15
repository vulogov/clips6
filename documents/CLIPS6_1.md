||
| 
  
**clips6**|[index](.)
[/srv/shared/Src/clips6/src/clips6.so](file:/srv/shared/Src/clips6/src/clips6.so)|

 
 **Modules**

`      `

 

||
|[\_\_builtin\_\_](__builtin__.html)
 [atexit](atexit.html)|[imp](imp.html)
 [os](os.html)|[posixpath](posixpath.html)
 [uuid](uuid.html)||

 
 **Classes**

`      `

 

[\_\_builtin\_\_.object](__builtin__.html#object)

[BASEENV](clips6.html#BASEENV)

[ENV](clips6.html#ENV)

[FACT](clips6.html#FACT)

[FACTS](clips6.html#FACTS)

[MODULE](clips6.html#MODULE)

[SHELL](clips6.html#SHELL)

[VOID\_PTR](clips6.html#VOID_PTR)

[ROUTER](clips6.html#ROUTER)

[ROUTERCTL](clips6.html#ROUTERCTL)

[exceptions.RuntimeError](exceptions.html#RuntimeError)([exceptions.StandardError](exceptions.html#StandardError))

[EnvError](clips6.html#EnvError)

[EvalError](clips6.html#EvalError)

[FactError](clips6.html#FactError)

[ShellError](clips6.html#ShellError)

 
 class **BASEENV**([\_\_builtin\_\_.object](__builtin__.html#object))

`   `

`BBB `

 

Methods defined here:

**Cinit**(...)

**isReady**(...)

* * * * *

Data and other attributes defined here:

**\_\_new\_\_** = \<built-in method \_\_new\_\_ of type object\>

`T.__new__(S, ...) -> a new object with type S, a subtype of T`

**\_\_pyx\_vtable\_\_** = \<capsule object NULL\>

 
 class **ENV**([BASEENV](clips6.html#BASEENV))

`   `

 

Method resolution order:  
[ENV](clips6.html#ENV)

[BASEENV](clips6.html#BASEENV)

[\_\_builtin\_\_.object](__builtin__.html#object)

* * * * *

Methods defined here:

**BUILD**(...)

**CLEAR**(...)

**DLmodule**(...)

**DropIO**(...)

**FACTS**(...)

**IS\_CHANGED**(...)

**LOAD**(...)

**RESET**(...)

**RouterIO**(...)

**SHELL**(...)

**\_\_getitem\_\_**(...)  
`x.__getitem__(y) <==> x[y]`

**currentModule**(...)

**stop**(...)

* * * * *

Data and other attributes defined here:

**\_\_new\_\_** = \<built-in method \_\_new\_\_ of type object\>

`T.__new__(S, ...) -> a new object with type S, a subtype of T`

**\_\_pyx\_vtable\_\_** = \<capsule object NULL\>

* * * * *

Methods inherited from [BASEENV](clips6.html#BASEENV):

**Cinit**(...)

**isReady**(...)

 
 class **EnvError**([exceptions.RuntimeError](exceptions.html#RuntimeError))

`   `

 

Method resolution order:  
[EnvError](clips6.html#EnvError)

[exceptions.RuntimeError](exceptions.html#RuntimeError)

[exceptions.StandardError](exceptions.html#StandardError)

[exceptions.Exception](exceptions.html#Exception)

[exceptions.BaseException](exceptions.html#BaseException)

[\_\_builtin\_\_.object](__builtin__.html#object)

* * * * *

Data descriptors defined here:

**\_\_weakref\_\_**  
`list of weak references to the object (if defined)`

* * * * *

Data and other attributes defined here:

**\_\_qualname\_\_** = 'EnvError'

* * * * *

Methods inherited from [exceptions.RuntimeError](exceptions.html#RuntimeError):

**\_\_init\_\_**(...)  
`x.__init__(...) initializes x; see help(type(x)) for signature`

* * * * *

Data and other attributes inherited from [exceptions.RuntimeError](exceptions.html#RuntimeError):

**\_\_new\_\_** = \<built-in method \_\_new\_\_ of type object\>

`T.__new__(S, ...) -> a new object with type S, a subtype of T`

* * * * *

Methods inherited from [exceptions.BaseException](exceptions.html#BaseException):

**\_\_delattr\_\_**(...)  
`x.__delattr__('name') <==> del x.name`

**\_\_getattribute\_\_**(...)  
`x.__getattribute__('name') <==> x.name`

**\_\_getitem\_\_**(...)  
`x.__getitem__(y) <==> x[y]`

**\_\_getslice\_\_**(...)  
`x.__getslice__(i, j) <==> x[i:j]   Use of negative indices is not supported.`

**\_\_reduce\_\_**(...)

**\_\_repr\_\_**(...)  
`x.__repr__() <==> repr(x)`

**\_\_setattr\_\_**(...)  
`x.__setattr__('name', value) <==> x.name = value`

**\_\_setstate\_\_**(...)

**\_\_str\_\_**(...)  
`x.__str__() <==> str(x)`

**\_\_unicode\_\_**(...)

* * * * *

Data descriptors inherited from [exceptions.BaseException](exceptions.html#BaseException):

**\_\_dict\_\_**

**args**

**message**

 
 class **EvalError**([exceptions.RuntimeError](exceptions.html#RuntimeError))

`   `

 

Method resolution order:  
[EvalError](clips6.html#EvalError)

[exceptions.RuntimeError](exceptions.html#RuntimeError)

[exceptions.StandardError](exceptions.html#StandardError)

[exceptions.Exception](exceptions.html#Exception)

[exceptions.BaseException](exceptions.html#BaseException)

[\_\_builtin\_\_.object](__builtin__.html#object)

* * * * *

Data descriptors defined here:

**\_\_weakref\_\_**  
`list of weak references to the object (if defined)`

* * * * *

Data and other attributes defined here:

**\_\_qualname\_\_** = 'EvalError'

* * * * *

Methods inherited from [exceptions.RuntimeError](exceptions.html#RuntimeError):

**\_\_init\_\_**(...)  
`x.__init__(...) initializes x; see help(type(x)) for signature`

* * * * *

Data and other attributes inherited from [exceptions.RuntimeError](exceptions.html#RuntimeError):

**\_\_new\_\_** = \<built-in method \_\_new\_\_ of type object\>

`T.__new__(S, ...) -> a new object with type S, a subtype of T`

* * * * *

Methods inherited from [exceptions.BaseException](exceptions.html#BaseException):

**\_\_delattr\_\_**(...)  
`x.__delattr__('name') <==> del x.name`

**\_\_getattribute\_\_**(...)  
`x.__getattribute__('name') <==> x.name`

**\_\_getitem\_\_**(...)  
`x.__getitem__(y) <==> x[y]`

**\_\_getslice\_\_**(...)  
`x.__getslice__(i, j) <==> x[i:j]   Use of negative indices is not supported.`

**\_\_reduce\_\_**(...)

**\_\_repr\_\_**(...)  
`x.__repr__() <==> repr(x)`

**\_\_setattr\_\_**(...)  
`x.__setattr__('name', value) <==> x.name = value`

**\_\_setstate\_\_**(...)

**\_\_str\_\_**(...)  
`x.__str__() <==> str(x)`

**\_\_unicode\_\_**(...)

* * * * *

Data descriptors inherited from [exceptions.BaseException](exceptions.html#BaseException):

**\_\_dict\_\_**

**args**

**message**

 
 class **FACT**([BASEENV](clips6.html#BASEENV))

`   `

 

Method resolution order:  
[FACT](clips6.html#FACT)

[BASEENV](clips6.html#BASEENV)

[\_\_builtin\_\_.object](__builtin__.html#object)

* * * * *

Methods defined here:

**EXISTS**(...)

**IMPLIED**(...)

**IS\_IMPLIED**(...)

**KEYS**(...)

**Print**(...)

**RETRACT**(...)

**\_\_getitem\_\_**(...)  
`x.__getitem__(y) <==> x[y]`

**\_\_repr\_\_**(...)  
`x.__repr__() <==> repr(x)`

* * * * *

Data and other attributes defined here:

**\_\_new\_\_** = \<built-in method \_\_new\_\_ of type object\>

`T.__new__(S, ...) -> a new object with type S, a subtype of T`

**\_\_pyx\_vtable\_\_** = \<capsule object NULL\>

* * * * *

Methods inherited from [BASEENV](clips6.html#BASEENV):

**Cinit**(...)

**isReady**(...)

 
 class **FACTS**([BASEENV](clips6.html#BASEENV))

`   `

 

Method resolution order:  
[FACTS](clips6.html#FACTS)

[BASEENV](clips6.html#BASEENV)

[\_\_builtin\_\_.object](__builtin__.html#object)

* * * * *

Methods defined here:

**ASSERT**(...)

**ASSERTS**(...)

**BEGIN**(...)

**COMMIT**(...)

**FACTS**(...)

**stop**(...)

* * * * *

Data and other attributes defined here:

**\_\_new\_\_** = \<built-in method \_\_new\_\_ of type object\>

`T.__new__(S, ...) -> a new object with type S, a subtype of T`

**\_\_pyx\_vtable\_\_** = \<capsule object NULL\>

* * * * *

Methods inherited from [BASEENV](clips6.html#BASEENV):

**Cinit**(...)

**isReady**(...)

 
 class **FactError**([exceptions.RuntimeError](exceptions.html#RuntimeError))

`   `

 

Method resolution order:  
[FactError](clips6.html#FactError)

[exceptions.RuntimeError](exceptions.html#RuntimeError)

[exceptions.StandardError](exceptions.html#StandardError)

[exceptions.Exception](exceptions.html#Exception)

[exceptions.BaseException](exceptions.html#BaseException)

[\_\_builtin\_\_.object](__builtin__.html#object)

* * * * *

Data descriptors defined here:

**\_\_weakref\_\_**  
`list of weak references to the object (if defined)`

* * * * *

Data and other attributes defined here:

**\_\_qualname\_\_** = 'FactError'

* * * * *

Methods inherited from [exceptions.RuntimeError](exceptions.html#RuntimeError):

**\_\_init\_\_**(...)  
`x.__init__(...) initializes x; see help(type(x)) for signature`

* * * * *

Data and other attributes inherited from [exceptions.RuntimeError](exceptions.html#RuntimeError):

**\_\_new\_\_** = \<built-in method \_\_new\_\_ of type object\>

`T.__new__(S, ...) -> a new object with type S, a subtype of T`

* * * * *

Methods inherited from [exceptions.BaseException](exceptions.html#BaseException):

**\_\_delattr\_\_**(...)  
`x.__delattr__('name') <==> del x.name`

**\_\_getattribute\_\_**(...)  
`x.__getattribute__('name') <==> x.name`

**\_\_getitem\_\_**(...)  
`x.__getitem__(y) <==> x[y]`

**\_\_getslice\_\_**(...)  
`x.__getslice__(i, j) <==> x[i:j]   Use of negative indices is not supported.`

**\_\_reduce\_\_**(...)

**\_\_repr\_\_**(...)  
`x.__repr__() <==> repr(x)`

**\_\_setattr\_\_**(...)  
`x.__setattr__('name', value) <==> x.name = value`

**\_\_setstate\_\_**(...)

**\_\_str\_\_**(...)  
`x.__str__() <==> str(x)`

**\_\_unicode\_\_**(...)

* * * * *

Data descriptors inherited from [exceptions.BaseException](exceptions.html#BaseException):

**\_\_dict\_\_**

**args**

**message**

 
 class **MODULE**([BASEENV](clips6.html#BASEENV))

`   `

 

Method resolution order:  
[MODULE](clips6.html#MODULE)

[BASEENV](clips6.html#BASEENV)

[\_\_builtin\_\_.object](__builtin__.html#object)

* * * * *

Methods defined here:

**Print**(...)

**\_\_repr\_\_**(...)  
`x.__repr__() <==> repr(x)`

**currentModule**(...)

* * * * *

Data and other attributes defined here:

**\_\_new\_\_** = \<built-in method \_\_new\_\_ of type object\>

`T.__new__(S, ...) -> a new object with type S, a subtype of T`

**\_\_pyx\_vtable\_\_** = \<capsule object NULL\>

* * * * *

Methods inherited from [BASEENV](clips6.html#BASEENV):

**Cinit**(...)

**isReady**(...)

 
 class **ROUTER**

`   `

 

Methods defined here:

**Read**(...)

**Write**(...)

**\_\_init\_\_**(...)

**read**(...)

* * * * *

Data and other attributes defined here:

**\_\_qualname\_\_** = 'ROUTER'

 
 class **ROUTERCTL**

`   `

 

Methods defined here:

**\_\_init\_\_**(...)

**envRegister**(...)

**isRouter**(...)

**register**(...)

**remove**(...)

**router**(...)

* * * * *

Data and other attributes defined here:

**\_\_qualname\_\_** = 'ROUTERCTL'

 
 class **SHELL**([BASEENV](clips6.html#BASEENV))

`   `

 

Method resolution order:  
[SHELL](clips6.html#SHELL)

[BASEENV](clips6.html#BASEENV)

[\_\_builtin\_\_.object](__builtin__.html#object)

* * * * *

Methods defined here:

**EVAL**(...)

**EXEC**(...)

**RUN**(...)

**STRATEGY**(...)

* * * * *

Data and other attributes defined here:

**\_\_new\_\_** = \<built-in method \_\_new\_\_ of type object\>

`T.__new__(S, ...) -> a new object with type S, a subtype of T`

**\_\_pyx\_vtable\_\_** = \<capsule object NULL\>

* * * * *

Methods inherited from [BASEENV](clips6.html#BASEENV):

**Cinit**(...)

**isReady**(...)

 
 class **ShellError**([exceptions.RuntimeError](exceptions.html#RuntimeError))

`   `

 

Method resolution order:  
[ShellError](clips6.html#ShellError)

[exceptions.RuntimeError](exceptions.html#RuntimeError)

[exceptions.StandardError](exceptions.html#StandardError)

[exceptions.Exception](exceptions.html#Exception)

[exceptions.BaseException](exceptions.html#BaseException)

[\_\_builtin\_\_.object](__builtin__.html#object)

* * * * *

Data descriptors defined here:

**\_\_weakref\_\_**  
`list of weak references to the object (if defined)`

* * * * *

Data and other attributes defined here:

**\_\_qualname\_\_** = 'ShellError'

* * * * *

Methods inherited from [exceptions.RuntimeError](exceptions.html#RuntimeError):

**\_\_init\_\_**(...)  
`x.__init__(...) initializes x; see help(type(x)) for signature`

* * * * *

Data and other attributes inherited from [exceptions.RuntimeError](exceptions.html#RuntimeError):

**\_\_new\_\_** = \<built-in method \_\_new\_\_ of type object\>

`T.__new__(S, ...) -> a new object with type S, a subtype of T`

* * * * *

Methods inherited from [exceptions.BaseException](exceptions.html#BaseException):

**\_\_delattr\_\_**(...)  
`x.__delattr__('name') <==> del x.name`

**\_\_getattribute\_\_**(...)  
`x.__getattribute__('name') <==> x.name`

**\_\_getitem\_\_**(...)  
`x.__getitem__(y) <==> x[y]`

**\_\_getslice\_\_**(...)  
`x.__getslice__(i, j) <==> x[i:j]   Use of negative indices is not supported.`

**\_\_reduce\_\_**(...)

**\_\_repr\_\_**(...)  
`x.__repr__() <==> repr(x)`

**\_\_setattr\_\_**(...)  
`x.__setattr__('name', value) <==> x.name = value`

**\_\_setstate\_\_**(...)

**\_\_str\_\_**(...)  
`x.__str__() <==> str(x)`

**\_\_unicode\_\_**(...)

* * * * *

Data descriptors inherited from [exceptions.BaseException](exceptions.html#BaseException):

**\_\_dict\_\_**

**args**

**message**

 
 class **VOID\_PTR**([\_\_builtin\_\_.object](__builtin__.html#object))

`   `

 

Methods defined here:

**\_\_repr\_\_**(...)  
`x.__repr__() <==> repr(x)`

**isReady**(...)

**object**(...)

* * * * *

Data and other attributes defined here:

**\_\_new\_\_** = \<built-in method \_\_new\_\_ of type object\>

`T.__new__(S, ...) -> a new object with type S, a subtype of T`

**\_\_pyx\_vtable\_\_** = \<capsule object NULL\>

 
 **Functions**

`      `

 

**check\_directory**(...)  
`Check if parameter is directory and we do have READ access to it   1. :param dname: Directory name 2. :return: True/False`

**check\_directory\_write**(...)  
`Check if parameter is directory and we do have WRITE access to it   1. :param dname: Directory name 2. :return: True/False`

**check\_file**(...)  
`Check if file exists and we can access it.   1. :param fname: Filename 2. :param mode: Access mode 3. :return: True/False`

**check\_file\_exec**(...)  
`Check if parameter is a file and we do have EXEC access to it   1. :param fname: Filename 2. :return: True/False`

**check\_file\_read**(...)  
`Check if parameter is a file and we do have READ access to it   1. :param fname: Filename 2. :return: True/False`

**check\_file\_write**(...)  
`Check if parameter is a file and we do have WRITE access to it   1. :param fname: Filename 2. :return: True/False`

**check\_module**(...)  
`Check if parameter is a file, we do have READ access to it and it's size is greater than '0'   1. :param fname: Filename 2. :return: True/False`

**envRegisterIO**(...)

**get\_dir\_content**(...)  
`Returning the list with directory content to which we do have READ access to   1. :param dname: Directory name 2. :return: List`

**rchop**(...)  
`Chopping a string ending:   1. thestring: source string 2. ending: the tail which shall be removed`

**repeat**(...)  
`Repeat function X until it returned True, otherwise number of times, with logging   1. :param fun: Function 2. :param log_fun: Logging function 3. :param max_attempts: Maximum number of attempts 4. :param msg: Add to a message 5. :return: True/False`

 
 **Data**

`      `

 

**ENVIRONMENTS** = []
 **FALSE** = 0
 **ROUTERS** = \<clips6.ROUTERCTL instance\>
 **TRUE** = 1
 **\_\_test\_\_** = {}
