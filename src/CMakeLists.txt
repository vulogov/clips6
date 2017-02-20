CMAKE_MINIMUM_REQUIRED( VERSION 2.8.5 )
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ../cmake )
SET(CMAKE_C_FLAGS "-I../clipssrc/src -I. -DCLIPS_MAJOR=6 -DCLIPS_MINOR=30")
SET(CMAKE_MODULE_LINKER_FLAGS "-L../clipssrc/lib -L../clipssrc/src -L/usr/local/lib -lclips")
SET(CMAKE_EXE_LINKER_FLAGS "-L../clipssrc/lib -L../clipssrc/src -L/usr/local/lib -lclips -ldl")
#FILE(WRITE clips6_build_defaults.pyx "CLIPS6_DEFAULT_MODULEPATH=${${CLIPS6_MODULE_PATH}}")
FILE(GLOB ALL_MY_CIRCUIT "*.pyx")

EXECUTE_PROCESS( COMMAND python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()" OUTPUT_VARIABLE PYTHON_SITE_PACKAGES OUTPUT_STRIP_TRAILING_WHITESPACE)

INCLUDE( UseCython )
INCLUDE( clips6 )

SET(CYTHON_FLAGS ${CYTHON_FLAGS} "-I${CLIPS6_BUILDLIBRARY_PATH}/include")
SET(CYTHON_FLAGS ${CYTHON_FLAGS} "-I../include")
SET(CYTHON_FLAGS ${CYTHON_FLAGS} "-I.")


SET_SOURCE_FILES_PROPERTIES(
  ${CYTHON_CMAKE_EXAMPLE_SOURCE_DIR}/src/clips6.pyx
  PROPERTIES CYTHON_IS_CXX FALSE )
SET_SOURCE_FILES_PROPERTIES(
  ${CYTHON_CMAKE_EXAMPLE_SOURCE_DIR}/src/clips6_cmd.pyx
  PROPERTIES CYTHON_IS_CXX FALSE )
SET_SOURCE_FILES_PROPERTIES(
  ${CYTHON_CMAKE_EXAMPLE_SOURCE_DIR}/src/clips6_pkg.pyx
  PROPERTIES CYTHON_IS_CXX FALSE )




# Multi-file cython modules do not appear to be working at the moment.
CYTHON_ADD_MODULE( clips6 clips6.pyx clips6_dl.c clips6_io.c clips6_f.c )
CYTHON_ADD_STANDALONE_EXECUTABLE( clips6c MAIN_MODULE clips6_cmd.pyx clips6_dl.c clips6_io.c clips6_f.c )
CYTHON_ADD_STANDALONE_EXECUTABLE( clips6pkg MAIN_MODULE clips6_pkg.pyx clips6_dl.c clips6_io.c clips6_f.c )



INSTALL(FILES clips6.so ${CMAKE_CURRENT_SOURCE_DIR}/clips6.so DESTINATION ${PYTHON_SITE_PACKAGES} )
INSTALL(FILES clips6c
    ${CMAKE_CURRENT_SOURCE_DIR}/clips6c
    DESTINATION ${CLIPS6_CLIPSBIN_PATH}
    PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
                GROUP_EXECUTE GROUP_READ
                WORLD_EXECUTE WORLD_READ
)
INSTALL(FILES clips6pkg
    ${CMAKE_CURRENT_SOURCE_DIR}/clips6pkg
    DESTINATION ${CLIPS6_CLIPSBIN_PATH}
    PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
                GROUP_EXECUTE GROUP_READ
                WORLD_EXECUTE WORLD_READ
)

INSTALL(CODE "MESSAGE(\"Installing required modules.\")")
INSTALL(CODE "EXECUTE_PROCESS(COMMAND pip install msgpack-python)")
INSTALL(CODE "EXECUTE_PROCESS(COMMAND pip install pyOpenSSL)")

ADD_CUSTOM_TARGET(clips6_module DEPENDS ${PYTHON_SITE_PACKAGES}/clips6.so)
ADD_CUSTOM_TARGET(clips6_cmd DEPENDS clips6c)
ADD_CUSTOM_TARGET(clips6_pkg DEPENDS clips6pkg)

# Add dependencies
ADD_DEPENDENCIES(clips6_module clips6.pyx clips6.pyx clips6_dl.c clips6_io.c clips6_f.c ${ALL_MY_CIRCUIT})
ADD_DEPENDENCIES(clips6_cmd clips6.pyx clips6_cmd.pyx clips6_dl.c clips6_io.c clips6_f.c ${ALL_MY_CIRCUIT})
ADD_DEPENDENCIES(clips6_pkg clips6.pyx clips6_cmd.pyx clips6_dl.c clips6_io.c clips6_f.c ${ALL_MY_CIRCUIT})







