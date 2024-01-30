#include <stdio.h>
#include <stdlib.h>

#include "api_imports.h"

#include "include/dart_api_dl.h"
#include "include/dart_api_dl.c"

Dart_Port send_port_;

intptr_t init_dart_api_dl(void *data)
{
    return Dart_InitializeApiDL(data);
}

wasm_trap_t *callback(void *env, wasmtime_caller_t *caller,
                      const wasmtime_val_t *args, size_t nargs,
                      wasmtime_val_t *results, size_t nresults)
{
    printf("[lib_callback] Calling back...\n");

    char *message_hello = "Hello from C";

    message_t *message = (message_t *)malloc(sizeof(message_t));
    ;

    message->message = message_hello;

    Dart_CObject dart_object;
    dart_object.type = Dart_CObject_kInt64;
    dart_object.value.as_int64 = (int64_t)message;

    bool result = Dart_PostCObject_DL(send_port_, &dart_object);
    if (!result)
    {
        printf("[lib_callback] Posting message to native port failed.");
    }

    printf("[lib_callback] End calling back...\n");

    return NULL;
}

void register_callback_sendport(Dart_Port send_port)
{
    send_port_ = send_port;
}