cmake_minimum_required(VERSION 3.15)

project(tdjsonlc VERSION 0.1.0)

include(ExternalProject)

ExternalProject_Add(
    tdlib
    GIT_REPOSITORY https://github.com/tdlib/td.git
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DOPENSSL_ROOT_DIR=/opt/homebrew/opt/openssl/
        -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
)
ExternalProject_Get_Property(tdlib SOURCE_DIR)
set(TDLIB_INCLUDE_DIR ${CMAKE_INSTALL_PREFIX}/include)
set(TDLIB_LINK_DIR ${CMAKE_INSTALL_PREFIX}/lib)
link_directories(${TDLIB_LINK_DIR})

ExternalProject_Add(
    dartsdk
    GIT_REPOSITORY https://github.com/dart-lang/sdk.git
    GIT_TAG 2.17.7
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
)
ExternalProject_Get_Property(dartsdk SOURCE_DIR)
set(DARTSDK_INCLUDE_DIR ${SOURCE_DIR}/runtime)

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
