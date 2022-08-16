#ifndef _LIB_TD_JSON_LOG_CALLBACK_
#define _LIB_TD_JSON_LOG_CALLBACK_

#include <stdio.h>
// #include <iostream>

#include "td/telegram/td_json_client.h"

#include "include/dart_api.h"
#include "include/dart_native_api.h"
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
    const char log_message_template[] = "%d\n%s";
    char buffer[strlen(log_message_template) + strlen(message) + 10];
    sprintf(buffer, log_message_template, verbosity_level, message);

    Dart_CObject dart_object;
    dart_object.type = Dart_CObject_kString;
    dart_object.value.as_string = buffer;

    const bool result = Dart_PostCObject_DL(send_port_, &dart_object);
    if (!result) {
        // FATAL("C   :  Posting message to port failed.");
    }
}

void register_log_message_callback_sendport(Dart_Port send_port, int max_verbosity_level) {
  send_port_ = send_port;
  td_set_log_message_callback(max_verbosity_level, log_message_callback);
}

#endif