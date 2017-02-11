cmake_minimum_required( VERSION 2.8.5 )
SET(CMAKE_C_FLAGS "-I../clipssrc/src -I. -DCLIPS_MAJOR=6 -DCLIPS_MINOR=30")
SET(CMAKE_MODULE_LINKER_FLAGS "-L../clipssrc/src -L/usr/local/lib -lclips")
SET(CYTHON_FLAGS ${CYTHON_FLAGS} "-I../include -I.")
execute_process ( COMMAND python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()" OUTPUT_VARIABLE PYTHON_SITE_PACKAGES OUTPUT_STRIP_TRAILING_WHITESPACE)
USE( UseCython )

set_source_files_properties(
  ${CYTHON_CMAKE_EXAMPLE_SOURCE_DIR}/src/clips6.pyx
  PROPERTIES CYTHON_IS_CXX FALSE )

# Multi-file cython modules do not appear to be working at the moment.
cython_add_module( clips6 clips6.pyx clips6_dl.c clips6_io.c )

install(FILES clips6.so ${CMAKE_CURRENT_SOURCE_DIR}/clips6.so DESTINATION ${PYTHON_SITE_PACKAGES} )




