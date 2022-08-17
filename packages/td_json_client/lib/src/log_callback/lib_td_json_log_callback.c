#include <stdio.h>
#include <stdlib.h>

#include "lib_td_json_log_callback.h"

#include "td/telegram/td_json_client.h"

#include "include/dart_api_dl.h"
#include "include/dart_api_dl.c"

Dart_Port send_port_;

intptr_t init_dart_api_dl(void* data) {
  return Dart_InitializeApiDL(data);
}

int td_create_client_id_lc() {
    return td_create_client_id();
}

void td_send_lc(int client_id, const char *request) {
    td_send(client_id, request);
}

const char *td_receive_lc(double timeout) {
    return td_receive(timeout);
}

const char *td_execute_lc(const char *request) {
    return td_execute(request);
}

void log_message_callback(int verbosity_level, const char *message) {
    char *message_copy = (char *) malloc(sizeof(char) * (strlen(message) + 1));
    strcpy(message_copy, message);

    log_message_t *log_message = (log_message_t *) malloc(sizeof(log_message_t));;
    
    log_message->verbosity_level = verbosity_level;
    log_message->message = message_copy;

    Dart_CObject dart_object;
    dart_object.type = Dart_CObject_kInt64;
    dart_object.value.as_int64 = (int64_t) log_message;

    bool result = Dart_PostCObject_DL(send_port_, &dart_object);
    if (!result) {
        printf("C: Posting message to native port failed.");
    }
}

void register_log_message_callback_sendport(Dart_Port send_port, int max_verbosity_level) {
  send_port_ = send_port;
  td_set_log_message_callback(max_verbosity_level, log_message_callback);
}
