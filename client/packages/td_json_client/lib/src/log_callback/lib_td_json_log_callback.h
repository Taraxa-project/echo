#ifndef _LIB_TD_JSON_LOG_CALLBACK_
#define _LIB_TD_JSON_LOG_CALLBACK_

#include "include/dart_api.h"

typedef struct log_message_t {
    int verbosity_level;
    char *message;
} log_message_t;

intptr_t init_dart_api_dl(void* data);
int td_create_client_id_lc();
void td_send_lc(int client_id, const char *request);
const char *td_receive_lc(double timeout);
const char *td_execute_lc(const char *request);
void register_log_message_callback_sendport(Dart_Port send_port, int max_verbosity_level);

#endif