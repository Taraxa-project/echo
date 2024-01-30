#ifndef _LIB_TD_JSON_LOG_CALLBACK_
#define _LIB_TD_JSON_LOG_CALLBACK_

#include "include/dart_api.h"
#include "wasm.h"
#include "wasmtime.h"

typedef struct message_t
{
    char *message;
} message_t;

intptr_t init_dart_api_dl(void *data);

wasm_trap_t *callback(void *env, wasmtime_caller_t *caller,
                      const wasmtime_val_t *args, size_t nargs,
                      wasmtime_val_t *results, size_t nresults);

void register_callback_sendport(Dart_Port send_port);

#endif