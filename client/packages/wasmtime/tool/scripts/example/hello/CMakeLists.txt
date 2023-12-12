cmake_minimum_required(VERSION 3.15)

project(hellocallback VERSION 0.1.0)

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

# ExternalProject_Add(
#     wasmtime
#     GIT_REPOSITORY https://github.com/bytecodealliance/wasmtime.git
#     GIT_TAG v15.0.1
#     CMAKE_ARGS
#         -DCMAKE_BUILD_TYPE=Release
#         -DOPENSSL_ROOT_DIR=/opt/homebrew/opt/openssl/
#         -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
# 		${BUILD_TOOL_CHAIN}
# )
# ExternalProject_Get_Property(tdlib SOURCE_DIR)
# set(TDLIB_INCLUDE_DIR ${CMAKE_INSTALL_PREFIX}/include)
# set(TDLIB_LINK_DIR ${CMAKE_INSTALL_PREFIX}/lib)
# link_directories(${TDLIB_LINK_DIR})

set(WASMTIME_INCLUDE_DIR_1 /Users/stefanizota/taraxa/projects/echo/client/packages/wasmtime/wasmtime/crates/c-api/include/)
set(WASMTIME_INCLUDE_DIR_2 /Users/stefanizota/taraxa/projects/echo/client/packages/wasmtime/wasmtime/crates/c-api/wasm-c-api/include/)


add_library(hellocallback SHARED hello.c)

add_dependencies(hellocallback dartsdk)

target_include_directories(
    hellocallback PUBLIC
    "${PROJECT_BINARY_DIR}"
    "${DARTSDK_INCLUDE_DIR}"
    "${WASMTIME_INCLUDE_DIR_1}"
    "${WASMTIME_INCLUDE_DIR_2}"
)

target_link_libraries(
    hellocallback
)

install(TARGETS hellocallback DESTINATION ${CMAKE_INSTALL_PREFIX})
