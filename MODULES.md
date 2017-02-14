# clips6 Extension modules

The principal feature of the clips6 module, is an ability of the code developer to extend functionality of the embedded CLIPS engine with a cusom code. Before clips6, there were two ways of how you can create extentions for the CLIPS:

1. Out-of-box "C" functions. This is a feature of the CLIPS itself, well documented in "Advanced Programming Guide" of the CLIPS;
2. Python functions called through _(python-call ....)_ function of the PyClips Python module

### What's wrong with "C"-coded extentions ?

Nothing. Absolutely nothing. If you do have a time and luxery of writing, debugging and supporting of "C"-code, this is really way to go. In fact, you are still able to use "C"-coded extension functions with *clips6*. The main disadvantage of this method is a complexity of writing and supporting "C" code.

### What's wrong with _(python-call ...)_ ?

Also, generally nothing. Although, due to the specifics of the implementation of the PyCLIPS module, you can only use Python functions which could be compuled into internal Python bytecodes. Whcih puts a restrains on what kind of code you want to integrate. Next problem, of that approach lies with the fact that PyClips doesn't provide you a robust way for your Python code to pass references through CLIPS. For example: you can not open database connection, store the reference in the fact slot and then use this reference in subsequent calls. You can not do it, without using globals, which is a not the best way to do it. Also, visually _(python-call function param param ...)_ is not aestetically appealing, compare to a _(function param param...)_

### How the clips6 approaches this problem ?

clips6 uses "mixed" approach. While permitting you to create functions using Python, it utilize the fact, that the Cython can compile Python function into "C" function, which could be compiled, linked to a shared library and then loaded.

### What to know more ?

1. [Architecture](MODULES-ARCH.md) of the clips6 loadable modules;
2. [Anathomy](MODULES-AN.md) of the clips6 loadable module;
3. [Build environment](MODULES-CMAKE.md) for the clips6 loadable module.
