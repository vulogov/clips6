cmake_minimum_required(VERSION 2.8.4)

FILE(GLOB LIBCLIPS_SRC *.c)

add_library(libclips.so SHARED ${LIBCLIPS_SRC})

SET(CMAKE_C_FLAGS "-DCLIPS_MAJOR=6 -DCLIPS_MINOR=30")

set_target_properties(libclips.so PROPERTIES OUTPUT_NAME "clips")
set_target_properties(libclips.so PROPERTIES VERSION 0.1 SOVERSION 1)


set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)

install(TARGETS libclips.so 
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)
        
