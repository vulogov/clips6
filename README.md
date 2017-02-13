# clips6 - new way of using CLIPS Rule-Based Expert system with Python.

---

### Acknowledgements

1. Guido van Rossum for the Python programming language.
2. Robert Bradshaw, Stefan Behnel, et all for the Cython
3. NASA (and a taxpayers of USA) for the sponsorship and initial CLIPS development. And for the excellent documentation
4. [CLIPS community](http://clipsrules.sourceforge.net/)
5. Joseph C. Giarratano and Gary D. Riley for the book ["Expert Systems: Principles and Programming, Fourth Edition"](https://www.amazon.com/exec/obidos/tg/detail/-/0534384471/)
6. Francesco Garosi/JKS for the [PyCLIPS module](http://pyclips.sourceforge.net/web/)

### What **IS** the clips6 ?

[clips6](https://github.com/vulogov/clips6) is "yet another" Python module which will help you to integrate the functionality of the CLIPS Expert System Engine in your Python code. The main aims of this module are:

1. Do not re-implement the CLIPS API from [APG Book](http://clipsrules.sourceforge.net/documentation/v630/apg.pdf) but rather help developers to solve an actual problems
2. Provide better capabilities for integration of the user code inside CLIPS engine. Unlike *PyCLIPS*, *clips6* allows you to create and compile modules, using [Cython](http://www.cython.org), which is better than use _(python-call ...)_ in *PyCLIPS*

### What the clisp6 **IS NOT**

1. It is not a full-scale user-oriented application (yet), but rather tool for the developers

### What shall I do next ?

1. Read [Installation instructions](INSTALL.md)
