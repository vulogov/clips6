cmake_minimum_required( VERSION 2.8.5 )
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ../../cmake )
SET( PYTHON_INCLUDE_DIRS ${PYTHON_INCLUDE_DIRS} ../../include )
SET(CMAKE_C_FLAGS "-I../../clipssrc/src -DCLIPS_MAJOR=6 -DCLIPS_MINOR=30")
SET(CMAKE_MODULE_LINKER_FLAGS "-lclips")
SET(CYTHON_FLAGS ${CYTHON_FLAGS} "-I../../include")
SET(CMAKE_MODULE_LINKER_FLAGS "-L../../clipssrc/lib -L../clipssrc/lib -L/usr/local/lib -lclips")

include( UseCython )
include( clips6 )

set_source_files_properties(
  ${CYTHON_CMAKE_EXAMPLE_SOURCE_DIR}/modules/testmodule/testmod.pyx
  PROPERTIES CYTHON_IS_CXX FALSE )

# Multi-file cython modules do not appear to be working at the moment.
cython_add_module( testmod testmod.pyx )

install(FILES testmod.so testmod.so DESTINATION ${CLIPS6_MODULE_PATH} )




