# How to build the module

First, please take a look at the [sample module](modules/dummy) which does not depend on the clips6 source code

When you build and install clips6 module, there are certain files, necessary for the extention module build, will be installed in _/usr/local/lib/clips6/build_. Exact locatin of this root could be changed by editing [this](cmake/clips6.cmake) file.

So, when you are ready to develop your own clips6 module, you have to create _CMakeLists.txt_. You can look at [this](modules/dummy/CMakeLists.txt) file as your reference. So, your steps will be as follows:

1. Create your source code in a single (or multiple) _*.pyx_ files. If you are using multiple files, please make sure that they are part of your module build.
2. Create _CMakeLists.txt_
3. Run _cmake ._
4. If step #3 returns no errors, run _make_
5. If step #4 returns no errors, run _make install_

Now, let's look at the commented version of the _CMakeLists.txt

```cmake
##
## Version requirement restriction for the CMake
##
CMAKE_MINIMUM_REQUIRED( VERSION 2.8.5 )

##
## Adjust for your clips6 installation directory
##
SET(CLIPS6_LOCAL_ROOT /usr/local )
##
## Adjust this variable to point on where your clips6 build invironment files are
##
SET(CLIPS6_BUILD_ROOT ${CLIPS6_LOCAL_ROOT}/lib/clips6/build )

##
## Now, add clips6 CMake directory to the list of the CMake module directories
##
SET( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CLIPS6_BUILD_ROOT}/cmake )

##
## We are using cython for build and will include some global variables
## Please adjust ${CLIPS6_BUILD_ROOT}/cmake/clips6.cmake as needed
##
INCLUDE( UseCython )
INCLUDE( clips6 )

##
## Location of the *.pyi files required for the build
##
SET(PYTHON_INCLUDE_DIRS ${PYTHON_INCLUDE_DIRS} ${CLIPS6_BUILD_ROOT}/include )

##
## Flags for the linker
##
SET(CMAKE_SHARED_LINKER_FLAGS "-L${CLIPS6_LOCAL_ROOT}/lib  -lclips")
SET(CMAKE_MODULE_LINKER_FLAGS "-L${CLIPS6_LOCAL_ROOT}/lib  -lclips")
##
## Flags for the gcc compiler
##
SET(CMAKE_C_FLAGS "-I${CLIPS6_INCLUDE_PATH} -DCLIPS_MAJOR=6 -DCLIPS_MINOR=30")

##
## Flags for the Cython compiler
##
SET(CYTHON_FLAGS ${CYTHON_FLAGS} "-I${CLIPS6_BUILD_ROOT}/include")

##
## Source code properties
##
set_source_files_properties(
  dummy.pyx
  PROPERTIES CYTHON_IS_CXX FALSE )

##
## Instructions for building the module
##
CYTHON_ADD_MODULE( dummy dummy.pyx )

##
## Instruction for the module installation
##
INSTALL(FILES dummy.so dummy.so DESTINATION ${CLIPS6_MODULE_PATH} )

```

Go [back](MODULES.md) to the modules documentation.