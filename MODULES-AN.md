# What is clips6 extension module looks like

### Anatomy of the function
Since the CLIPS impose very specific requirements on what's the extention function shall looks like, the functions which wiol be exposed from the module, must be a defined like this:

```python
cdef public <return type> <function name>(void* env)
```
By looking at this declaration, we can tell: 
1. That this Python function will be available from "C";
2. It will be a "public" function. Cython will preserve the name of the function on the "C" level as it defined on Python level;
3. Reference to the CLIPS environment will be passed as a first (and only) parameter;
4. You must declare the return value.

### What is the module directory ?

Module directory, is a global module-wide dictionary with the name **CLIPS6_MODULE**. The keys for the dictionary are the name of the fuctions as they will be registered within CLIPS. The value for this key is an array, with following data:
0. name of the function in this module _(string)_
1. parameters passed to this function _(string)_
2. return value _(string)_

At this time, we do support the following data types:
1. Numbers. Integers and Floats;
2. Strings;
3. Symbols;
4. *MULTIFIELD* values. Only Numbers, Strings and Symbols supported inside *MULTIFIELD*
5. External addresses.

*Example:*

```python
{"myFunction":["myfunction","s","i"]}
```
If this example, the function _myfunction_ which defined in this module, will be registered with CLIPS with name _myFunction_. It will be accepting _String_ parameter and return an _Integer_.


### Initialization of the module

Go [back](MODULES.md) to the modules documentation.