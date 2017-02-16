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
  example.pyx
  PROPERTIES CYTHON_IS_CXX FALSE )

##
## Instructions for building the module
##
CYTHON_ADD_MODULE( example example.pyx )

##
## Instruction for the module installation
##
INSTALL(FILES example.so example.so DESTINATION ${CLIPS6_MODULE_PATH}/example )
INSTALL(FILES example.clp example.clp DESTINATION ${CLIPS6_MODULE_PATH}/example )
INSTALL(FILES example.module example.module DESTINATION ${CLIPS6_MODULE_PATH}/example )






