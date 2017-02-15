# Installation instructions for the CLIPS-Python integration module
------

## Pre-requirements

1. You shall have a Python installed on your build host. Currently, module has been tested with Python 2.7, but can be built for Python 3 without problems.
2. In order to build this module, you shall have Cython  version not less than 0.25.1 Install Cython using pip or build Cython from the sources obtainable from [Cython web site](http://www.cython.org)
3. cmake version at least 2.8.5 Install cmake using your system package management tools, such as yum or apt-get
4. Of course, *git* tools.

## Installation steps

1. Check-out as _git clone https://github.com/vulogov/clips6.git_ 
2. Choose the directory in which you will install clips6 extention modules. Default is _/usr/local/lib/clips6_ If you do not like this default, change *CMake* variable *CLIPS6_MODULE_PATH* in file _./cmake/clips6.cmake_
3. Generate makefiles by running _cmake ._ (mind the "dot" in cmake command) from the root of the project
4. You will not be needed to install Clips source code. It is provided for you in _./clipssrc_ Currently, I am supporting CLIPS 6.30. Feel free to use your own CLIPS sourcebase, but put aside _main.c_ and _usrfun.c_ as they will interfere with build
5. Please make sure that the defaut location for the shared libraries _/usr/local/lib_ is a part of your *LD_SO_CONF* configuration. If you do not know what this is, talk to your system administrator.
6. If Step #3 produce no errors, go ahead and run make as _make_
7. If make doesn't produced any errors, run _make install_
8. If everything is error-free on Step #7, you may want to run _ldconfig -v_ in order to make _libclips.so_ known to *LD_SO_CONF*
9. Run the *Test Suite* as _make testsuite_
10. If Step #9 returns you *OK*, your new clips6 module is succesfully built and installed. Welcome to the world of *CLIPS* !

