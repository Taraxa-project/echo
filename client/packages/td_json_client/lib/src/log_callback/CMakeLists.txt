cmake_minimum_required(VERSION 3.15)

project(tdjsonlc VERSION 0.1.0)

include(ExternalProject)

ExternalProject_Add(
    dartsdk
    GIT_REPOSITORY https://github.com/dart-lang/sdk.git
    GIT_TAG 3.1.4
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
)
ExternalProject_Get_Property(dartsdk SOURCE_DIR)
set(DARTSDK_INCLUDE_DIR ${SOURCE_DIR}/runtime)

if (WIN32)
	set(BUILD_TOOL_CHAIN "-DCMAKE_TOOLCHAIN_FILE=${DCMAKE_TOOLCHAIN_FILE}")
else()
	set(BUILD_TOOL_CHAIN "")
endif (WIN32)

# Tdlib 1.8.15 https://github.com/tdlib/td/blob/2e5319ff360cd2d6dab638a7e0370fe959e4201b/CMakeLists.txt#L9
ExternalProject_Add(
    tdlib
    GIT_REPOSITORY https://github.com/tdlib/td.git
    GIT_TAG 2e5319ff360cd2d6dab638a7e0370fe959e4201b
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DOPENSSL_ROOT_DIR=/opt/homebrew/opt/openssl/
        -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
		${BUILD_TOOL_CHAIN}
)
ExternalProject_Get_Property(tdlib SOURCE_DIR)
set(TDLIB_INCLUDE_DIR ${CMAKE_INSTALL_PREFIX}/include)
set(TDLIB_LINK_DIR ${CMAKE_INSTALL_PREFIX}/lib)
link_directories(${TDLIB_LINK_DIR})

add_library(tdjsonlc SHARED lib_td_json_log_callback.c)

add_dependencies(tdjsonlc tdlib dartsdk)

target_include_directories(
    tdjsonlc PUBLIC
    "${PROJECT_BINARY_DIR}"
    "${DARTSDK_INCLUDE_DIR}"
    "${TDLIB_INCLUDE_DIR}"
)

target_link_libraries(
    tdjsonlc tdjson
)

install(TARGETS tdjsonlc DESTINATION ${CMAKE_INSTALL_PREFIX})
