CMAKE_MINIMUM_REQUIRED( VERSION 2.8.5 )
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ../cmake )
SET(CMAKE_C_FLAGS "-I../clipssrc/src -I. -DCLIPS_MAJOR=6 -DCLIPS_MINOR=30")
SET(CMAKE_MODULE_LINKER_FLAGS "-L../clipssrc/lib -L../clipssrc/src -L/usr/local/lib -lclips")
SET(CMAKE_EXE_LINKER_FLAGS "-L../clipssrc/lib -L../clipssrc/src -L/usr/local/lib -lclips -ldl")

SET(CYTHON_FLAGS ${CYTHON_FLAGS} "-I../include -I.")
EXECUTE_PROCESS( COMMAND python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()" OUTPUT_VARIABLE PYTHON_SITE_PACKAGES OUTPUT_STRIP_TRAILING_WHITESPACE)

INCLUDE( UseCython )
INCLUDE( clips6 )

SET_SOURCE_FILES_PROPERTIES(
  ${CYTHON_CMAKE_EXAMPLE_SOURCE_DIR}/src/clips6.pyx
  PROPERTIES CYTHON_IS_CXX FALSE )
SET_SOURCE_FILES_PROPERTIES(
  ${CYTHON_CMAKE_EXAMPLE_SOURCE_DIR}/src/clips6_cmd.pyx
  PROPERTIES CYTHON_IS_CXX FALSE )

# Multi-file cython modules do not appear to be working at the moment.
CYTHON_ADD_MODULE( clips6 clips6.pyx clips6_dl.c clips6_io.c clips6_f.c )
CYTHON_ADD_STANDALONE_EXECUTABLE( clips6c MAIN_MODULE clips6_cmd.pyx clips6_dl.c clips6_io.c clips6_f.c )


INSTALL(FILES clips6.so ${CMAKE_CURRENT_SOURCE_DIR}/clips6.so DESTINATION ${PYTHON_SITE_PACKAGES} )
INSTALL(FILES clips6c
    ${CMAKE_CURRENT_SOURCE_DIR}/clips6c
    DESTINATION ${CLIPS6_CLIPSBIN_PATH}
    PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
                GROUP_EXECUTE GROUP_READ
                WORLD_EXECUTE WORLD_READ
)
ADD_CUSTOM_TARGET(clips6_module DEPENDS ${PYTHON_SITE_PACKAGES}/clips6.so)
ADD_CUSTOM_TARGET(clips6_cmd DEPENDS clips6c)





