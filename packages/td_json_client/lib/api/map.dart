import 'package:td_json_client/api/base.dart';

import 'package:td_json_client/api/object/error.dart';
import 'package:td_json_client/api/object/ok.dart';
import 'package:td_json_client/api/object/tdlib_parameters.dart';
import 'package:td_json_client/api/object/authentication_code_type.dart';
import 'package:td_json_client/api/object/authentication_code_info.dart';
import 'package:td_json_client/api/object/email_address_authentication_code_info.dart';
import 'package:td_json_client/api/object/text_entity.dart';
import 'package:td_json_client/api/object/text_entities.dart';
import 'package:td_json_client/api/object/formatted_text.dart';
import 'package:td_json_client/api/object/terms_of_service.dart';
import 'package:td_json_client/api/object/authorization_state.dart';
import 'package:td_json_client/api/object/password_state.dart';
import 'package:td_json_client/api/object/recovery_email_address.dart';
import 'package:td_json_client/api/object/temporary_password_state.dart';
import 'package:td_json_client/api/object/local_file.dart';
import 'package:td_json_client/api/object/remote_file.dart';
import 'package:td_json_client/api/object/file.dart';
import 'package:td_json_client/api/object/input_file.dart';
import 'package:td_json_client/api/object/photo_size.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';
import 'package:td_json_client/api/object/thumbnail_format.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/mask_point.dart';
import 'package:td_json_client/api/object/mask_position.dart';
import 'package:td_json_client/api/object/sticker_type.dart';
import 'package:td_json_client/api/object/closed_vector_path.dart';
import 'package:td_json_client/api/object/poll_option.dart';
import 'package:td_json_client/api/object/poll_type.dart';
import 'package:td_json_client/api/object/animation.dart';
import 'package:td_json_client/api/object/audio.dart';
import 'package:td_json_client/api/object/document.dart';
import 'package:td_json_client/api/object/photo.dart';
import 'package:td_json_client/api/object/sticker.dart';
import 'package:td_json_client/api/object/video.dart';
import 'package:td_json_client/api/object/video_note.dart';
import 'package:td_json_client/api/object/voice_note.dart';
import 'package:td_json_client/api/object/animated_emoji.dart';
import 'package:td_json_client/api/object/contact.dart';
import 'package:td_json_client/api/object/location.dart';
import 'package:td_json_client/api/object/venue.dart';
import 'package:td_json_client/api/object/game.dart';
import 'package:td_json_client/api/object/poll.dart';
import 'package:td_json_client/api/object/profile_photo.dart';
import 'package:td_json_client/api/object/chat_photo_info.dart';
import 'package:td_json_client/api/object/user_type.dart';
import 'package:td_json_client/api/object/bot_command.dart';
import 'package:td_json_client/api/object/bot_commands.dart';
import 'package:td_json_client/api/object/bot_menu_button.dart';
import 'package:td_json_client/api/object/chat_location.dart';
import 'package:td_json_client/api/object/animated_chat_photo.dart';
import 'package:td_json_client/api/object/chat_photo.dart';
import 'package:td_json_client/api/object/chat_photos.dart';
import 'package:td_json_client/api/object/input_chat_photo.dart';
import 'package:td_json_client/api/object/chat_permissions.dart';
import 'package:td_json_client/api/object/chat_administrator_rights.dart';
import 'package:td_json_client/api/object/user.dart';
import 'package:td_json_client/api/object/bot_info.dart';
import 'package:td_json_client/api/object/user_full_info.dart';
import 'package:td_json_client/api/object/users.dart';
import 'package:td_json_client/api/object/chat_administrator.dart';
import 'package:td_json_client/api/object/chat_administrators.dart';
import 'package:td_json_client/api/object/chat_member_status.dart';
import 'package:td_json_client/api/object/chat_member.dart';
import 'package:td_json_client/api/object/chat_members.dart';
import 'package:td_json_client/api/object/chat_members_filter.dart';
import 'package:td_json_client/api/object/supergroup_members_filter.dart';
import 'package:td_json_client/api/object/chat_invite_link.dart';
import 'package:td_json_client/api/object/chat_invite_links.dart';
import 'package:td_json_client/api/object/chat_invite_link_count.dart';
import 'package:td_json_client/api/object/chat_invite_link_counts.dart';
import 'package:td_json_client/api/object/chat_invite_link_member.dart';
import 'package:td_json_client/api/object/chat_invite_link_members.dart';
import 'package:td_json_client/api/object/chat_invite_link_info.dart';
import 'package:td_json_client/api/object/chat_join_request.dart';
import 'package:td_json_client/api/object/chat_join_requests.dart';
import 'package:td_json_client/api/object/chat_join_requests_info.dart';
import 'package:td_json_client/api/object/basic_group.dart';
import 'package:td_json_client/api/object/basic_group_full_info.dart';
import 'package:td_json_client/api/object/supergroup.dart';
import 'package:td_json_client/api/object/supergroup_full_info.dart';
import 'package:td_json_client/api/object/secret_chat_state.dart';
import 'package:td_json_client/api/object/secret_chat.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/message_senders.dart';
import 'package:td_json_client/api/object/message_forward_origin.dart';
import 'package:td_json_client/api/object/message_forward_info.dart';
import 'package:td_json_client/api/object/message_reply_info.dart';
import 'package:td_json_client/api/object/message_reaction.dart';
import 'package:td_json_client/api/object/message_interaction_info.dart';
import 'package:td_json_client/api/object/unread_reaction.dart';
import 'package:td_json_client/api/object/message_sending_state.dart';
import 'package:td_json_client/api/object/message.dart';
import 'package:td_json_client/api/object/messages.dart';
import 'package:td_json_client/api/object/found_messages.dart';
import 'package:td_json_client/api/object/message_position.dart';
import 'package:td_json_client/api/object/message_positions.dart';
import 'package:td_json_client/api/object/message_calendar_day.dart';
import 'package:td_json_client/api/object/message_calendar.dart';
import 'package:td_json_client/api/object/sponsored_message.dart';
import 'package:td_json_client/api/object/file_download.dart';
import 'package:td_json_client/api/object/downloaded_file_counts.dart';
import 'package:td_json_client/api/object/found_file_downloads.dart';
import 'package:td_json_client/api/object/notification_settings_scope.dart';
import 'package:td_json_client/api/object/chat_notification_settings.dart';
import 'package:td_json_client/api/object/scope_notification_settings.dart';
import 'package:td_json_client/api/object/draft_message.dart';
import 'package:td_json_client/api/object/chat_type.dart';
import 'package:td_json_client/api/object/chat_filter.dart';
import 'package:td_json_client/api/object/chat_filter_info.dart';
import 'package:td_json_client/api/object/recommended_chat_filter.dart';
import 'package:td_json_client/api/object/recommended_chat_filters.dart';
import 'package:td_json_client/api/object/chat_list.dart';
import 'package:td_json_client/api/object/chat_lists.dart';
import 'package:td_json_client/api/object/chat_source.dart';
import 'package:td_json_client/api/object/chat_position.dart';
import 'package:td_json_client/api/object/video_chat.dart';
import 'package:td_json_client/api/object/chat.dart';
import 'package:td_json_client/api/object/chats.dart';
import 'package:td_json_client/api/object/chat_nearby.dart';
import 'package:td_json_client/api/object/chats_nearby.dart';
import 'package:td_json_client/api/object/public_chat_type.dart';
import 'package:td_json_client/api/object/chat_action_bar.dart';
import 'package:td_json_client/api/object/keyboard_button_type.dart';
import 'package:td_json_client/api/object/keyboard_button.dart';
import 'package:td_json_client/api/object/inline_keyboard_button_type.dart';
import 'package:td_json_client/api/object/inline_keyboard_button.dart';
import 'package:td_json_client/api/object/reply_markup.dart';
import 'package:td_json_client/api/object/login_url_info.dart';
import 'package:td_json_client/api/object/web_app_info.dart';
import 'package:td_json_client/api/object/message_thread_info.dart';
import 'package:td_json_client/api/object/rich_text.dart';
import 'package:td_json_client/api/object/page_block_caption.dart';
import 'package:td_json_client/api/object/page_block_list_item.dart';
import 'package:td_json_client/api/object/page_block_horizontal_alignment.dart';
import 'package:td_json_client/api/object/page_block_vertical_alignment.dart';
import 'package:td_json_client/api/object/page_block_table_cell.dart';
import 'package:td_json_client/api/object/page_block_related_article.dart';
import 'package:td_json_client/api/object/page_block.dart';
import 'package:td_json_client/api/object/web_page_instant_view.dart';
import 'package:td_json_client/api/object/web_page.dart';
import 'package:td_json_client/api/object/country_info.dart';
import 'package:td_json_client/api/object/countries.dart';
import 'package:td_json_client/api/object/phone_number_info.dart';
import 'package:td_json_client/api/object/bank_card_action_open_url.dart';
import 'package:td_json_client/api/object/bank_card_info.dart';
import 'package:td_json_client/api/object/address.dart';
import 'package:td_json_client/api/object/theme_parameters.dart';
import 'package:td_json_client/api/object/labeled_price_part.dart';
import 'package:td_json_client/api/object/invoice.dart';
import 'package:td_json_client/api/object/order_info.dart';
import 'package:td_json_client/api/object/shipping_option.dart';
import 'package:td_json_client/api/object/saved_credentials.dart';
import 'package:td_json_client/api/object/input_credentials.dart';
import 'package:td_json_client/api/object/payment_provider.dart';
import 'package:td_json_client/api/object/payment_form.dart';
import 'package:td_json_client/api/object/validated_order_info.dart';
import 'package:td_json_client/api/object/payment_result.dart';
import 'package:td_json_client/api/object/payment_receipt.dart';
import 'package:td_json_client/api/object/input_invoice.dart';
import 'package:td_json_client/api/object/dated_file.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';
import 'package:td_json_client/api/object/date.dart';
import 'package:td_json_client/api/object/personal_details.dart';
import 'package:td_json_client/api/object/identity_document.dart';
import 'package:td_json_client/api/object/input_identity_document.dart';
import 'package:td_json_client/api/object/personal_document.dart';
import 'package:td_json_client/api/object/input_personal_document.dart';
import 'package:td_json_client/api/object/passport_element.dart';
import 'package:td_json_client/api/object/input_passport_element.dart';
import 'package:td_json_client/api/object/passport_elements.dart';
import 'package:td_json_client/api/object/passport_element_error_source.dart';
import 'package:td_json_client/api/object/passport_element_error.dart';
import 'package:td_json_client/api/object/passport_suitable_element.dart';
import 'package:td_json_client/api/object/passport_required_element.dart';
import 'package:td_json_client/api/object/passport_authorization_form.dart';
import 'package:td_json_client/api/object/passport_elements_with_errors.dart';
import 'package:td_json_client/api/object/encrypted_credentials.dart';
import 'package:td_json_client/api/object/encrypted_passport_element.dart';
import 'package:td_json_client/api/object/input_passport_element_error_source.dart';
import 'package:td_json_client/api/object/input_passport_element_error.dart';
import 'package:td_json_client/api/object/message_content.dart';
import 'package:td_json_client/api/object/text_entity_type.dart';
import 'package:td_json_client/api/object/input_thumbnail.dart';
import 'package:td_json_client/api/object/message_scheduling_state.dart';
import 'package:td_json_client/api/object/message_send_options.dart';
import 'package:td_json_client/api/object/message_copy_options.dart';
import 'package:td_json_client/api/object/input_message_content.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';
import 'package:td_json_client/api/object/chat_action.dart';
import 'package:td_json_client/api/object/user_status.dart';
import 'package:td_json_client/api/object/stickers.dart';
import 'package:td_json_client/api/object/emojis.dart';
import 'package:td_json_client/api/object/sticker_set.dart';
import 'package:td_json_client/api/object/sticker_set_info.dart';
import 'package:td_json_client/api/object/sticker_sets.dart';
import 'package:td_json_client/api/object/trending_sticker_sets.dart';
import 'package:td_json_client/api/object/call_discard_reason.dart';
import 'package:td_json_client/api/object/call_protocol.dart';
import 'package:td_json_client/api/object/call_server_type.dart';
import 'package:td_json_client/api/object/call_server.dart';
import 'package:td_json_client/api/object/call_id.dart';
import 'package:td_json_client/api/object/group_call_id.dart';
import 'package:td_json_client/api/object/call_state.dart';
import 'package:td_json_client/api/object/group_call_video_quality.dart';
import 'package:td_json_client/api/object/group_call_stream.dart';
import 'package:td_json_client/api/object/group_call_streams.dart';
import 'package:td_json_client/api/object/rtmp_url.dart';
import 'package:td_json_client/api/object/group_call_recent_speaker.dart';
import 'package:td_json_client/api/object/group_call.dart';
import 'package:td_json_client/api/object/group_call_video_source_group.dart';
import 'package:td_json_client/api/object/group_call_participant_video_info.dart';
import 'package:td_json_client/api/object/group_call_participant.dart';
import 'package:td_json_client/api/object/call_problem.dart';
import 'package:td_json_client/api/object/call.dart';
import 'package:td_json_client/api/object/phone_number_authentication_settings.dart';
import 'package:td_json_client/api/object/added_reaction.dart';
import 'package:td_json_client/api/object/added_reactions.dart';
import 'package:td_json_client/api/object/available_reaction.dart';
import 'package:td_json_client/api/object/available_reactions.dart';
import 'package:td_json_client/api/object/reaction.dart';
import 'package:td_json_client/api/object/animations.dart';
import 'package:td_json_client/api/object/dice_stickers.dart';
import 'package:td_json_client/api/object/imported_contacts.dart';
import 'package:td_json_client/api/object/attachment_menu_bot_color.dart';
import 'package:td_json_client/api/object/attachment_menu_bot.dart';
import 'package:td_json_client/api/object/sent_web_app_message.dart';
import 'package:td_json_client/api/object/http_url.dart';
import 'package:td_json_client/api/object/input_inline_query_result.dart';
import 'package:td_json_client/api/object/inline_query_result.dart';
import 'package:td_json_client/api/object/inline_query_results.dart';
import 'package:td_json_client/api/object/callback_query_payload.dart';
import 'package:td_json_client/api/object/callback_query_answer.dart';
import 'package:td_json_client/api/object/custom_request_result.dart';
import 'package:td_json_client/api/object/game_high_score.dart';
import 'package:td_json_client/api/object/game_high_scores.dart';
import 'package:td_json_client/api/object/chat_event_action.dart';
import 'package:td_json_client/api/object/chat_event.dart';
import 'package:td_json_client/api/object/chat_events.dart';
import 'package:td_json_client/api/object/chat_event_log_filters.dart';
import 'package:td_json_client/api/object/language_pack_string_value.dart';
import 'package:td_json_client/api/object/language_pack_string.dart';
import 'package:td_json_client/api/object/language_pack_strings.dart';
import 'package:td_json_client/api/object/language_pack_info.dart';
import 'package:td_json_client/api/object/localization_target_info.dart';
import 'package:td_json_client/api/object/premium_limit_type.dart';
import 'package:td_json_client/api/object/premium_feature.dart';
import 'package:td_json_client/api/object/premium_limit.dart';
import 'package:td_json_client/api/object/premium_features.dart';
import 'package:td_json_client/api/object/premium_source.dart';
import 'package:td_json_client/api/object/premium_feature_promotion_animation.dart';
import 'package:td_json_client/api/object/premium_state.dart';
import 'package:td_json_client/api/object/device_token.dart';
import 'package:td_json_client/api/object/push_receiver_id.dart';
import 'package:td_json_client/api/object/background_fill.dart';
import 'package:td_json_client/api/object/background_type.dart';
import 'package:td_json_client/api/object/background.dart';
import 'package:td_json_client/api/object/backgrounds.dart';
import 'package:td_json_client/api/object/input_background.dart';
import 'package:td_json_client/api/object/theme_settings.dart';
import 'package:td_json_client/api/object/chat_theme.dart';
import 'package:td_json_client/api/object/hashtags.dart';
import 'package:td_json_client/api/object/can_transfer_ownership_result.dart';
import 'package:td_json_client/api/object/check_chat_username_result.dart';
import 'package:td_json_client/api/object/check_sticker_set_name_result.dart';
import 'package:td_json_client/api/object/reset_password_result.dart';
import 'package:td_json_client/api/object/message_file_type.dart';
import 'package:td_json_client/api/object/push_message_content.dart';
import 'package:td_json_client/api/object/notification_type.dart';
import 'package:td_json_client/api/object/notification_group_type.dart';
import 'package:td_json_client/api/object/notification_sound.dart';
import 'package:td_json_client/api/object/notification_sounds.dart';
import 'package:td_json_client/api/object/notification.dart';
import 'package:td_json_client/api/object/notification_group.dart';
import 'package:td_json_client/api/object/option_value.dart';
import 'package:td_json_client/api/object/json_object_member.dart';
import 'package:td_json_client/api/object/json_value.dart';
import 'package:td_json_client/api/object/user_privacy_setting_rule.dart';
import 'package:td_json_client/api/object/user_privacy_setting_rules.dart';
import 'package:td_json_client/api/object/user_privacy_setting.dart';
import 'package:td_json_client/api/object/account_ttl.dart';
import 'package:td_json_client/api/object/session_type.dart';
import 'package:td_json_client/api/object/session.dart';
import 'package:td_json_client/api/object/sessions.dart';
import 'package:td_json_client/api/object/connected_website.dart';
import 'package:td_json_client/api/object/connected_websites.dart';
import 'package:td_json_client/api/object/chat_report_reason.dart';
import 'package:td_json_client/api/object/target_chat.dart';
import 'package:td_json_client/api/object/internal_link_type.dart';
import 'package:td_json_client/api/object/message_link.dart';
import 'package:td_json_client/api/object/message_link_info.dart';
import 'package:td_json_client/api/object/file_part.dart';
import 'package:td_json_client/api/object/file_type.dart';
import 'package:td_json_client/api/object/storage_statistics_by_file_type.dart';
import 'package:td_json_client/api/object/storage_statistics_by_chat.dart';
import 'package:td_json_client/api/object/storage_statistics.dart';
import 'package:td_json_client/api/object/storage_statistics_fast.dart';
import 'package:td_json_client/api/object/database_statistics.dart';
import 'package:td_json_client/api/object/network_type.dart';
import 'package:td_json_client/api/object/network_statistics_entry.dart';
import 'package:td_json_client/api/object/network_statistics.dart';
import 'package:td_json_client/api/object/auto_download_settings.dart';
import 'package:td_json_client/api/object/auto_download_settings_presets.dart';
import 'package:td_json_client/api/object/connection_state.dart';
import 'package:td_json_client/api/object/top_chat_category.dart';
import 'package:td_json_client/api/object/t_me_url_type.dart';
import 'package:td_json_client/api/object/t_me_url.dart';
import 'package:td_json_client/api/object/t_me_urls.dart';
import 'package:td_json_client/api/object/suggested_action.dart';
import 'package:td_json_client/api/object/count.dart';
import 'package:td_json_client/api/object/text.dart';
import 'package:td_json_client/api/object/seconds.dart';
import 'package:td_json_client/api/object/file_downloaded_prefix_size.dart';
import 'package:td_json_client/api/object/deep_link_info.dart';
import 'package:td_json_client/api/object/text_parse_mode.dart';
import 'package:td_json_client/api/object/proxy_type.dart';
import 'package:td_json_client/api/object/proxy.dart';
import 'package:td_json_client/api/object/proxies.dart';
import 'package:td_json_client/api/object/input_sticker.dart';
import 'package:td_json_client/api/object/date_range.dart';
import 'package:td_json_client/api/object/statistical_value.dart';
import 'package:td_json_client/api/object/statistical_graph.dart';
import 'package:td_json_client/api/object/chat_statistics_message_interaction_info.dart';
import 'package:td_json_client/api/object/chat_statistics_message_sender_info.dart';
import 'package:td_json_client/api/object/chat_statistics_administrator_actions_info.dart';
import 'package:td_json_client/api/object/chat_statistics_inviter_info.dart';
import 'package:td_json_client/api/object/chat_statistics.dart';
import 'package:td_json_client/api/object/message_statistics.dart';
import 'package:td_json_client/api/object/point.dart';
import 'package:td_json_client/api/object/vector_path_command.dart';
import 'package:td_json_client/api/object/bot_command_scope.dart';
import 'package:td_json_client/api/object/update.dart';
import 'package:td_json_client/api/object/updates.dart';
import 'package:td_json_client/api/object/log_stream.dart';
import 'package:td_json_client/api/object/log_verbosity_level.dart';
import 'package:td_json_client/api/object/log_tags.dart';
import 'package:td_json_client/api/object/test_int.dart';
import 'package:td_json_client/api/object/test_string.dart';
import 'package:td_json_client/api/object/test_bytes.dart';
import 'package:td_json_client/api/object/test_vector_int.dart';
import 'package:td_json_client/api/object/test_vector_int_object.dart';
import 'package:td_json_client/api/object/test_vector_string.dart';
import 'package:td_json_client/api/object/test_vector_string_object.dart';
import 'package:td_json_client/api/function/get_authorization_state.dart';
import 'package:td_json_client/api/function/set_tdlib_parameters.dart';
import 'package:td_json_client/api/function/check_database_encryption_key.dart';
import 'package:td_json_client/api/function/set_authentication_phone_number.dart';
import 'package:td_json_client/api/function/resend_authentication_code.dart';
import 'package:td_json_client/api/function/check_authentication_code.dart';
import 'package:td_json_client/api/function/request_qr_code_authentication.dart';
import 'package:td_json_client/api/function/register_user.dart';
import 'package:td_json_client/api/function/check_authentication_password.dart';
import 'package:td_json_client/api/function/request_authentication_password_recovery.dart';
import 'package:td_json_client/api/function/check_authentication_password_recovery_code.dart';
import 'package:td_json_client/api/function/recover_authentication_password.dart';
import 'package:td_json_client/api/function/check_authentication_bot_token.dart';
import 'package:td_json_client/api/function/log_out.dart';
import 'package:td_json_client/api/function/close.dart';
import 'package:td_json_client/api/function/destroy.dart';
import 'package:td_json_client/api/function/confirm_qr_code_authentication.dart';
import 'package:td_json_client/api/function/get_current_state.dart';
import 'package:td_json_client/api/function/set_database_encryption_key.dart';
import 'package:td_json_client/api/function/get_password_state.dart';
import 'package:td_json_client/api/function/set_password.dart';
import 'package:td_json_client/api/function/get_recovery_email_address.dart';
import 'package:td_json_client/api/function/set_recovery_email_address.dart';
import 'package:td_json_client/api/function/check_recovery_email_address_code.dart';
import 'package:td_json_client/api/function/resend_recovery_email_address_code.dart';
import 'package:td_json_client/api/function/request_password_recovery.dart';
import 'package:td_json_client/api/function/check_password_recovery_code.dart';
import 'package:td_json_client/api/function/recover_password.dart';
import 'package:td_json_client/api/function/reset_password.dart';
import 'package:td_json_client/api/function/cancel_password_reset.dart';
import 'package:td_json_client/api/function/create_temporary_password.dart';
import 'package:td_json_client/api/function/get_temporary_password_state.dart';
import 'package:td_json_client/api/function/get_me.dart';
import 'package:td_json_client/api/function/get_user.dart';
import 'package:td_json_client/api/function/get_user_full_info.dart';
import 'package:td_json_client/api/function/get_basic_group.dart';
import 'package:td_json_client/api/function/get_basic_group_full_info.dart';
import 'package:td_json_client/api/function/get_supergroup.dart';
import 'package:td_json_client/api/function/get_supergroup_full_info.dart';
import 'package:td_json_client/api/function/get_secret_chat.dart';
import 'package:td_json_client/api/function/get_chat.dart';
import 'package:td_json_client/api/function/get_message.dart';
import 'package:td_json_client/api/function/get_message_locally.dart';
import 'package:td_json_client/api/function/get_replied_message.dart';
import 'package:td_json_client/api/function/get_chat_pinned_message.dart';
import 'package:td_json_client/api/function/get_callback_query_message.dart';
import 'package:td_json_client/api/function/get_messages.dart';
import 'package:td_json_client/api/function/get_message_thread.dart';
import 'package:td_json_client/api/function/get_message_viewers.dart';
import 'package:td_json_client/api/function/get_file.dart';
import 'package:td_json_client/api/function/get_remote_file.dart';
import 'package:td_json_client/api/function/load_chats.dart';
import 'package:td_json_client/api/function/get_chats.dart';
import 'package:td_json_client/api/function/search_public_chat.dart';
import 'package:td_json_client/api/function/search_public_chats.dart';
import 'package:td_json_client/api/function/search_chats.dart';
import 'package:td_json_client/api/function/search_chats_on_server.dart';
import 'package:td_json_client/api/function/search_chats_nearby.dart';
import 'package:td_json_client/api/function/get_top_chats.dart';
import 'package:td_json_client/api/function/remove_top_chat.dart';
import 'package:td_json_client/api/function/add_recently_found_chat.dart';
import 'package:td_json_client/api/function/remove_recently_found_chat.dart';
import 'package:td_json_client/api/function/clear_recently_found_chats.dart';
import 'package:td_json_client/api/function/get_recently_opened_chats.dart';
import 'package:td_json_client/api/function/check_chat_username.dart';
import 'package:td_json_client/api/function/get_created_public_chats.dart';
import 'package:td_json_client/api/function/check_created_public_chats_limit.dart';
import 'package:td_json_client/api/function/get_suitable_discussion_chats.dart';
import 'package:td_json_client/api/function/get_inactive_supergroup_chats.dart';
import 'package:td_json_client/api/function/get_groups_in_common.dart';
import 'package:td_json_client/api/function/get_chat_history.dart';
import 'package:td_json_client/api/function/get_message_thread_history.dart';
import 'package:td_json_client/api/function/delete_chat_history.dart';
import 'package:td_json_client/api/function/delete_chat.dart';
import 'package:td_json_client/api/function/search_chat_messages.dart';
import 'package:td_json_client/api/function/search_messages.dart';
import 'package:td_json_client/api/function/search_secret_messages.dart';
import 'package:td_json_client/api/function/search_call_messages.dart';
import 'package:td_json_client/api/function/search_outgoing_document_messages.dart';
import 'package:td_json_client/api/function/delete_all_call_messages.dart';
import 'package:td_json_client/api/function/search_chat_recent_location_messages.dart';
import 'package:td_json_client/api/function/get_active_live_location_messages.dart';
import 'package:td_json_client/api/function/get_chat_message_by_date.dart';
import 'package:td_json_client/api/function/get_chat_sparse_message_positions.dart';
import 'package:td_json_client/api/function/get_chat_message_calendar.dart';
import 'package:td_json_client/api/function/get_chat_message_count.dart';
import 'package:td_json_client/api/function/get_chat_scheduled_messages.dart';
import 'package:td_json_client/api/function/get_message_public_forwards.dart';
import 'package:td_json_client/api/function/get_chat_sponsored_message.dart';
import 'package:td_json_client/api/function/remove_notification.dart';
import 'package:td_json_client/api/function/remove_notification_group.dart';
import 'package:td_json_client/api/function/get_message_link.dart';
import 'package:td_json_client/api/function/get_message_embedding_code.dart';
import 'package:td_json_client/api/function/get_message_link_info.dart';
import 'package:td_json_client/api/function/translate_text.dart';
import 'package:td_json_client/api/function/recognize_speech.dart';
import 'package:td_json_client/api/function/rate_speech_recognition.dart';
import 'package:td_json_client/api/function/get_chat_available_message_senders.dart';
import 'package:td_json_client/api/function/set_chat_message_sender.dart';
import 'package:td_json_client/api/function/send_message.dart';
import 'package:td_json_client/api/function/send_message_album.dart';
import 'package:td_json_client/api/function/send_bot_start_message.dart';
import 'package:td_json_client/api/function/send_inline_query_result_message.dart';
import 'package:td_json_client/api/function/forward_messages.dart';
import 'package:td_json_client/api/function/resend_messages.dart';
import 'package:td_json_client/api/function/send_chat_screenshot_taken_notification.dart';
import 'package:td_json_client/api/function/add_local_message.dart';
import 'package:td_json_client/api/function/delete_messages.dart';
import 'package:td_json_client/api/function/delete_chat_messages_by_sender.dart';
import 'package:td_json_client/api/function/delete_chat_messages_by_date.dart';
import 'package:td_json_client/api/function/edit_message_text.dart';
import 'package:td_json_client/api/function/edit_message_live_location.dart';
import 'package:td_json_client/api/function/edit_message_media.dart';
import 'package:td_json_client/api/function/edit_message_caption.dart';
import 'package:td_json_client/api/function/edit_message_reply_markup.dart';
import 'package:td_json_client/api/function/edit_inline_message_text.dart';
import 'package:td_json_client/api/function/edit_inline_message_live_location.dart';
import 'package:td_json_client/api/function/edit_inline_message_media.dart';
import 'package:td_json_client/api/function/edit_inline_message_caption.dart';
import 'package:td_json_client/api/function/edit_inline_message_reply_markup.dart';
import 'package:td_json_client/api/function/edit_message_scheduling_state.dart';
import 'package:td_json_client/api/function/get_message_available_reactions.dart';
import 'package:td_json_client/api/function/set_message_reaction.dart';
import 'package:td_json_client/api/function/get_message_added_reactions.dart';
import 'package:td_json_client/api/function/get_text_entities.dart';
import 'package:td_json_client/api/function/parse_text_entities.dart';
import 'package:td_json_client/api/function/parse_markdown.dart';
import 'package:td_json_client/api/function/get_markdown_text.dart';
import 'package:td_json_client/api/function/get_file_mime_type.dart';
import 'package:td_json_client/api/function/get_file_extension.dart';
import 'package:td_json_client/api/function/clean_file_name.dart';
import 'package:td_json_client/api/function/get_language_pack_string.dart';
import 'package:td_json_client/api/function/get_json_value.dart';
import 'package:td_json_client/api/function/get_json_string.dart';
import 'package:td_json_client/api/function/get_theme_parameters_json_string.dart';
import 'package:td_json_client/api/function/set_poll_answer.dart';
import 'package:td_json_client/api/function/get_poll_voters.dart';
import 'package:td_json_client/api/function/stop_poll.dart';
import 'package:td_json_client/api/function/hide_suggested_action.dart';
import 'package:td_json_client/api/function/get_login_url_info.dart';
import 'package:td_json_client/api/function/get_login_url.dart';
import 'package:td_json_client/api/function/get_inline_query_results.dart';
import 'package:td_json_client/api/function/answer_inline_query.dart';
import 'package:td_json_client/api/function/get_web_app_url.dart';
import 'package:td_json_client/api/function/send_web_app_data.dart';
import 'package:td_json_client/api/function/open_web_app.dart';
import 'package:td_json_client/api/function/close_web_app.dart';
import 'package:td_json_client/api/function/answer_web_app_query.dart';
import 'package:td_json_client/api/function/get_callback_query_answer.dart';
import 'package:td_json_client/api/function/answer_callback_query.dart';
import 'package:td_json_client/api/function/answer_shipping_query.dart';
import 'package:td_json_client/api/function/answer_pre_checkout_query.dart';
import 'package:td_json_client/api/function/set_game_score.dart';
import 'package:td_json_client/api/function/set_inline_game_score.dart';
import 'package:td_json_client/api/function/get_game_high_scores.dart';
import 'package:td_json_client/api/function/get_inline_game_high_scores.dart';
import 'package:td_json_client/api/function/delete_chat_reply_markup.dart';
import 'package:td_json_client/api/function/send_chat_action.dart';
import 'package:td_json_client/api/function/open_chat.dart';
import 'package:td_json_client/api/function/close_chat.dart';
import 'package:td_json_client/api/function/view_messages.dart';
import 'package:td_json_client/api/function/open_message_content.dart';
import 'package:td_json_client/api/function/click_animated_emoji_message.dart';
import 'package:td_json_client/api/function/get_internal_link_type.dart';
import 'package:td_json_client/api/function/get_external_link_info.dart';
import 'package:td_json_client/api/function/get_external_link.dart';
import 'package:td_json_client/api/function/read_all_chat_mentions.dart';
import 'package:td_json_client/api/function/read_all_chat_reactions.dart';
import 'package:td_json_client/api/function/create_private_chat.dart';
import 'package:td_json_client/api/function/create_basic_group_chat.dart';
import 'package:td_json_client/api/function/create_supergroup_chat.dart';
import 'package:td_json_client/api/function/create_secret_chat.dart';
import 'package:td_json_client/api/function/create_new_basic_group_chat.dart';
import 'package:td_json_client/api/function/create_new_supergroup_chat.dart';
import 'package:td_json_client/api/function/create_new_secret_chat.dart';
import 'package:td_json_client/api/function/upgrade_basic_group_chat_to_supergroup_chat.dart';
import 'package:td_json_client/api/function/get_chat_lists_to_add_chat.dart';
import 'package:td_json_client/api/function/add_chat_to_list.dart';
import 'package:td_json_client/api/function/get_chat_filter.dart';
import 'package:td_json_client/api/function/create_chat_filter.dart';
import 'package:td_json_client/api/function/edit_chat_filter.dart';
import 'package:td_json_client/api/function/delete_chat_filter.dart';
import 'package:td_json_client/api/function/reorder_chat_filters.dart';
import 'package:td_json_client/api/function/get_recommended_chat_filters.dart';
import 'package:td_json_client/api/function/get_chat_filter_default_icon_name.dart';
import 'package:td_json_client/api/function/set_chat_title.dart';
import 'package:td_json_client/api/function/set_chat_photo.dart';
import 'package:td_json_client/api/function/set_chat_message_ttl.dart';
import 'package:td_json_client/api/function/set_chat_permissions.dart';
import 'package:td_json_client/api/function/set_chat_theme.dart';
import 'package:td_json_client/api/function/set_chat_draft_message.dart';
import 'package:td_json_client/api/function/set_chat_notification_settings.dart';
import 'package:td_json_client/api/function/toggle_chat_has_protected_content.dart';
import 'package:td_json_client/api/function/toggle_chat_is_marked_as_unread.dart';
import 'package:td_json_client/api/function/toggle_chat_default_disable_notification.dart';
import 'package:td_json_client/api/function/set_chat_available_reactions.dart';
import 'package:td_json_client/api/function/set_chat_client_data.dart';
import 'package:td_json_client/api/function/set_chat_description.dart';
import 'package:td_json_client/api/function/set_chat_discussion_group.dart';
import 'package:td_json_client/api/function/set_chat_location.dart';
import 'package:td_json_client/api/function/set_chat_slow_mode_delay.dart';
import 'package:td_json_client/api/function/pin_chat_message.dart';
import 'package:td_json_client/api/function/unpin_chat_message.dart';
import 'package:td_json_client/api/function/unpin_all_chat_messages.dart';
import 'package:td_json_client/api/function/join_chat.dart';
import 'package:td_json_client/api/function/leave_chat.dart';
import 'package:td_json_client/api/function/add_chat_member.dart';
import 'package:td_json_client/api/function/add_chat_members.dart';
import 'package:td_json_client/api/function/set_chat_member_status.dart';
import 'package:td_json_client/api/function/ban_chat_member.dart';
import 'package:td_json_client/api/function/can_transfer_ownership.dart';
import 'package:td_json_client/api/function/transfer_chat_ownership.dart';
import 'package:td_json_client/api/function/get_chat_member.dart';
import 'package:td_json_client/api/function/search_chat_members.dart';
import 'package:td_json_client/api/function/get_chat_administrators.dart';
import 'package:td_json_client/api/function/clear_all_draft_messages.dart';
import 'package:td_json_client/api/function/get_saved_notification_sound.dart';
import 'package:td_json_client/api/function/get_saved_notification_sounds.dart';
import 'package:td_json_client/api/function/add_saved_notification_sound.dart';
import 'package:td_json_client/api/function/remove_saved_notification_sound.dart';
import 'package:td_json_client/api/function/get_chat_notification_settings_exceptions.dart';
import 'package:td_json_client/api/function/get_scope_notification_settings.dart';
import 'package:td_json_client/api/function/set_scope_notification_settings.dart';
import 'package:td_json_client/api/function/reset_all_notification_settings.dart';
import 'package:td_json_client/api/function/toggle_chat_is_pinned.dart';
import 'package:td_json_client/api/function/set_pinned_chats.dart';
import 'package:td_json_client/api/function/get_attachment_menu_bot.dart';
import 'package:td_json_client/api/function/toggle_bot_is_added_to_attachment_menu.dart';
import 'package:td_json_client/api/function/download_file.dart';
import 'package:td_json_client/api/function/get_file_downloaded_prefix_size.dart';
import 'package:td_json_client/api/function/cancel_download_file.dart';
import 'package:td_json_client/api/function/get_suggested_file_name.dart';
import 'package:td_json_client/api/function/upload_file.dart';
import 'package:td_json_client/api/function/cancel_upload_file.dart';
import 'package:td_json_client/api/function/write_generated_file_part.dart';
import 'package:td_json_client/api/function/set_file_generation_progress.dart';
import 'package:td_json_client/api/function/finish_file_generation.dart';
import 'package:td_json_client/api/function/read_file_part.dart';
import 'package:td_json_client/api/function/delete_file.dart';
import 'package:td_json_client/api/function/add_file_to_downloads.dart';
import 'package:td_json_client/api/function/toggle_download_is_paused.dart';
import 'package:td_json_client/api/function/toggle_all_downloads_are_paused.dart';
import 'package:td_json_client/api/function/remove_file_from_downloads.dart';
import 'package:td_json_client/api/function/remove_all_files_from_downloads.dart';
import 'package:td_json_client/api/function/search_file_downloads.dart';
import 'package:td_json_client/api/function/get_message_file_type.dart';
import 'package:td_json_client/api/function/get_message_import_confirmation_text.dart';
import 'package:td_json_client/api/function/import_messages.dart';
import 'package:td_json_client/api/function/replace_primary_chat_invite_link.dart';
import 'package:td_json_client/api/function/create_chat_invite_link.dart';
import 'package:td_json_client/api/function/edit_chat_invite_link.dart';
import 'package:td_json_client/api/function/get_chat_invite_link.dart';
import 'package:td_json_client/api/function/get_chat_invite_link_counts.dart';
import 'package:td_json_client/api/function/get_chat_invite_links.dart';
import 'package:td_json_client/api/function/get_chat_invite_link_members.dart';
import 'package:td_json_client/api/function/revoke_chat_invite_link.dart';
import 'package:td_json_client/api/function/delete_revoked_chat_invite_link.dart';
import 'package:td_json_client/api/function/delete_all_revoked_chat_invite_links.dart';
import 'package:td_json_client/api/function/check_chat_invite_link.dart';
import 'package:td_json_client/api/function/join_chat_by_invite_link.dart';
import 'package:td_json_client/api/function/get_chat_join_requests.dart';
import 'package:td_json_client/api/function/process_chat_join_request.dart';
import 'package:td_json_client/api/function/process_chat_join_requests.dart';
import 'package:td_json_client/api/function/create_call.dart';
import 'package:td_json_client/api/function/accept_call.dart';
import 'package:td_json_client/api/function/send_call_signaling_data.dart';
import 'package:td_json_client/api/function/discard_call.dart';
import 'package:td_json_client/api/function/send_call_rating.dart';
import 'package:td_json_client/api/function/send_call_debug_information.dart';
import 'package:td_json_client/api/function/send_call_log.dart';
import 'package:td_json_client/api/function/get_video_chat_available_participants.dart';
import 'package:td_json_client/api/function/set_video_chat_default_participant.dart';
import 'package:td_json_client/api/function/create_video_chat.dart';
import 'package:td_json_client/api/function/get_video_chat_rtmp_url.dart';
import 'package:td_json_client/api/function/replace_video_chat_rtmp_url.dart';
import 'package:td_json_client/api/function/get_group_call.dart';
import 'package:td_json_client/api/function/start_scheduled_group_call.dart';
import 'package:td_json_client/api/function/toggle_group_call_enabled_start_notification.dart';
import 'package:td_json_client/api/function/join_group_call.dart';
import 'package:td_json_client/api/function/start_group_call_screen_sharing.dart';
import 'package:td_json_client/api/function/toggle_group_call_screen_sharing_is_paused.dart';
import 'package:td_json_client/api/function/end_group_call_screen_sharing.dart';
import 'package:td_json_client/api/function/set_group_call_title.dart';
import 'package:td_json_client/api/function/toggle_group_call_mute_new_participants.dart';
import 'package:td_json_client/api/function/invite_group_call_participants.dart';
import 'package:td_json_client/api/function/get_group_call_invite_link.dart';
import 'package:td_json_client/api/function/revoke_group_call_invite_link.dart';
import 'package:td_json_client/api/function/start_group_call_recording.dart';
import 'package:td_json_client/api/function/end_group_call_recording.dart';
import 'package:td_json_client/api/function/toggle_group_call_is_my_video_paused.dart';
import 'package:td_json_client/api/function/toggle_group_call_is_my_video_enabled.dart';
import 'package:td_json_client/api/function/set_group_call_participant_is_speaking.dart';
import 'package:td_json_client/api/function/toggle_group_call_participant_is_muted.dart';
import 'package:td_json_client/api/function/set_group_call_participant_volume_level.dart';
import 'package:td_json_client/api/function/toggle_group_call_participant_is_hand_raised.dart';
import 'package:td_json_client/api/function/load_group_call_participants.dart';
import 'package:td_json_client/api/function/leave_group_call.dart';
import 'package:td_json_client/api/function/end_group_call.dart';
import 'package:td_json_client/api/function/get_group_call_streams.dart';
import 'package:td_json_client/api/function/get_group_call_stream_segment.dart';
import 'package:td_json_client/api/function/toggle_message_sender_is_blocked.dart';
import 'package:td_json_client/api/function/block_message_sender_from_replies.dart';
import 'package:td_json_client/api/function/get_blocked_message_senders.dart';
import 'package:td_json_client/api/function/add_contact.dart';
import 'package:td_json_client/api/function/import_contacts.dart';
import 'package:td_json_client/api/function/get_contacts.dart';
import 'package:td_json_client/api/function/search_contacts.dart';
import 'package:td_json_client/api/function/remove_contacts.dart';
import 'package:td_json_client/api/function/get_imported_contact_count.dart';
import 'package:td_json_client/api/function/change_imported_contacts.dart';
import 'package:td_json_client/api/function/clear_imported_contacts.dart';
import 'package:td_json_client/api/function/search_user_by_phone_number.dart';
import 'package:td_json_client/api/function/share_phone_number.dart';
import 'package:td_json_client/api/function/get_user_profile_photos.dart';
import 'package:td_json_client/api/function/get_stickers.dart';
import 'package:td_json_client/api/function/search_stickers.dart';
import 'package:td_json_client/api/function/get_installed_sticker_sets.dart';
import 'package:td_json_client/api/function/get_archived_sticker_sets.dart';
import 'package:td_json_client/api/function/get_trending_sticker_sets.dart';
import 'package:td_json_client/api/function/get_attached_sticker_sets.dart';
import 'package:td_json_client/api/function/get_sticker_set.dart';
import 'package:td_json_client/api/function/search_sticker_set.dart';
import 'package:td_json_client/api/function/search_installed_sticker_sets.dart';
import 'package:td_json_client/api/function/search_sticker_sets.dart';
import 'package:td_json_client/api/function/change_sticker_set.dart';
import 'package:td_json_client/api/function/view_trending_sticker_sets.dart';
import 'package:td_json_client/api/function/reorder_installed_sticker_sets.dart';
import 'package:td_json_client/api/function/get_recent_stickers.dart';
import 'package:td_json_client/api/function/add_recent_sticker.dart';
import 'package:td_json_client/api/function/remove_recent_sticker.dart';
import 'package:td_json_client/api/function/clear_recent_stickers.dart';
import 'package:td_json_client/api/function/get_favorite_stickers.dart';
import 'package:td_json_client/api/function/add_favorite_sticker.dart';
import 'package:td_json_client/api/function/remove_favorite_sticker.dart';
import 'package:td_json_client/api/function/get_sticker_emojis.dart';
import 'package:td_json_client/api/function/search_emojis.dart';
import 'package:td_json_client/api/function/get_animated_emoji.dart';
import 'package:td_json_client/api/function/get_all_animated_emojis.dart';
import 'package:td_json_client/api/function/get_emoji_suggestions_url.dart';
import 'package:td_json_client/api/function/get_saved_animations.dart';
import 'package:td_json_client/api/function/add_saved_animation.dart';
import 'package:td_json_client/api/function/remove_saved_animation.dart';
import 'package:td_json_client/api/function/get_recent_inline_bots.dart';
import 'package:td_json_client/api/function/search_hashtags.dart';
import 'package:td_json_client/api/function/remove_recent_hashtag.dart';
import 'package:td_json_client/api/function/get_web_page_preview.dart';
import 'package:td_json_client/api/function/get_web_page_instant_view.dart';
import 'package:td_json_client/api/function/set_profile_photo.dart';
import 'package:td_json_client/api/function/delete_profile_photo.dart';
import 'package:td_json_client/api/function/set_name.dart';
import 'package:td_json_client/api/function/set_bio.dart';
import 'package:td_json_client/api/function/set_username.dart';
import 'package:td_json_client/api/function/set_location.dart';
import 'package:td_json_client/api/function/change_phone_number.dart';
import 'package:td_json_client/api/function/resend_change_phone_number_code.dart';
import 'package:td_json_client/api/function/check_change_phone_number_code.dart';
import 'package:td_json_client/api/function/set_commands.dart';
import 'package:td_json_client/api/function/delete_commands.dart';
import 'package:td_json_client/api/function/get_commands.dart';
import 'package:td_json_client/api/function/set_menu_button.dart';
import 'package:td_json_client/api/function/get_menu_button.dart';
import 'package:td_json_client/api/function/set_default_group_administrator_rights.dart';
import 'package:td_json_client/api/function/set_default_channel_administrator_rights.dart';
import 'package:td_json_client/api/function/get_active_sessions.dart';
import 'package:td_json_client/api/function/terminate_session.dart';
import 'package:td_json_client/api/function/terminate_all_other_sessions.dart';
import 'package:td_json_client/api/function/toggle_session_can_accept_calls.dart';
import 'package:td_json_client/api/function/toggle_session_can_accept_secret_chats.dart';
import 'package:td_json_client/api/function/set_inactive_session_ttl.dart';
import 'package:td_json_client/api/function/get_connected_websites.dart';
import 'package:td_json_client/api/function/disconnect_website.dart';
import 'package:td_json_client/api/function/disconnect_all_websites.dart';
import 'package:td_json_client/api/function/set_supergroup_username.dart';
import 'package:td_json_client/api/function/set_supergroup_sticker_set.dart';
import 'package:td_json_client/api/function/toggle_supergroup_sign_messages.dart';
import 'package:td_json_client/api/function/toggle_supergroup_join_to_send_messages.dart';
import 'package:td_json_client/api/function/toggle_supergroup_join_by_request.dart';
import 'package:td_json_client/api/function/toggle_supergroup_is_all_history_available.dart';
import 'package:td_json_client/api/function/toggle_supergroup_is_broadcast_group.dart';
import 'package:td_json_client/api/function/report_supergroup_spam.dart';
import 'package:td_json_client/api/function/get_supergroup_members.dart';
import 'package:td_json_client/api/function/close_secret_chat.dart';
import 'package:td_json_client/api/function/get_chat_event_log.dart';
import 'package:td_json_client/api/function/get_payment_form.dart';
import 'package:td_json_client/api/function/validate_order_info.dart';
import 'package:td_json_client/api/function/send_payment_form.dart';
import 'package:td_json_client/api/function/get_payment_receipt.dart';
import 'package:td_json_client/api/function/get_saved_order_info.dart';
import 'package:td_json_client/api/function/delete_saved_order_info.dart';
import 'package:td_json_client/api/function/delete_saved_credentials.dart';
import 'package:td_json_client/api/function/create_invoice_link.dart';
import 'package:td_json_client/api/function/get_support_user.dart';
import 'package:td_json_client/api/function/get_backgrounds.dart';
import 'package:td_json_client/api/function/get_background_url.dart';
import 'package:td_json_client/api/function/search_background.dart';
import 'package:td_json_client/api/function/set_background.dart';
import 'package:td_json_client/api/function/remove_background.dart';
import 'package:td_json_client/api/function/reset_backgrounds.dart';
import 'package:td_json_client/api/function/get_localization_target_info.dart';
import 'package:td_json_client/api/function/get_language_pack_info.dart';
import 'package:td_json_client/api/function/get_language_pack_strings.dart';
import 'package:td_json_client/api/function/synchronize_language_pack.dart';
import 'package:td_json_client/api/function/add_custom_server_language_pack.dart';
import 'package:td_json_client/api/function/set_custom_language_pack.dart';
import 'package:td_json_client/api/function/edit_custom_language_pack_info.dart';
import 'package:td_json_client/api/function/set_custom_language_pack_string.dart';
import 'package:td_json_client/api/function/delete_language_pack.dart';
import 'package:td_json_client/api/function/register_device.dart';
import 'package:td_json_client/api/function/process_push_notification.dart';
import 'package:td_json_client/api/function/get_push_receiver_id.dart';
import 'package:td_json_client/api/function/get_recently_visited_t_me_urls.dart';
import 'package:td_json_client/api/function/set_user_privacy_setting_rules.dart';
import 'package:td_json_client/api/function/get_user_privacy_setting_rules.dart';
import 'package:td_json_client/api/function/get_option.dart';
import 'package:td_json_client/api/function/set_option.dart';
import 'package:td_json_client/api/function/set_account_ttl.dart';
import 'package:td_json_client/api/function/get_account_ttl.dart';
import 'package:td_json_client/api/function/delete_account.dart';
import 'package:td_json_client/api/function/remove_chat_action_bar.dart';
import 'package:td_json_client/api/function/report_chat.dart';
import 'package:td_json_client/api/function/report_chat_photo.dart';
import 'package:td_json_client/api/function/get_chat_statistics.dart';
import 'package:td_json_client/api/function/get_message_statistics.dart';
import 'package:td_json_client/api/function/get_statistical_graph.dart';
import 'package:td_json_client/api/function/get_storage_statistics.dart';
import 'package:td_json_client/api/function/get_storage_statistics_fast.dart';
import 'package:td_json_client/api/function/get_database_statistics.dart';
import 'package:td_json_client/api/function/optimize_storage.dart';
import 'package:td_json_client/api/function/set_network_type.dart';
import 'package:td_json_client/api/function/get_network_statistics.dart';
import 'package:td_json_client/api/function/add_network_statistics.dart';
import 'package:td_json_client/api/function/reset_network_statistics.dart';
import 'package:td_json_client/api/function/get_auto_download_settings_presets.dart';
import 'package:td_json_client/api/function/set_auto_download_settings.dart';
import 'package:td_json_client/api/function/get_bank_card_info.dart';
import 'package:td_json_client/api/function/get_passport_element.dart';
import 'package:td_json_client/api/function/get_all_passport_elements.dart';
import 'package:td_json_client/api/function/set_passport_element.dart';
import 'package:td_json_client/api/function/delete_passport_element.dart';
import 'package:td_json_client/api/function/set_passport_element_errors.dart';
import 'package:td_json_client/api/function/get_preferred_country_language.dart';
import 'package:td_json_client/api/function/send_phone_number_verification_code.dart';
import 'package:td_json_client/api/function/resend_phone_number_verification_code.dart';
import 'package:td_json_client/api/function/check_phone_number_verification_code.dart';
import 'package:td_json_client/api/function/send_email_address_verification_code.dart';
import 'package:td_json_client/api/function/resend_email_address_verification_code.dart';
import 'package:td_json_client/api/function/check_email_address_verification_code.dart';
import 'package:td_json_client/api/function/get_passport_authorization_form.dart';
import 'package:td_json_client/api/function/get_passport_authorization_form_available_elements.dart';
import 'package:td_json_client/api/function/send_passport_authorization_form.dart';
import 'package:td_json_client/api/function/send_phone_number_confirmation_code.dart';
import 'package:td_json_client/api/function/resend_phone_number_confirmation_code.dart';
import 'package:td_json_client/api/function/check_phone_number_confirmation_code.dart';
import 'package:td_json_client/api/function/set_bot_updates_status.dart';
import 'package:td_json_client/api/function/upload_sticker_file.dart';
import 'package:td_json_client/api/function/get_suggested_sticker_set_name.dart';
import 'package:td_json_client/api/function/check_sticker_set_name.dart';
import 'package:td_json_client/api/function/create_new_sticker_set.dart';
import 'package:td_json_client/api/function/add_sticker_to_set.dart';
import 'package:td_json_client/api/function/set_sticker_set_thumbnail.dart';
import 'package:td_json_client/api/function/set_sticker_position_in_set.dart';
import 'package:td_json_client/api/function/remove_sticker_from_set.dart';
import 'package:td_json_client/api/function/get_map_thumbnail_file.dart';
import 'package:td_json_client/api/function/get_premium_limit.dart';
import 'package:td_json_client/api/function/get_premium_features.dart';
import 'package:td_json_client/api/function/get_premium_stickers.dart';
import 'package:td_json_client/api/function/view_premium_feature.dart';
import 'package:td_json_client/api/function/click_premium_subscription_button.dart';
import 'package:td_json_client/api/function/get_premium_state.dart';
import 'package:td_json_client/api/function/can_purchase_premium.dart';
import 'package:td_json_client/api/function/assign_app_store_transaction.dart';
import 'package:td_json_client/api/function/assign_google_play_transaction.dart';
import 'package:td_json_client/api/function/accept_terms_of_service.dart';
import 'package:td_json_client/api/function/send_custom_request.dart';
import 'package:td_json_client/api/function/answer_custom_query.dart';
import 'package:td_json_client/api/function/set_alarm.dart';
import 'package:td_json_client/api/function/get_countries.dart';
import 'package:td_json_client/api/function/get_country_code.dart';
import 'package:td_json_client/api/function/get_phone_number_info.dart';
import 'package:td_json_client/api/function/get_phone_number_info_sync.dart';
import 'package:td_json_client/api/function/get_application_download_link.dart';
import 'package:td_json_client/api/function/get_deep_link_info.dart';
import 'package:td_json_client/api/function/get_application_config.dart';
import 'package:td_json_client/api/function/save_application_log_event.dart';
import 'package:td_json_client/api/function/add_proxy.dart';
import 'package:td_json_client/api/function/edit_proxy.dart';
import 'package:td_json_client/api/function/enable_proxy.dart';
import 'package:td_json_client/api/function/disable_proxy.dart';
import 'package:td_json_client/api/function/remove_proxy.dart';
import 'package:td_json_client/api/function/get_proxies.dart';
import 'package:td_json_client/api/function/get_proxy_link.dart';
import 'package:td_json_client/api/function/ping_proxy.dart';
import 'package:td_json_client/api/function/set_log_stream.dart';
import 'package:td_json_client/api/function/get_log_stream.dart';
import 'package:td_json_client/api/function/set_log_verbosity_level.dart';
import 'package:td_json_client/api/function/get_log_verbosity_level.dart';
import 'package:td_json_client/api/function/get_log_tags.dart';
import 'package:td_json_client/api/function/set_log_tag_verbosity_level.dart';
import 'package:td_json_client/api/function/get_log_tag_verbosity_level.dart';
import 'package:td_json_client/api/function/add_log_message.dart';
import 'package:td_json_client/api/function/test_call_empty.dart';
import 'package:td_json_client/api/function/test_call_string.dart';
import 'package:td_json_client/api/function/test_call_bytes.dart';
import 'package:td_json_client/api/function/test_call_vector_int.dart';
import 'package:td_json_client/api/function/test_call_vector_int_object.dart';
import 'package:td_json_client/api/function/test_call_vector_string.dart';
import 'package:td_json_client/api/function/test_call_vector_string_object.dart';
import 'package:td_json_client/api/function/test_square_int.dart';
import 'package:td_json_client/api/function/test_network.dart';
import 'package:td_json_client/api/function/test_proxy.dart';
import 'package:td_json_client/api/function/test_get_difference.dart';
import 'package:td_json_client/api/function/test_use_update.dart';
import 'package:td_json_client/api/function/test_return_error.dart';

/// Telegram API map from [String]s to [Td] objects.
class TdApiMap {
  /// Map from TL type (the field @type) to [Td] object.
  static Map<String, dynamic Function(Map<String, dynamic>)> _tdMap = {
    'error': (map) => Error.fromMap(map),
    'ok': (map) => Ok.fromMap(map),
    'tdlibParameters': (map) => TdlibParameters.fromMap(map),
    'authenticationCodeTypeTelegramMessage': (map) => AuthenticationCodeTypeTelegramMessage.fromMap(map),
    'authenticationCodeTypeSms': (map) => AuthenticationCodeTypeSms.fromMap(map),
    'authenticationCodeTypeCall': (map) => AuthenticationCodeTypeCall.fromMap(map),
    'authenticationCodeTypeFlashCall': (map) => AuthenticationCodeTypeFlashCall.fromMap(map),
    'authenticationCodeTypeMissedCall': (map) => AuthenticationCodeTypeMissedCall.fromMap(map),
    'authenticationCodeInfo': (map) => AuthenticationCodeInfo.fromMap(map),
    'emailAddressAuthenticationCodeInfo': (map) => EmailAddressAuthenticationCodeInfo.fromMap(map),
    'textEntity': (map) => TextEntity.fromMap(map),
    'textEntities': (map) => TextEntities.fromMap(map),
    'formattedText': (map) => FormattedText.fromMap(map),
    'termsOfService': (map) => TermsOfService.fromMap(map),
    'authorizationStateWaitTdlibParameters': (map) => AuthorizationStateWaitTdlibParameters.fromMap(map),
    'authorizationStateWaitEncryptionKey': (map) => AuthorizationStateWaitEncryptionKey.fromMap(map),
    'authorizationStateWaitPhoneNumber': (map) => AuthorizationStateWaitPhoneNumber.fromMap(map),
    'authorizationStateWaitCode': (map) => AuthorizationStateWaitCode.fromMap(map),
    'authorizationStateWaitOtherDeviceConfirmation': (map) => AuthorizationStateWaitOtherDeviceConfirmation.fromMap(map),
    'authorizationStateWaitRegistration': (map) => AuthorizationStateWaitRegistration.fromMap(map),
    'authorizationStateWaitPassword': (map) => AuthorizationStateWaitPassword.fromMap(map),
    'authorizationStateReady': (map) => AuthorizationStateReady.fromMap(map),
    'authorizationStateLoggingOut': (map) => AuthorizationStateLoggingOut.fromMap(map),
    'authorizationStateClosing': (map) => AuthorizationStateClosing.fromMap(map),
    'authorizationStateClosed': (map) => AuthorizationStateClosed.fromMap(map),
    'passwordState': (map) => PasswordState.fromMap(map),
    'recoveryEmailAddress': (map) => RecoveryEmailAddress.fromMap(map),
    'temporaryPasswordState': (map) => TemporaryPasswordState.fromMap(map),
    'localFile': (map) => LocalFile.fromMap(map),
    'remoteFile': (map) => RemoteFile.fromMap(map),
    'file': (map) => File.fromMap(map),
    'inputFileId': (map) => InputFileId.fromMap(map),
    'inputFileRemote': (map) => InputFileRemote.fromMap(map),
    'inputFileLocal': (map) => InputFileLocal.fromMap(map),
    'inputFileGenerated': (map) => InputFileGenerated.fromMap(map),
    'photoSize': (map) => PhotoSize.fromMap(map),
    'minithumbnail': (map) => Minithumbnail.fromMap(map),
    'thumbnailFormatJpeg': (map) => ThumbnailFormatJpeg.fromMap(map),
    'thumbnailFormatGif': (map) => ThumbnailFormatGif.fromMap(map),
    'thumbnailFormatMpeg4': (map) => ThumbnailFormatMpeg4.fromMap(map),
    'thumbnailFormatPng': (map) => ThumbnailFormatPng.fromMap(map),
    'thumbnailFormatTgs': (map) => ThumbnailFormatTgs.fromMap(map),
    'thumbnailFormatWebm': (map) => ThumbnailFormatWebm.fromMap(map),
    'thumbnailFormatWebp': (map) => ThumbnailFormatWebp.fromMap(map),
    'thumbnail': (map) => Thumbnail.fromMap(map),
    'maskPointForehead': (map) => MaskPointForehead.fromMap(map),
    'maskPointEyes': (map) => MaskPointEyes.fromMap(map),
    'maskPointMouth': (map) => MaskPointMouth.fromMap(map),
    'maskPointChin': (map) => MaskPointChin.fromMap(map),
    'maskPosition': (map) => MaskPosition.fromMap(map),
    'stickerTypeStatic': (map) => StickerTypeStatic.fromMap(map),
    'stickerTypeAnimated': (map) => StickerTypeAnimated.fromMap(map),
    'stickerTypeVideo': (map) => StickerTypeVideo.fromMap(map),
    'stickerTypeMask': (map) => StickerTypeMask.fromMap(map),
    'closedVectorPath': (map) => ClosedVectorPath.fromMap(map),
    'pollOption': (map) => PollOption.fromMap(map),
    'pollTypeRegular': (map) => PollTypeRegular.fromMap(map),
    'pollTypeQuiz': (map) => PollTypeQuiz.fromMap(map),
    'animation': (map) => Animation.fromMap(map),
    'audio': (map) => Audio.fromMap(map),
    'document': (map) => Document.fromMap(map),
    'photo': (map) => Photo.fromMap(map),
    'sticker': (map) => Sticker.fromMap(map),
    'video': (map) => Video.fromMap(map),
    'videoNote': (map) => VideoNote.fromMap(map),
    'voiceNote': (map) => VoiceNote.fromMap(map),
    'animatedEmoji': (map) => AnimatedEmoji.fromMap(map),
    'contact': (map) => Contact.fromMap(map),
    'location': (map) => Location.fromMap(map),
    'venue': (map) => Venue.fromMap(map),
    'game': (map) => Game.fromMap(map),
    'poll': (map) => Poll.fromMap(map),
    'profilePhoto': (map) => ProfilePhoto.fromMap(map),
    'chatPhotoInfo': (map) => ChatPhotoInfo.fromMap(map),
    'userTypeRegular': (map) => UserTypeRegular.fromMap(map),
    'userTypeDeleted': (map) => UserTypeDeleted.fromMap(map),
    'userTypeBot': (map) => UserTypeBot.fromMap(map),
    'userTypeUnknown': (map) => UserTypeUnknown.fromMap(map),
    'botCommand': (map) => BotCommand.fromMap(map),
    'botCommands': (map) => BotCommands.fromMap(map),
    'botMenuButton': (map) => BotMenuButton.fromMap(map),
    'chatLocation': (map) => ChatLocation.fromMap(map),
    'animatedChatPhoto': (map) => AnimatedChatPhoto.fromMap(map),
    'chatPhoto': (map) => ChatPhoto.fromMap(map),
    'chatPhotos': (map) => ChatPhotos.fromMap(map),
    'inputChatPhotoPrevious': (map) => InputChatPhotoPrevious.fromMap(map),
    'inputChatPhotoStatic': (map) => InputChatPhotoStatic.fromMap(map),
    'inputChatPhotoAnimation': (map) => InputChatPhotoAnimation.fromMap(map),
    'chatPermissions': (map) => ChatPermissions.fromMap(map),
    'chatAdministratorRights': (map) => ChatAdministratorRights.fromMap(map),
    'user': (map) => User.fromMap(map),
    'botInfo': (map) => BotInfo.fromMap(map),
    'userFullInfo': (map) => UserFullInfo.fromMap(map),
    'users': (map) => Users.fromMap(map),
    'chatAdministrator': (map) => ChatAdministrator.fromMap(map),
    'chatAdministrators': (map) => ChatAdministrators.fromMap(map),
    'chatMemberStatusCreator': (map) => ChatMemberStatusCreator.fromMap(map),
    'chatMemberStatusAdministrator': (map) => ChatMemberStatusAdministrator.fromMap(map),
    'chatMemberStatusMember': (map) => ChatMemberStatusMember.fromMap(map),
    'chatMemberStatusRestricted': (map) => ChatMemberStatusRestricted.fromMap(map),
    'chatMemberStatusLeft': (map) => ChatMemberStatusLeft.fromMap(map),
    'chatMemberStatusBanned': (map) => ChatMemberStatusBanned.fromMap(map),
    'chatMember': (map) => ChatMember.fromMap(map),
    'chatMembers': (map) => ChatMembers.fromMap(map),
    'chatMembersFilterContacts': (map) => ChatMembersFilterContacts.fromMap(map),
    'chatMembersFilterAdministrators': (map) => ChatMembersFilterAdministrators.fromMap(map),
    'chatMembersFilterMembers': (map) => ChatMembersFilterMembers.fromMap(map),
    'chatMembersFilterMention': (map) => ChatMembersFilterMention.fromMap(map),
    'chatMembersFilterRestricted': (map) => ChatMembersFilterRestricted.fromMap(map),
    'chatMembersFilterBanned': (map) => ChatMembersFilterBanned.fromMap(map),
    'chatMembersFilterBots': (map) => ChatMembersFilterBots.fromMap(map),
    'supergroupMembersFilterRecent': (map) => SupergroupMembersFilterRecent.fromMap(map),
    'supergroupMembersFilterContacts': (map) => SupergroupMembersFilterContacts.fromMap(map),
    'supergroupMembersFilterAdministrators': (map) => SupergroupMembersFilterAdministrators.fromMap(map),
    'supergroupMembersFilterSearch': (map) => SupergroupMembersFilterSearch.fromMap(map),
    'supergroupMembersFilterRestricted': (map) => SupergroupMembersFilterRestricted.fromMap(map),
    'supergroupMembersFilterBanned': (map) => SupergroupMembersFilterBanned.fromMap(map),
    'supergroupMembersFilterMention': (map) => SupergroupMembersFilterMention.fromMap(map),
    'supergroupMembersFilterBots': (map) => SupergroupMembersFilterBots.fromMap(map),
    'chatInviteLink': (map) => ChatInviteLink.fromMap(map),
    'chatInviteLinks': (map) => ChatInviteLinks.fromMap(map),
    'chatInviteLinkCount': (map) => ChatInviteLinkCount.fromMap(map),
    'chatInviteLinkCounts': (map) => ChatInviteLinkCounts.fromMap(map),
    'chatInviteLinkMember': (map) => ChatInviteLinkMember.fromMap(map),
    'chatInviteLinkMembers': (map) => ChatInviteLinkMembers.fromMap(map),
    'chatInviteLinkInfo': (map) => ChatInviteLinkInfo.fromMap(map),
    'chatJoinRequest': (map) => ChatJoinRequest.fromMap(map),
    'chatJoinRequests': (map) => ChatJoinRequests.fromMap(map),
    'chatJoinRequestsInfo': (map) => ChatJoinRequestsInfo.fromMap(map),
    'basicGroup': (map) => BasicGroup.fromMap(map),
    'basicGroupFullInfo': (map) => BasicGroupFullInfo.fromMap(map),
    'supergroup': (map) => Supergroup.fromMap(map),
    'supergroupFullInfo': (map) => SupergroupFullInfo.fromMap(map),
    'secretChatStatePending': (map) => SecretChatStatePending.fromMap(map),
    'secretChatStateReady': (map) => SecretChatStateReady.fromMap(map),
    'secretChatStateClosed': (map) => SecretChatStateClosed.fromMap(map),
    'secretChat': (map) => SecretChat.fromMap(map),
    'messageSenderUser': (map) => MessageSenderUser.fromMap(map),
    'messageSenderChat': (map) => MessageSenderChat.fromMap(map),
    'messageSenders': (map) => MessageSenders.fromMap(map),
    'messageForwardOriginUser': (map) => MessageForwardOriginUser.fromMap(map),
    'messageForwardOriginChat': (map) => MessageForwardOriginChat.fromMap(map),
    'messageForwardOriginHiddenUser': (map) => MessageForwardOriginHiddenUser.fromMap(map),
    'messageForwardOriginChannel': (map) => MessageForwardOriginChannel.fromMap(map),
    'messageForwardOriginMessageImport': (map) => MessageForwardOriginMessageImport.fromMap(map),
    'messageForwardInfo': (map) => MessageForwardInfo.fromMap(map),
    'messageReplyInfo': (map) => MessageReplyInfo.fromMap(map),
    'messageReaction': (map) => MessageReaction.fromMap(map),
    'messageInteractionInfo': (map) => MessageInteractionInfo.fromMap(map),
    'unreadReaction': (map) => UnreadReaction.fromMap(map),
    'messageSendingStatePending': (map) => MessageSendingStatePending.fromMap(map),
    'messageSendingStateFailed': (map) => MessageSendingStateFailed.fromMap(map),
    'message': (map) => Message.fromMap(map),
    'messages': (map) => Messages.fromMap(map),
    'foundMessages': (map) => FoundMessages.fromMap(map),
    'messagePosition': (map) => MessagePosition.fromMap(map),
    'messagePositions': (map) => MessagePositions.fromMap(map),
    'messageCalendarDay': (map) => MessageCalendarDay.fromMap(map),
    'messageCalendar': (map) => MessageCalendar.fromMap(map),
    'sponsoredMessage': (map) => SponsoredMessage.fromMap(map),
    'fileDownload': (map) => FileDownload.fromMap(map),
    'downloadedFileCounts': (map) => DownloadedFileCounts.fromMap(map),
    'foundFileDownloads': (map) => FoundFileDownloads.fromMap(map),
    'notificationSettingsScopePrivateChats': (map) => NotificationSettingsScopePrivateChats.fromMap(map),
    'notificationSettingsScopeGroupChats': (map) => NotificationSettingsScopeGroupChats.fromMap(map),
    'notificationSettingsScopeChannelChats': (map) => NotificationSettingsScopeChannelChats.fromMap(map),
    'chatNotificationSettings': (map) => ChatNotificationSettings.fromMap(map),
    'scopeNotificationSettings': (map) => ScopeNotificationSettings.fromMap(map),
    'draftMessage': (map) => DraftMessage.fromMap(map),
    'chatTypePrivate': (map) => ChatTypePrivate.fromMap(map),
    'chatTypeBasicGroup': (map) => ChatTypeBasicGroup.fromMap(map),
    'chatTypeSupergroup': (map) => ChatTypeSupergroup.fromMap(map),
    'chatTypeSecret': (map) => ChatTypeSecret.fromMap(map),
    'chatFilter': (map) => ChatFilter.fromMap(map),
    'chatFilterInfo': (map) => ChatFilterInfo.fromMap(map),
    'recommendedChatFilter': (map) => RecommendedChatFilter.fromMap(map),
    'recommendedChatFilters': (map) => RecommendedChatFilters.fromMap(map),
    'chatListMain': (map) => ChatListMain.fromMap(map),
    'chatListArchive': (map) => ChatListArchive.fromMap(map),
    'chatListFilter': (map) => ChatListFilter.fromMap(map),
    'chatLists': (map) => ChatLists.fromMap(map),
    'chatSourceMtprotoProxy': (map) => ChatSourceMtprotoProxy.fromMap(map),
    'chatSourcePublicServiceAnnouncement': (map) => ChatSourcePublicServiceAnnouncement.fromMap(map),
    'chatPosition': (map) => ChatPosition.fromMap(map),
    'videoChat': (map) => VideoChat.fromMap(map),
    'chat': (map) => Chat.fromMap(map),
    'chats': (map) => Chats.fromMap(map),
    'chatNearby': (map) => ChatNearby.fromMap(map),
    'chatsNearby': (map) => ChatsNearby.fromMap(map),
    'publicChatTypeHasUsername': (map) => PublicChatTypeHasUsername.fromMap(map),
    'publicChatTypeIsLocationBased': (map) => PublicChatTypeIsLocationBased.fromMap(map),
    'chatActionBarReportSpam': (map) => ChatActionBarReportSpam.fromMap(map),
    'chatActionBarReportUnrelatedLocation': (map) => ChatActionBarReportUnrelatedLocation.fromMap(map),
    'chatActionBarInviteMembers': (map) => ChatActionBarInviteMembers.fromMap(map),
    'chatActionBarReportAddBlock': (map) => ChatActionBarReportAddBlock.fromMap(map),
    'chatActionBarAddContact': (map) => ChatActionBarAddContact.fromMap(map),
    'chatActionBarSharePhoneNumber': (map) => ChatActionBarSharePhoneNumber.fromMap(map),
    'chatActionBarJoinRequest': (map) => ChatActionBarJoinRequest.fromMap(map),
    'keyboardButtonTypeText': (map) => KeyboardButtonTypeText.fromMap(map),
    'keyboardButtonTypeRequestPhoneNumber': (map) => KeyboardButtonTypeRequestPhoneNumber.fromMap(map),
    'keyboardButtonTypeRequestLocation': (map) => KeyboardButtonTypeRequestLocation.fromMap(map),
    'keyboardButtonTypeRequestPoll': (map) => KeyboardButtonTypeRequestPoll.fromMap(map),
    'keyboardButtonTypeWebApp': (map) => KeyboardButtonTypeWebApp.fromMap(map),
    'keyboardButton': (map) => KeyboardButton.fromMap(map),
    'inlineKeyboardButtonTypeUrl': (map) => InlineKeyboardButtonTypeUrl.fromMap(map),
    'inlineKeyboardButtonTypeLoginUrl': (map) => InlineKeyboardButtonTypeLoginUrl.fromMap(map),
    'inlineKeyboardButtonTypeWebApp': (map) => InlineKeyboardButtonTypeWebApp.fromMap(map),
    'inlineKeyboardButtonTypeCallback': (map) => InlineKeyboardButtonTypeCallback.fromMap(map),
    'inlineKeyboardButtonTypeCallbackWithPassword': (map) => InlineKeyboardButtonTypeCallbackWithPassword.fromMap(map),
    'inlineKeyboardButtonTypeCallbackGame': (map) => InlineKeyboardButtonTypeCallbackGame.fromMap(map),
    'inlineKeyboardButtonTypeSwitchInline': (map) => InlineKeyboardButtonTypeSwitchInline.fromMap(map),
    'inlineKeyboardButtonTypeBuy': (map) => InlineKeyboardButtonTypeBuy.fromMap(map),
    'inlineKeyboardButtonTypeUser': (map) => InlineKeyboardButtonTypeUser.fromMap(map),
    'inlineKeyboardButton': (map) => InlineKeyboardButton.fromMap(map),
    'replyMarkupRemoveKeyboard': (map) => ReplyMarkupRemoveKeyboard.fromMap(map),
    'replyMarkupForceReply': (map) => ReplyMarkupForceReply.fromMap(map),
    'replyMarkupShowKeyboard': (map) => ReplyMarkupShowKeyboard.fromMap(map),
    'replyMarkupInlineKeyboard': (map) => ReplyMarkupInlineKeyboard.fromMap(map),
    'loginUrlInfoOpen': (map) => LoginUrlInfoOpen.fromMap(map),
    'loginUrlInfoRequestConfirmation': (map) => LoginUrlInfoRequestConfirmation.fromMap(map),
    'webAppInfo': (map) => WebAppInfo.fromMap(map),
    'messageThreadInfo': (map) => MessageThreadInfo.fromMap(map),
    'richTextPlain': (map) => RichTextPlain.fromMap(map),
    'richTextBold': (map) => RichTextBold.fromMap(map),
    'richTextItalic': (map) => RichTextItalic.fromMap(map),
    'richTextUnderline': (map) => RichTextUnderline.fromMap(map),
    'richTextStrikethrough': (map) => RichTextStrikethrough.fromMap(map),
    'richTextFixed': (map) => RichTextFixed.fromMap(map),
    'richTextUrl': (map) => RichTextUrl.fromMap(map),
    'richTextEmailAddress': (map) => RichTextEmailAddress.fromMap(map),
    'richTextSubscript': (map) => RichTextSubscript.fromMap(map),
    'richTextSuperscript': (map) => RichTextSuperscript.fromMap(map),
    'richTextMarked': (map) => RichTextMarked.fromMap(map),
    'richTextPhoneNumber': (map) => RichTextPhoneNumber.fromMap(map),
    'richTextIcon': (map) => RichTextIcon.fromMap(map),
    'richTextReference': (map) => RichTextReference.fromMap(map),
    'richTextAnchor': (map) => RichTextAnchor.fromMap(map),
    'richTextAnchorLink': (map) => RichTextAnchorLink.fromMap(map),
    'richTexts': (map) => RichTexts.fromMap(map),
    'pageBlockCaption': (map) => PageBlockCaption.fromMap(map),
    'pageBlockListItem': (map) => PageBlockListItem.fromMap(map),
    'pageBlockHorizontalAlignmentLeft': (map) => PageBlockHorizontalAlignmentLeft.fromMap(map),
    'pageBlockHorizontalAlignmentCenter': (map) => PageBlockHorizontalAlignmentCenter.fromMap(map),
    'pageBlockHorizontalAlignmentRight': (map) => PageBlockHorizontalAlignmentRight.fromMap(map),
    'pageBlockVerticalAlignmentTop': (map) => PageBlockVerticalAlignmentTop.fromMap(map),
    'pageBlockVerticalAlignmentMiddle': (map) => PageBlockVerticalAlignmentMiddle.fromMap(map),
    'pageBlockVerticalAlignmentBottom': (map) => PageBlockVerticalAlignmentBottom.fromMap(map),
    'pageBlockTableCell': (map) => PageBlockTableCell.fromMap(map),
    'pageBlockRelatedArticle': (map) => PageBlockRelatedArticle.fromMap(map),
    'pageBlockTitle': (map) => PageBlockTitle.fromMap(map),
    'pageBlockSubtitle': (map) => PageBlockSubtitle.fromMap(map),
    'pageBlockAuthorDate': (map) => PageBlockAuthorDate.fromMap(map),
    'pageBlockHeader': (map) => PageBlockHeader.fromMap(map),
    'pageBlockSubheader': (map) => PageBlockSubheader.fromMap(map),
    'pageBlockKicker': (map) => PageBlockKicker.fromMap(map),
    'pageBlockParagraph': (map) => PageBlockParagraph.fromMap(map),
    'pageBlockPreformatted': (map) => PageBlockPreformatted.fromMap(map),
    'pageBlockFooter': (map) => PageBlockFooter.fromMap(map),
    'pageBlockDivider': (map) => PageBlockDivider.fromMap(map),
    'pageBlockAnchor': (map) => PageBlockAnchor.fromMap(map),
    'pageBlockList': (map) => PageBlockList.fromMap(map),
    'pageBlockBlockQuote': (map) => PageBlockBlockQuote.fromMap(map),
    'pageBlockPullQuote': (map) => PageBlockPullQuote.fromMap(map),
    'pageBlockAnimation': (map) => PageBlockAnimation.fromMap(map),
    'pageBlockAudio': (map) => PageBlockAudio.fromMap(map),
    'pageBlockPhoto': (map) => PageBlockPhoto.fromMap(map),
    'pageBlockVideo': (map) => PageBlockVideo.fromMap(map),
    'pageBlockVoiceNote': (map) => PageBlockVoiceNote.fromMap(map),
    'pageBlockCover': (map) => PageBlockCover.fromMap(map),
    'pageBlockEmbedded': (map) => PageBlockEmbedded.fromMap(map),
    'pageBlockEmbeddedPost': (map) => PageBlockEmbeddedPost.fromMap(map),
    'pageBlockCollage': (map) => PageBlockCollage.fromMap(map),
    'pageBlockSlideshow': (map) => PageBlockSlideshow.fromMap(map),
    'pageBlockChatLink': (map) => PageBlockChatLink.fromMap(map),
    'pageBlockTable': (map) => PageBlockTable.fromMap(map),
    'pageBlockDetails': (map) => PageBlockDetails.fromMap(map),
    'pageBlockRelatedArticles': (map) => PageBlockRelatedArticles.fromMap(map),
    'pageBlockMap': (map) => PageBlockMap.fromMap(map),
    'webPageInstantView': (map) => WebPageInstantView.fromMap(map),
    'webPage': (map) => WebPage.fromMap(map),
    'countryInfo': (map) => CountryInfo.fromMap(map),
    'countries': (map) => Countries.fromMap(map),
    'phoneNumberInfo': (map) => PhoneNumberInfo.fromMap(map),
    'bankCardActionOpenUrl': (map) => BankCardActionOpenUrl.fromMap(map),
    'bankCardInfo': (map) => BankCardInfo.fromMap(map),
    'address': (map) => Address.fromMap(map),
    'themeParameters': (map) => ThemeParameters.fromMap(map),
    'labeledPricePart': (map) => LabeledPricePart.fromMap(map),
    'invoice': (map) => Invoice.fromMap(map),
    'orderInfo': (map) => OrderInfo.fromMap(map),
    'shippingOption': (map) => ShippingOption.fromMap(map),
    'savedCredentials': (map) => SavedCredentials.fromMap(map),
    'inputCredentialsSaved': (map) => InputCredentialsSaved.fromMap(map),
    'inputCredentialsNew': (map) => InputCredentialsNew.fromMap(map),
    'inputCredentialsApplePay': (map) => InputCredentialsApplePay.fromMap(map),
    'inputCredentialsGooglePay': (map) => InputCredentialsGooglePay.fromMap(map),
    'paymentProviderSmartGlocal': (map) => PaymentProviderSmartGlocal.fromMap(map),
    'paymentProviderStripe': (map) => PaymentProviderStripe.fromMap(map),
    'paymentProviderOther': (map) => PaymentProviderOther.fromMap(map),
    'paymentForm': (map) => PaymentForm.fromMap(map),
    'validatedOrderInfo': (map) => ValidatedOrderInfo.fromMap(map),
    'paymentResult': (map) => PaymentResult.fromMap(map),
    'paymentReceipt': (map) => PaymentReceipt.fromMap(map),
    'inputInvoiceMessage': (map) => InputInvoiceMessage.fromMap(map),
    'inputInvoiceName': (map) => InputInvoiceName.fromMap(map),
    'datedFile': (map) => DatedFile.fromMap(map),
    'passportElementTypePersonalDetails': (map) => PassportElementTypePersonalDetails.fromMap(map),
    'passportElementTypePassport': (map) => PassportElementTypePassport.fromMap(map),
    'passportElementTypeDriverLicense': (map) => PassportElementTypeDriverLicense.fromMap(map),
    'passportElementTypeIdentityCard': (map) => PassportElementTypeIdentityCard.fromMap(map),
    'passportElementTypeInternalPassport': (map) => PassportElementTypeInternalPassport.fromMap(map),
    'passportElementTypeAddress': (map) => PassportElementTypeAddress.fromMap(map),
    'passportElementTypeUtilityBill': (map) => PassportElementTypeUtilityBill.fromMap(map),
    'passportElementTypeBankStatement': (map) => PassportElementTypeBankStatement.fromMap(map),
    'passportElementTypeRentalAgreement': (map) => PassportElementTypeRentalAgreement.fromMap(map),
    'passportElementTypePassportRegistration': (map) => PassportElementTypePassportRegistration.fromMap(map),
    'passportElementTypeTemporaryRegistration': (map) => PassportElementTypeTemporaryRegistration.fromMap(map),
    'passportElementTypePhoneNumber': (map) => PassportElementTypePhoneNumber.fromMap(map),
    'passportElementTypeEmailAddress': (map) => PassportElementTypeEmailAddress.fromMap(map),
    'date': (map) => Date.fromMap(map),
    'personalDetails': (map) => PersonalDetails.fromMap(map),
    'identityDocument': (map) => IdentityDocument.fromMap(map),
    'inputIdentityDocument': (map) => InputIdentityDocument.fromMap(map),
    'personalDocument': (map) => PersonalDocument.fromMap(map),
    'inputPersonalDocument': (map) => InputPersonalDocument.fromMap(map),
    'passportElementPersonalDetails': (map) => PassportElementPersonalDetails.fromMap(map),
    'passportElementPassport': (map) => PassportElementPassport.fromMap(map),
    'passportElementDriverLicense': (map) => PassportElementDriverLicense.fromMap(map),
    'passportElementIdentityCard': (map) => PassportElementIdentityCard.fromMap(map),
    'passportElementInternalPassport': (map) => PassportElementInternalPassport.fromMap(map),
    'passportElementAddress': (map) => PassportElementAddress.fromMap(map),
    'passportElementUtilityBill': (map) => PassportElementUtilityBill.fromMap(map),
    'passportElementBankStatement': (map) => PassportElementBankStatement.fromMap(map),
    'passportElementRentalAgreement': (map) => PassportElementRentalAgreement.fromMap(map),
    'passportElementPassportRegistration': (map) => PassportElementPassportRegistration.fromMap(map),
    'passportElementTemporaryRegistration': (map) => PassportElementTemporaryRegistration.fromMap(map),
    'passportElementPhoneNumber': (map) => PassportElementPhoneNumber.fromMap(map),
    'passportElementEmailAddress': (map) => PassportElementEmailAddress.fromMap(map),
    'inputPassportElementPersonalDetails': (map) => InputPassportElementPersonalDetails.fromMap(map),
    'inputPassportElementPassport': (map) => InputPassportElementPassport.fromMap(map),
    'inputPassportElementDriverLicense': (map) => InputPassportElementDriverLicense.fromMap(map),
    'inputPassportElementIdentityCard': (map) => InputPassportElementIdentityCard.fromMap(map),
    'inputPassportElementInternalPassport': (map) => InputPassportElementInternalPassport.fromMap(map),
    'inputPassportElementAddress': (map) => InputPassportElementAddress.fromMap(map),
    'inputPassportElementUtilityBill': (map) => InputPassportElementUtilityBill.fromMap(map),
    'inputPassportElementBankStatement': (map) => InputPassportElementBankStatement.fromMap(map),
    'inputPassportElementRentalAgreement': (map) => InputPassportElementRentalAgreement.fromMap(map),
    'inputPassportElementPassportRegistration': (map) => InputPassportElementPassportRegistration.fromMap(map),
    'inputPassportElementTemporaryRegistration': (map) => InputPassportElementTemporaryRegistration.fromMap(map),
    'inputPassportElementPhoneNumber': (map) => InputPassportElementPhoneNumber.fromMap(map),
    'inputPassportElementEmailAddress': (map) => InputPassportElementEmailAddress.fromMap(map),
    'passportElements': (map) => PassportElements.fromMap(map),
    'passportElementErrorSourceUnspecified': (map) => PassportElementErrorSourceUnspecified.fromMap(map),
    'passportElementErrorSourceDataField': (map) => PassportElementErrorSourceDataField.fromMap(map),
    'passportElementErrorSourceFrontSide': (map) => PassportElementErrorSourceFrontSide.fromMap(map),
    'passportElementErrorSourceReverseSide': (map) => PassportElementErrorSourceReverseSide.fromMap(map),
    'passportElementErrorSourceSelfie': (map) => PassportElementErrorSourceSelfie.fromMap(map),
    'passportElementErrorSourceTranslationFile': (map) => PassportElementErrorSourceTranslationFile.fromMap(map),
    'passportElementErrorSourceTranslationFiles': (map) => PassportElementErrorSourceTranslationFiles.fromMap(map),
    'passportElementErrorSourceFile': (map) => PassportElementErrorSourceFile.fromMap(map),
    'passportElementErrorSourceFiles': (map) => PassportElementErrorSourceFiles.fromMap(map),
    'passportElementError': (map) => PassportElementError.fromMap(map),
    'passportSuitableElement': (map) => PassportSuitableElement.fromMap(map),
    'passportRequiredElement': (map) => PassportRequiredElement.fromMap(map),
    'passportAuthorizationForm': (map) => PassportAuthorizationForm.fromMap(map),
    'passportElementsWithErrors': (map) => PassportElementsWithErrors.fromMap(map),
    'encryptedCredentials': (map) => EncryptedCredentials.fromMap(map),
    'encryptedPassportElement': (map) => EncryptedPassportElement.fromMap(map),
    'inputPassportElementErrorSourceUnspecified': (map) => InputPassportElementErrorSourceUnspecified.fromMap(map),
    'inputPassportElementErrorSourceDataField': (map) => InputPassportElementErrorSourceDataField.fromMap(map),
    'inputPassportElementErrorSourceFrontSide': (map) => InputPassportElementErrorSourceFrontSide.fromMap(map),
    'inputPassportElementErrorSourceReverseSide': (map) => InputPassportElementErrorSourceReverseSide.fromMap(map),
    'inputPassportElementErrorSourceSelfie': (map) => InputPassportElementErrorSourceSelfie.fromMap(map),
    'inputPassportElementErrorSourceTranslationFile': (map) => InputPassportElementErrorSourceTranslationFile.fromMap(map),
    'inputPassportElementErrorSourceTranslationFiles': (map) => InputPassportElementErrorSourceTranslationFiles.fromMap(map),
    'inputPassportElementErrorSourceFile': (map) => InputPassportElementErrorSourceFile.fromMap(map),
    'inputPassportElementErrorSourceFiles': (map) => InputPassportElementErrorSourceFiles.fromMap(map),
    'inputPassportElementError': (map) => InputPassportElementError.fromMap(map),
    'messageText': (map) => MessageText.fromMap(map),
    'messageAnimation': (map) => MessageAnimation.fromMap(map),
    'messageAudio': (map) => MessageAudio.fromMap(map),
    'messageDocument': (map) => MessageDocument.fromMap(map),
    'messagePhoto': (map) => MessagePhoto.fromMap(map),
    'messageExpiredPhoto': (map) => MessageExpiredPhoto.fromMap(map),
    'messageSticker': (map) => MessageSticker.fromMap(map),
    'messageVideo': (map) => MessageVideo.fromMap(map),
    'messageExpiredVideo': (map) => MessageExpiredVideo.fromMap(map),
    'messageVideoNote': (map) => MessageVideoNote.fromMap(map),
    'messageVoiceNote': (map) => MessageVoiceNote.fromMap(map),
    'messageLocation': (map) => MessageLocation.fromMap(map),
    'messageVenue': (map) => MessageVenue.fromMap(map),
    'messageContact': (map) => MessageContact.fromMap(map),
    'messageAnimatedEmoji': (map) => MessageAnimatedEmoji.fromMap(map),
    'messageDice': (map) => MessageDice.fromMap(map),
    'messageGame': (map) => MessageGame.fromMap(map),
    'messagePoll': (map) => MessagePoll.fromMap(map),
    'messageInvoice': (map) => MessageInvoice.fromMap(map),
    'messageCall': (map) => MessageCall.fromMap(map),
    'messageVideoChatScheduled': (map) => MessageVideoChatScheduled.fromMap(map),
    'messageVideoChatStarted': (map) => MessageVideoChatStarted.fromMap(map),
    'messageVideoChatEnded': (map) => MessageVideoChatEnded.fromMap(map),
    'messageInviteVideoChatParticipants': (map) => MessageInviteVideoChatParticipants.fromMap(map),
    'messageBasicGroupChatCreate': (map) => MessageBasicGroupChatCreate.fromMap(map),
    'messageSupergroupChatCreate': (map) => MessageSupergroupChatCreate.fromMap(map),
    'messageChatChangeTitle': (map) => MessageChatChangeTitle.fromMap(map),
    'messageChatChangePhoto': (map) => MessageChatChangePhoto.fromMap(map),
    'messageChatDeletePhoto': (map) => MessageChatDeletePhoto.fromMap(map),
    'messageChatAddMembers': (map) => MessageChatAddMembers.fromMap(map),
    'messageChatJoinByLink': (map) => MessageChatJoinByLink.fromMap(map),
    'messageChatJoinByRequest': (map) => MessageChatJoinByRequest.fromMap(map),
    'messageChatDeleteMember': (map) => MessageChatDeleteMember.fromMap(map),
    'messageChatUpgradeTo': (map) => MessageChatUpgradeTo.fromMap(map),
    'messageChatUpgradeFrom': (map) => MessageChatUpgradeFrom.fromMap(map),
    'messagePinMessage': (map) => MessagePinMessage.fromMap(map),
    'messageScreenshotTaken': (map) => MessageScreenshotTaken.fromMap(map),
    'messageChatSetTheme': (map) => MessageChatSetTheme.fromMap(map),
    'messageChatSetTtl': (map) => MessageChatSetTtl.fromMap(map),
    'messageCustomServiceAction': (map) => MessageCustomServiceAction.fromMap(map),
    'messageGameScore': (map) => MessageGameScore.fromMap(map),
    'messagePaymentSuccessful': (map) => MessagePaymentSuccessful.fromMap(map),
    'messagePaymentSuccessfulBot': (map) => MessagePaymentSuccessfulBot.fromMap(map),
    'messageContactRegistered': (map) => MessageContactRegistered.fromMap(map),
    'messageWebsiteConnected': (map) => MessageWebsiteConnected.fromMap(map),
    'messageWebAppDataSent': (map) => MessageWebAppDataSent.fromMap(map),
    'messageWebAppDataReceived': (map) => MessageWebAppDataReceived.fromMap(map),
    'messagePassportDataSent': (map) => MessagePassportDataSent.fromMap(map),
    'messagePassportDataReceived': (map) => MessagePassportDataReceived.fromMap(map),
    'messageProximityAlertTriggered': (map) => MessageProximityAlertTriggered.fromMap(map),
    'messageUnsupported': (map) => MessageUnsupported.fromMap(map),
    'textEntityTypeMention': (map) => TextEntityTypeMention.fromMap(map),
    'textEntityTypeHashtag': (map) => TextEntityTypeHashtag.fromMap(map),
    'textEntityTypeCashtag': (map) => TextEntityTypeCashtag.fromMap(map),
    'textEntityTypeBotCommand': (map) => TextEntityTypeBotCommand.fromMap(map),
    'textEntityTypeUrl': (map) => TextEntityTypeUrl.fromMap(map),
    'textEntityTypeEmailAddress': (map) => TextEntityTypeEmailAddress.fromMap(map),
    'textEntityTypePhoneNumber': (map) => TextEntityTypePhoneNumber.fromMap(map),
    'textEntityTypeBankCardNumber': (map) => TextEntityTypeBankCardNumber.fromMap(map),
    'textEntityTypeBold': (map) => TextEntityTypeBold.fromMap(map),
    'textEntityTypeItalic': (map) => TextEntityTypeItalic.fromMap(map),
    'textEntityTypeUnderline': (map) => TextEntityTypeUnderline.fromMap(map),
    'textEntityTypeStrikethrough': (map) => TextEntityTypeStrikethrough.fromMap(map),
    'textEntityTypeSpoiler': (map) => TextEntityTypeSpoiler.fromMap(map),
    'textEntityTypeCode': (map) => TextEntityTypeCode.fromMap(map),
    'textEntityTypePre': (map) => TextEntityTypePre.fromMap(map),
    'textEntityTypePreCode': (map) => TextEntityTypePreCode.fromMap(map),
    'textEntityTypeTextUrl': (map) => TextEntityTypeTextUrl.fromMap(map),
    'textEntityTypeMentionName': (map) => TextEntityTypeMentionName.fromMap(map),
    'textEntityTypeMediaTimestamp': (map) => TextEntityTypeMediaTimestamp.fromMap(map),
    'inputThumbnail': (map) => InputThumbnail.fromMap(map),
    'messageSchedulingStateSendAtDate': (map) => MessageSchedulingStateSendAtDate.fromMap(map),
    'messageSchedulingStateSendWhenOnline': (map) => MessageSchedulingStateSendWhenOnline.fromMap(map),
    'messageSendOptions': (map) => MessageSendOptions.fromMap(map),
    'messageCopyOptions': (map) => MessageCopyOptions.fromMap(map),
    'inputMessageText': (map) => InputMessageText.fromMap(map),
    'inputMessageAnimation': (map) => InputMessageAnimation.fromMap(map),
    'inputMessageAudio': (map) => InputMessageAudio.fromMap(map),
    'inputMessageDocument': (map) => InputMessageDocument.fromMap(map),
    'inputMessagePhoto': (map) => InputMessagePhoto.fromMap(map),
    'inputMessageSticker': (map) => InputMessageSticker.fromMap(map),
    'inputMessageVideo': (map) => InputMessageVideo.fromMap(map),
    'inputMessageVideoNote': (map) => InputMessageVideoNote.fromMap(map),
    'inputMessageVoiceNote': (map) => InputMessageVoiceNote.fromMap(map),
    'inputMessageLocation': (map) => InputMessageLocation.fromMap(map),
    'inputMessageVenue': (map) => InputMessageVenue.fromMap(map),
    'inputMessageContact': (map) => InputMessageContact.fromMap(map),
    'inputMessageDice': (map) => InputMessageDice.fromMap(map),
    'inputMessageGame': (map) => InputMessageGame.fromMap(map),
    'inputMessageInvoice': (map) => InputMessageInvoice.fromMap(map),
    'inputMessagePoll': (map) => InputMessagePoll.fromMap(map),
    'inputMessageForwarded': (map) => InputMessageForwarded.fromMap(map),
    'searchMessagesFilterEmpty': (map) => SearchMessagesFilterEmpty.fromMap(map),
    'searchMessagesFilterAnimation': (map) => SearchMessagesFilterAnimation.fromMap(map),
    'searchMessagesFilterAudio': (map) => SearchMessagesFilterAudio.fromMap(map),
    'searchMessagesFilterDocument': (map) => SearchMessagesFilterDocument.fromMap(map),
    'searchMessagesFilterPhoto': (map) => SearchMessagesFilterPhoto.fromMap(map),
    'searchMessagesFilterVideo': (map) => SearchMessagesFilterVideo.fromMap(map),
    'searchMessagesFilterVoiceNote': (map) => SearchMessagesFilterVoiceNote.fromMap(map),
    'searchMessagesFilterPhotoAndVideo': (map) => SearchMessagesFilterPhotoAndVideo.fromMap(map),
    'searchMessagesFilterUrl': (map) => SearchMessagesFilterUrl.fromMap(map),
    'searchMessagesFilterChatPhoto': (map) => SearchMessagesFilterChatPhoto.fromMap(map),
    'searchMessagesFilterVideoNote': (map) => SearchMessagesFilterVideoNote.fromMap(map),
    'searchMessagesFilterVoiceAndVideoNote': (map) => SearchMessagesFilterVoiceAndVideoNote.fromMap(map),
    'searchMessagesFilterMention': (map) => SearchMessagesFilterMention.fromMap(map),
    'searchMessagesFilterUnreadMention': (map) => SearchMessagesFilterUnreadMention.fromMap(map),
    'searchMessagesFilterUnreadReaction': (map) => SearchMessagesFilterUnreadReaction.fromMap(map),
    'searchMessagesFilterFailedToSend': (map) => SearchMessagesFilterFailedToSend.fromMap(map),
    'searchMessagesFilterPinned': (map) => SearchMessagesFilterPinned.fromMap(map),
    'chatActionTyping': (map) => ChatActionTyping.fromMap(map),
    'chatActionRecordingVideo': (map) => ChatActionRecordingVideo.fromMap(map),
    'chatActionUploadingVideo': (map) => ChatActionUploadingVideo.fromMap(map),
    'chatActionRecordingVoiceNote': (map) => ChatActionRecordingVoiceNote.fromMap(map),
    'chatActionUploadingVoiceNote': (map) => ChatActionUploadingVoiceNote.fromMap(map),
    'chatActionUploadingPhoto': (map) => ChatActionUploadingPhoto.fromMap(map),
    'chatActionUploadingDocument': (map) => ChatActionUploadingDocument.fromMap(map),
    'chatActionChoosingSticker': (map) => ChatActionChoosingSticker.fromMap(map),
    'chatActionChoosingLocation': (map) => ChatActionChoosingLocation.fromMap(map),
    'chatActionChoosingContact': (map) => ChatActionChoosingContact.fromMap(map),
    'chatActionStartPlayingGame': (map) => ChatActionStartPlayingGame.fromMap(map),
    'chatActionRecordingVideoNote': (map) => ChatActionRecordingVideoNote.fromMap(map),
    'chatActionUploadingVideoNote': (map) => ChatActionUploadingVideoNote.fromMap(map),
    'chatActionWatchingAnimations': (map) => ChatActionWatchingAnimations.fromMap(map),
    'chatActionCancel': (map) => ChatActionCancel.fromMap(map),
    'userStatusEmpty': (map) => UserStatusEmpty.fromMap(map),
    'userStatusOnline': (map) => UserStatusOnline.fromMap(map),
    'userStatusOffline': (map) => UserStatusOffline.fromMap(map),
    'userStatusRecently': (map) => UserStatusRecently.fromMap(map),
    'userStatusLastWeek': (map) => UserStatusLastWeek.fromMap(map),
    'userStatusLastMonth': (map) => UserStatusLastMonth.fromMap(map),
    'stickers': (map) => Stickers.fromMap(map),
    'emojis': (map) => Emojis.fromMap(map),
    'stickerSet': (map) => StickerSet.fromMap(map),
    'stickerSetInfo': (map) => StickerSetInfo.fromMap(map),
    'stickerSets': (map) => StickerSets.fromMap(map),
    'trendingStickerSets': (map) => TrendingStickerSets.fromMap(map),
    'callDiscardReasonEmpty': (map) => CallDiscardReasonEmpty.fromMap(map),
    'callDiscardReasonMissed': (map) => CallDiscardReasonMissed.fromMap(map),
    'callDiscardReasonDeclined': (map) => CallDiscardReasonDeclined.fromMap(map),
    'callDiscardReasonDisconnected': (map) => CallDiscardReasonDisconnected.fromMap(map),
    'callDiscardReasonHungUp': (map) => CallDiscardReasonHungUp.fromMap(map),
    'callProtocol': (map) => CallProtocol.fromMap(map),
    'callServerTypeTelegramReflector': (map) => CallServerTypeTelegramReflector.fromMap(map),
    'callServerTypeWebrtc': (map) => CallServerTypeWebrtc.fromMap(map),
    'callServer': (map) => CallServer.fromMap(map),
    'callId': (map) => CallId.fromMap(map),
    'groupCallId': (map) => GroupCallId.fromMap(map),
    'callStatePending': (map) => CallStatePending.fromMap(map),
    'callStateExchangingKeys': (map) => CallStateExchangingKeys.fromMap(map),
    'callStateReady': (map) => CallStateReady.fromMap(map),
    'callStateHangingUp': (map) => CallStateHangingUp.fromMap(map),
    'callStateDiscarded': (map) => CallStateDiscarded.fromMap(map),
    'callStateError': (map) => CallStateError.fromMap(map),
    'groupCallVideoQualityThumbnail': (map) => GroupCallVideoQualityThumbnail.fromMap(map),
    'groupCallVideoQualityMedium': (map) => GroupCallVideoQualityMedium.fromMap(map),
    'groupCallVideoQualityFull': (map) => GroupCallVideoQualityFull.fromMap(map),
    'groupCallStream': (map) => GroupCallStream.fromMap(map),
    'groupCallStreams': (map) => GroupCallStreams.fromMap(map),
    'rtmpUrl': (map) => RtmpUrl.fromMap(map),
    'groupCallRecentSpeaker': (map) => GroupCallRecentSpeaker.fromMap(map),
    'groupCall': (map) => GroupCall.fromMap(map),
    'groupCallVideoSourceGroup': (map) => GroupCallVideoSourceGroup.fromMap(map),
    'groupCallParticipantVideoInfo': (map) => GroupCallParticipantVideoInfo.fromMap(map),
    'groupCallParticipant': (map) => GroupCallParticipant.fromMap(map),
    'callProblemEcho': (map) => CallProblemEcho.fromMap(map),
    'callProblemNoise': (map) => CallProblemNoise.fromMap(map),
    'callProblemInterruptions': (map) => CallProblemInterruptions.fromMap(map),
    'callProblemDistortedSpeech': (map) => CallProblemDistortedSpeech.fromMap(map),
    'callProblemSilentLocal': (map) => CallProblemSilentLocal.fromMap(map),
    'callProblemSilentRemote': (map) => CallProblemSilentRemote.fromMap(map),
    'callProblemDropped': (map) => CallProblemDropped.fromMap(map),
    'callProblemDistortedVideo': (map) => CallProblemDistortedVideo.fromMap(map),
    'callProblemPixelatedVideo': (map) => CallProblemPixelatedVideo.fromMap(map),
    'call': (map) => Call.fromMap(map),
    'phoneNumberAuthenticationSettings': (map) => PhoneNumberAuthenticationSettings.fromMap(map),
    'addedReaction': (map) => AddedReaction.fromMap(map),
    'addedReactions': (map) => AddedReactions.fromMap(map),
    'availableReaction': (map) => AvailableReaction.fromMap(map),
    'availableReactions': (map) => AvailableReactions.fromMap(map),
    'reaction': (map) => Reaction.fromMap(map),
    'animations': (map) => Animations.fromMap(map),
    'diceStickersRegular': (map) => DiceStickersRegular.fromMap(map),
    'diceStickersSlotMachine': (map) => DiceStickersSlotMachine.fromMap(map),
    'importedContacts': (map) => ImportedContacts.fromMap(map),
    'attachmentMenuBotColor': (map) => AttachmentMenuBotColor.fromMap(map),
    'attachmentMenuBot': (map) => AttachmentMenuBot.fromMap(map),
    'sentWebAppMessage': (map) => SentWebAppMessage.fromMap(map),
    'httpUrl': (map) => HttpUrl.fromMap(map),
    'inputInlineQueryResultAnimation': (map) => InputInlineQueryResultAnimation.fromMap(map),
    'inputInlineQueryResultArticle': (map) => InputInlineQueryResultArticle.fromMap(map),
    'inputInlineQueryResultAudio': (map) => InputInlineQueryResultAudio.fromMap(map),
    'inputInlineQueryResultContact': (map) => InputInlineQueryResultContact.fromMap(map),
    'inputInlineQueryResultDocument': (map) => InputInlineQueryResultDocument.fromMap(map),
    'inputInlineQueryResultGame': (map) => InputInlineQueryResultGame.fromMap(map),
    'inputInlineQueryResultLocation': (map) => InputInlineQueryResultLocation.fromMap(map),
    'inputInlineQueryResultPhoto': (map) => InputInlineQueryResultPhoto.fromMap(map),
    'inputInlineQueryResultSticker': (map) => InputInlineQueryResultSticker.fromMap(map),
    'inputInlineQueryResultVenue': (map) => InputInlineQueryResultVenue.fromMap(map),
    'inputInlineQueryResultVideo': (map) => InputInlineQueryResultVideo.fromMap(map),
    'inputInlineQueryResultVoiceNote': (map) => InputInlineQueryResultVoiceNote.fromMap(map),
    'inlineQueryResultArticle': (map) => InlineQueryResultArticle.fromMap(map),
    'inlineQueryResultContact': (map) => InlineQueryResultContact.fromMap(map),
    'inlineQueryResultLocation': (map) => InlineQueryResultLocation.fromMap(map),
    'inlineQueryResultVenue': (map) => InlineQueryResultVenue.fromMap(map),
    'inlineQueryResultGame': (map) => InlineQueryResultGame.fromMap(map),
    'inlineQueryResultAnimation': (map) => InlineQueryResultAnimation.fromMap(map),
    'inlineQueryResultAudio': (map) => InlineQueryResultAudio.fromMap(map),
    'inlineQueryResultDocument': (map) => InlineQueryResultDocument.fromMap(map),
    'inlineQueryResultPhoto': (map) => InlineQueryResultPhoto.fromMap(map),
    'inlineQueryResultSticker': (map) => InlineQueryResultSticker.fromMap(map),
    'inlineQueryResultVideo': (map) => InlineQueryResultVideo.fromMap(map),
    'inlineQueryResultVoiceNote': (map) => InlineQueryResultVoiceNote.fromMap(map),
    'inlineQueryResults': (map) => InlineQueryResults.fromMap(map),
    'callbackQueryPayloadData': (map) => CallbackQueryPayloadData.fromMap(map),
    'callbackQueryPayloadDataWithPassword': (map) => CallbackQueryPayloadDataWithPassword.fromMap(map),
    'callbackQueryPayloadGame': (map) => CallbackQueryPayloadGame.fromMap(map),
    'callbackQueryAnswer': (map) => CallbackQueryAnswer.fromMap(map),
    'customRequestResult': (map) => CustomRequestResult.fromMap(map),
    'gameHighScore': (map) => GameHighScore.fromMap(map),
    'gameHighScores': (map) => GameHighScores.fromMap(map),
    'chatEventMessageEdited': (map) => ChatEventMessageEdited.fromMap(map),
    'chatEventMessageDeleted': (map) => ChatEventMessageDeleted.fromMap(map),
    'chatEventMessagePinned': (map) => ChatEventMessagePinned.fromMap(map),
    'chatEventMessageUnpinned': (map) => ChatEventMessageUnpinned.fromMap(map),
    'chatEventPollStopped': (map) => ChatEventPollStopped.fromMap(map),
    'chatEventMemberJoined': (map) => ChatEventMemberJoined.fromMap(map),
    'chatEventMemberJoinedByInviteLink': (map) => ChatEventMemberJoinedByInviteLink.fromMap(map),
    'chatEventMemberJoinedByRequest': (map) => ChatEventMemberJoinedByRequest.fromMap(map),
    'chatEventMemberInvited': (map) => ChatEventMemberInvited.fromMap(map),
    'chatEventMemberLeft': (map) => ChatEventMemberLeft.fromMap(map),
    'chatEventMemberPromoted': (map) => ChatEventMemberPromoted.fromMap(map),
    'chatEventMemberRestricted': (map) => ChatEventMemberRestricted.fromMap(map),
    'chatEventAvailableReactionsChanged': (map) => ChatEventAvailableReactionsChanged.fromMap(map),
    'chatEventDescriptionChanged': (map) => ChatEventDescriptionChanged.fromMap(map),
    'chatEventLinkedChatChanged': (map) => ChatEventLinkedChatChanged.fromMap(map),
    'chatEventLocationChanged': (map) => ChatEventLocationChanged.fromMap(map),
    'chatEventMessageTtlChanged': (map) => ChatEventMessageTtlChanged.fromMap(map),
    'chatEventPermissionsChanged': (map) => ChatEventPermissionsChanged.fromMap(map),
    'chatEventPhotoChanged': (map) => ChatEventPhotoChanged.fromMap(map),
    'chatEventSlowModeDelayChanged': (map) => ChatEventSlowModeDelayChanged.fromMap(map),
    'chatEventStickerSetChanged': (map) => ChatEventStickerSetChanged.fromMap(map),
    'chatEventTitleChanged': (map) => ChatEventTitleChanged.fromMap(map),
    'chatEventUsernameChanged': (map) => ChatEventUsernameChanged.fromMap(map),
    'chatEventHasProtectedContentToggled': (map) => ChatEventHasProtectedContentToggled.fromMap(map),
    'chatEventInvitesToggled': (map) => ChatEventInvitesToggled.fromMap(map),
    'chatEventIsAllHistoryAvailableToggled': (map) => ChatEventIsAllHistoryAvailableToggled.fromMap(map),
    'chatEventSignMessagesToggled': (map) => ChatEventSignMessagesToggled.fromMap(map),
    'chatEventInviteLinkEdited': (map) => ChatEventInviteLinkEdited.fromMap(map),
    'chatEventInviteLinkRevoked': (map) => ChatEventInviteLinkRevoked.fromMap(map),
    'chatEventInviteLinkDeleted': (map) => ChatEventInviteLinkDeleted.fromMap(map),
    'chatEventVideoChatCreated': (map) => ChatEventVideoChatCreated.fromMap(map),
    'chatEventVideoChatEnded': (map) => ChatEventVideoChatEnded.fromMap(map),
    'chatEventVideoChatMuteNewParticipantsToggled': (map) => ChatEventVideoChatMuteNewParticipantsToggled.fromMap(map),
    'chatEventVideoChatParticipantIsMutedToggled': (map) => ChatEventVideoChatParticipantIsMutedToggled.fromMap(map),
    'chatEventVideoChatParticipantVolumeLevelChanged': (map) => ChatEventVideoChatParticipantVolumeLevelChanged.fromMap(map),
    'chatEvent': (map) => ChatEvent.fromMap(map),
    'chatEvents': (map) => ChatEvents.fromMap(map),
    'chatEventLogFilters': (map) => ChatEventLogFilters.fromMap(map),
    'languagePackStringValueOrdinary': (map) => LanguagePackStringValueOrdinary.fromMap(map),
    'languagePackStringValuePluralized': (map) => LanguagePackStringValuePluralized.fromMap(map),
    'languagePackStringValueDeleted': (map) => LanguagePackStringValueDeleted.fromMap(map),
    'languagePackString': (map) => LanguagePackString.fromMap(map),
    'languagePackStrings': (map) => LanguagePackStrings.fromMap(map),
    'languagePackInfo': (map) => LanguagePackInfo.fromMap(map),
    'localizationTargetInfo': (map) => LocalizationTargetInfo.fromMap(map),
    'premiumLimitTypeSupergroupCount': (map) => PremiumLimitTypeSupergroupCount.fromMap(map),
    'premiumLimitTypePinnedChatCount': (map) => PremiumLimitTypePinnedChatCount.fromMap(map),
    'premiumLimitTypeCreatedPublicChatCount': (map) => PremiumLimitTypeCreatedPublicChatCount.fromMap(map),
    'premiumLimitTypeSavedAnimationCount': (map) => PremiumLimitTypeSavedAnimationCount.fromMap(map),
    'premiumLimitTypeFavoriteStickerCount': (map) => PremiumLimitTypeFavoriteStickerCount.fromMap(map),
    'premiumLimitTypeChatFilterCount': (map) => PremiumLimitTypeChatFilterCount.fromMap(map),
    'premiumLimitTypeChatFilterChosenChatCount': (map) => PremiumLimitTypeChatFilterChosenChatCount.fromMap(map),
    'premiumLimitTypePinnedArchivedChatCount': (map) => PremiumLimitTypePinnedArchivedChatCount.fromMap(map),
    'premiumLimitTypeCaptionLength': (map) => PremiumLimitTypeCaptionLength.fromMap(map),
    'premiumLimitTypeBioLength': (map) => PremiumLimitTypeBioLength.fromMap(map),
    'premiumFeatureIncreasedLimits': (map) => PremiumFeatureIncreasedLimits.fromMap(map),
    'premiumFeatureIncreasedUploadFileSize': (map) => PremiumFeatureIncreasedUploadFileSize.fromMap(map),
    'premiumFeatureImprovedDownloadSpeed': (map) => PremiumFeatureImprovedDownloadSpeed.fromMap(map),
    'premiumFeatureVoiceRecognition': (map) => PremiumFeatureVoiceRecognition.fromMap(map),
    'premiumFeatureDisabledAds': (map) => PremiumFeatureDisabledAds.fromMap(map),
    'premiumFeatureUniqueReactions': (map) => PremiumFeatureUniqueReactions.fromMap(map),
    'premiumFeatureUniqueStickers': (map) => PremiumFeatureUniqueStickers.fromMap(map),
    'premiumFeatureAdvancedChatManagement': (map) => PremiumFeatureAdvancedChatManagement.fromMap(map),
    'premiumFeatureProfileBadge': (map) => PremiumFeatureProfileBadge.fromMap(map),
    'premiumFeatureAnimatedProfilePhoto': (map) => PremiumFeatureAnimatedProfilePhoto.fromMap(map),
    'premiumFeatureAppIcons': (map) => PremiumFeatureAppIcons.fromMap(map),
    'premiumLimit': (map) => PremiumLimit.fromMap(map),
    'premiumFeatures': (map) => PremiumFeatures.fromMap(map),
    'premiumSourceLimitExceeded': (map) => PremiumSourceLimitExceeded.fromMap(map),
    'premiumSourceFeature': (map) => PremiumSourceFeature.fromMap(map),
    'premiumSourceLink': (map) => PremiumSourceLink.fromMap(map),
    'premiumSourceSettings': (map) => PremiumSourceSettings.fromMap(map),
    'premiumFeaturePromotionAnimation': (map) => PremiumFeaturePromotionAnimation.fromMap(map),
    'premiumState': (map) => PremiumState.fromMap(map),
    'deviceTokenFirebaseCloudMessaging': (map) => DeviceTokenFirebaseCloudMessaging.fromMap(map),
    'deviceTokenApplePush': (map) => DeviceTokenApplePush.fromMap(map),
    'deviceTokenApplePushVoIP': (map) => DeviceTokenApplePushVoIP.fromMap(map),
    'deviceTokenWindowsPush': (map) => DeviceTokenWindowsPush.fromMap(map),
    'deviceTokenMicrosoftPush': (map) => DeviceTokenMicrosoftPush.fromMap(map),
    'deviceTokenMicrosoftPushVoIP': (map) => DeviceTokenMicrosoftPushVoIP.fromMap(map),
    'deviceTokenWebPush': (map) => DeviceTokenWebPush.fromMap(map),
    'deviceTokenSimplePush': (map) => DeviceTokenSimplePush.fromMap(map),
    'deviceTokenUbuntuPush': (map) => DeviceTokenUbuntuPush.fromMap(map),
    'deviceTokenBlackBerryPush': (map) => DeviceTokenBlackBerryPush.fromMap(map),
    'deviceTokenTizenPush': (map) => DeviceTokenTizenPush.fromMap(map),
    'pushReceiverId': (map) => PushReceiverId.fromMap(map),
    'backgroundFillSolid': (map) => BackgroundFillSolid.fromMap(map),
    'backgroundFillGradient': (map) => BackgroundFillGradient.fromMap(map),
    'backgroundFillFreeformGradient': (map) => BackgroundFillFreeformGradient.fromMap(map),
    'backgroundTypeWallpaper': (map) => BackgroundTypeWallpaper.fromMap(map),
    'backgroundTypePattern': (map) => BackgroundTypePattern.fromMap(map),
    'backgroundTypeFill': (map) => BackgroundTypeFill.fromMap(map),
    'background': (map) => Background.fromMap(map),
    'backgrounds': (map) => Backgrounds.fromMap(map),
    'inputBackgroundLocal': (map) => InputBackgroundLocal.fromMap(map),
    'inputBackgroundRemote': (map) => InputBackgroundRemote.fromMap(map),
    'themeSettings': (map) => ThemeSettings.fromMap(map),
    'chatTheme': (map) => ChatTheme.fromMap(map),
    'hashtags': (map) => Hashtags.fromMap(map),
    'canTransferOwnershipResultOk': (map) => CanTransferOwnershipResultOk.fromMap(map),
    'canTransferOwnershipResultPasswordNeeded': (map) => CanTransferOwnershipResultPasswordNeeded.fromMap(map),
    'canTransferOwnershipResultPasswordTooFresh': (map) => CanTransferOwnershipResultPasswordTooFresh.fromMap(map),
    'canTransferOwnershipResultSessionTooFresh': (map) => CanTransferOwnershipResultSessionTooFresh.fromMap(map),
    'checkChatUsernameResultOk': (map) => CheckChatUsernameResultOk.fromMap(map),
    'checkChatUsernameResultUsernameInvalid': (map) => CheckChatUsernameResultUsernameInvalid.fromMap(map),
    'checkChatUsernameResultUsernameOccupied': (map) => CheckChatUsernameResultUsernameOccupied.fromMap(map),
    'checkChatUsernameResultPublicChatsTooMuch': (map) => CheckChatUsernameResultPublicChatsTooMuch.fromMap(map),
    'checkChatUsernameResultPublicGroupsUnavailable': (map) => CheckChatUsernameResultPublicGroupsUnavailable.fromMap(map),
    'checkStickerSetNameResultOk': (map) => CheckStickerSetNameResultOk.fromMap(map),
    'checkStickerSetNameResultNameInvalid': (map) => CheckStickerSetNameResultNameInvalid.fromMap(map),
    'checkStickerSetNameResultNameOccupied': (map) => CheckStickerSetNameResultNameOccupied.fromMap(map),
    'resetPasswordResultOk': (map) => ResetPasswordResultOk.fromMap(map),
    'resetPasswordResultPending': (map) => ResetPasswordResultPending.fromMap(map),
    'resetPasswordResultDeclined': (map) => ResetPasswordResultDeclined.fromMap(map),
    'messageFileTypePrivate': (map) => MessageFileTypePrivate.fromMap(map),
    'messageFileTypeGroup': (map) => MessageFileTypeGroup.fromMap(map),
    'messageFileTypeUnknown': (map) => MessageFileTypeUnknown.fromMap(map),
    'pushMessageContentHidden': (map) => PushMessageContentHidden.fromMap(map),
    'pushMessageContentAnimation': (map) => PushMessageContentAnimation.fromMap(map),
    'pushMessageContentAudio': (map) => PushMessageContentAudio.fromMap(map),
    'pushMessageContentContact': (map) => PushMessageContentContact.fromMap(map),
    'pushMessageContentContactRegistered': (map) => PushMessageContentContactRegistered.fromMap(map),
    'pushMessageContentDocument': (map) => PushMessageContentDocument.fromMap(map),
    'pushMessageContentGame': (map) => PushMessageContentGame.fromMap(map),
    'pushMessageContentGameScore': (map) => PushMessageContentGameScore.fromMap(map),
    'pushMessageContentInvoice': (map) => PushMessageContentInvoice.fromMap(map),
    'pushMessageContentLocation': (map) => PushMessageContentLocation.fromMap(map),
    'pushMessageContentPhoto': (map) => PushMessageContentPhoto.fromMap(map),
    'pushMessageContentPoll': (map) => PushMessageContentPoll.fromMap(map),
    'pushMessageContentScreenshotTaken': (map) => PushMessageContentScreenshotTaken.fromMap(map),
    'pushMessageContentSticker': (map) => PushMessageContentSticker.fromMap(map),
    'pushMessageContentText': (map) => PushMessageContentText.fromMap(map),
    'pushMessageContentVideo': (map) => PushMessageContentVideo.fromMap(map),
    'pushMessageContentVideoNote': (map) => PushMessageContentVideoNote.fromMap(map),
    'pushMessageContentVoiceNote': (map) => PushMessageContentVoiceNote.fromMap(map),
    'pushMessageContentBasicGroupChatCreate': (map) => PushMessageContentBasicGroupChatCreate.fromMap(map),
    'pushMessageContentChatAddMembers': (map) => PushMessageContentChatAddMembers.fromMap(map),
    'pushMessageContentChatChangePhoto': (map) => PushMessageContentChatChangePhoto.fromMap(map),
    'pushMessageContentChatChangeTitle': (map) => PushMessageContentChatChangeTitle.fromMap(map),
    'pushMessageContentChatSetTheme': (map) => PushMessageContentChatSetTheme.fromMap(map),
    'pushMessageContentChatDeleteMember': (map) => PushMessageContentChatDeleteMember.fromMap(map),
    'pushMessageContentChatJoinByLink': (map) => PushMessageContentChatJoinByLink.fromMap(map),
    'pushMessageContentChatJoinByRequest': (map) => PushMessageContentChatJoinByRequest.fromMap(map),
    'pushMessageContentRecurringPayment': (map) => PushMessageContentRecurringPayment.fromMap(map),
    'pushMessageContentMessageForwards': (map) => PushMessageContentMessageForwards.fromMap(map),
    'pushMessageContentMediaAlbum': (map) => PushMessageContentMediaAlbum.fromMap(map),
    'notificationTypeNewMessage': (map) => NotificationTypeNewMessage.fromMap(map),
    'notificationTypeNewSecretChat': (map) => NotificationTypeNewSecretChat.fromMap(map),
    'notificationTypeNewCall': (map) => NotificationTypeNewCall.fromMap(map),
    'notificationTypeNewPushMessage': (map) => NotificationTypeNewPushMessage.fromMap(map),
    'notificationGroupTypeMessages': (map) => NotificationGroupTypeMessages.fromMap(map),
    'notificationGroupTypeMentions': (map) => NotificationGroupTypeMentions.fromMap(map),
    'notificationGroupTypeSecretChat': (map) => NotificationGroupTypeSecretChat.fromMap(map),
    'notificationGroupTypeCalls': (map) => NotificationGroupTypeCalls.fromMap(map),
    'notificationSound': (map) => NotificationSound.fromMap(map),
    'notificationSounds': (map) => NotificationSounds.fromMap(map),
    'notification': (map) => Notification.fromMap(map),
    'notificationGroup': (map) => NotificationGroup.fromMap(map),
    'optionValueBoolean': (map) => OptionValueBoolean.fromMap(map),
    'optionValueEmpty': (map) => OptionValueEmpty.fromMap(map),
    'optionValueInteger': (map) => OptionValueInteger.fromMap(map),
    'optionValueString': (map) => OptionValueString.fromMap(map),
    'jsonObjectMember': (map) => JsonObjectMember.fromMap(map),
    'jsonValueNull': (map) => JsonValueNull.fromMap(map),
    'jsonValueBoolean': (map) => JsonValueBoolean.fromMap(map),
    'jsonValueNumber': (map) => JsonValueNumber.fromMap(map),
    'jsonValueString': (map) => JsonValueString.fromMap(map),
    'jsonValueArray': (map) => JsonValueArray.fromMap(map),
    'jsonValueObject': (map) => JsonValueObject.fromMap(map),
    'userPrivacySettingRuleAllowAll': (map) => UserPrivacySettingRuleAllowAll.fromMap(map),
    'userPrivacySettingRuleAllowContacts': (map) => UserPrivacySettingRuleAllowContacts.fromMap(map),
    'userPrivacySettingRuleAllowUsers': (map) => UserPrivacySettingRuleAllowUsers.fromMap(map),
    'userPrivacySettingRuleAllowChatMembers': (map) => UserPrivacySettingRuleAllowChatMembers.fromMap(map),
    'userPrivacySettingRuleRestrictAll': (map) => UserPrivacySettingRuleRestrictAll.fromMap(map),
    'userPrivacySettingRuleRestrictContacts': (map) => UserPrivacySettingRuleRestrictContacts.fromMap(map),
    'userPrivacySettingRuleRestrictUsers': (map) => UserPrivacySettingRuleRestrictUsers.fromMap(map),
    'userPrivacySettingRuleRestrictChatMembers': (map) => UserPrivacySettingRuleRestrictChatMembers.fromMap(map),
    'userPrivacySettingRules': (map) => UserPrivacySettingRules.fromMap(map),
    'userPrivacySettingShowStatus': (map) => UserPrivacySettingShowStatus.fromMap(map),
    'userPrivacySettingShowProfilePhoto': (map) => UserPrivacySettingShowProfilePhoto.fromMap(map),
    'userPrivacySettingShowLinkInForwardedMessages': (map) => UserPrivacySettingShowLinkInForwardedMessages.fromMap(map),
    'userPrivacySettingShowPhoneNumber': (map) => UserPrivacySettingShowPhoneNumber.fromMap(map),
    'userPrivacySettingAllowChatInvites': (map) => UserPrivacySettingAllowChatInvites.fromMap(map),
    'userPrivacySettingAllowCalls': (map) => UserPrivacySettingAllowCalls.fromMap(map),
    'userPrivacySettingAllowPeerToPeerCalls': (map) => UserPrivacySettingAllowPeerToPeerCalls.fromMap(map),
    'userPrivacySettingAllowFindingByPhoneNumber': (map) => UserPrivacySettingAllowFindingByPhoneNumber.fromMap(map),
    'accountTtl': (map) => AccountTtl.fromMap(map),
    'sessionTypeAndroid': (map) => SessionTypeAndroid.fromMap(map),
    'sessionTypeApple': (map) => SessionTypeApple.fromMap(map),
    'sessionTypeBrave': (map) => SessionTypeBrave.fromMap(map),
    'sessionTypeChrome': (map) => SessionTypeChrome.fromMap(map),
    'sessionTypeEdge': (map) => SessionTypeEdge.fromMap(map),
    'sessionTypeFirefox': (map) => SessionTypeFirefox.fromMap(map),
    'sessionTypeIpad': (map) => SessionTypeIpad.fromMap(map),
    'sessionTypeIphone': (map) => SessionTypeIphone.fromMap(map),
    'sessionTypeLinux': (map) => SessionTypeLinux.fromMap(map),
    'sessionTypeMac': (map) => SessionTypeMac.fromMap(map),
    'sessionTypeOpera': (map) => SessionTypeOpera.fromMap(map),
    'sessionTypeSafari': (map) => SessionTypeSafari.fromMap(map),
    'sessionTypeUbuntu': (map) => SessionTypeUbuntu.fromMap(map),
    'sessionTypeUnknown': (map) => SessionTypeUnknown.fromMap(map),
    'sessionTypeVivaldi': (map) => SessionTypeVivaldi.fromMap(map),
    'sessionTypeWindows': (map) => SessionTypeWindows.fromMap(map),
    'sessionTypeXbox': (map) => SessionTypeXbox.fromMap(map),
    'session': (map) => Session.fromMap(map),
    'sessions': (map) => Sessions.fromMap(map),
    'connectedWebsite': (map) => ConnectedWebsite.fromMap(map),
    'connectedWebsites': (map) => ConnectedWebsites.fromMap(map),
    'chatReportReasonSpam': (map) => ChatReportReasonSpam.fromMap(map),
    'chatReportReasonViolence': (map) => ChatReportReasonViolence.fromMap(map),
    'chatReportReasonPornography': (map) => ChatReportReasonPornography.fromMap(map),
    'chatReportReasonChildAbuse': (map) => ChatReportReasonChildAbuse.fromMap(map),
    'chatReportReasonCopyright': (map) => ChatReportReasonCopyright.fromMap(map),
    'chatReportReasonUnrelatedLocation': (map) => ChatReportReasonUnrelatedLocation.fromMap(map),
    'chatReportReasonFake': (map) => ChatReportReasonFake.fromMap(map),
    'chatReportReasonIllegalDrugs': (map) => ChatReportReasonIllegalDrugs.fromMap(map),
    'chatReportReasonPersonalDetails': (map) => ChatReportReasonPersonalDetails.fromMap(map),
    'chatReportReasonCustom': (map) => ChatReportReasonCustom.fromMap(map),
    'targetChatCurrent': (map) => TargetChatCurrent.fromMap(map),
    'targetChatChosen': (map) => TargetChatChosen.fromMap(map),
    'targetChatInternalLink': (map) => TargetChatInternalLink.fromMap(map),
    'internalLinkTypeActiveSessions': (map) => InternalLinkTypeActiveSessions.fromMap(map),
    'internalLinkTypeAttachmentMenuBot': (map) => InternalLinkTypeAttachmentMenuBot.fromMap(map),
    'internalLinkTypeAuthenticationCode': (map) => InternalLinkTypeAuthenticationCode.fromMap(map),
    'internalLinkTypeBackground': (map) => InternalLinkTypeBackground.fromMap(map),
    'internalLinkTypeBotStart': (map) => InternalLinkTypeBotStart.fromMap(map),
    'internalLinkTypeBotStartInGroup': (map) => InternalLinkTypeBotStartInGroup.fromMap(map),
    'internalLinkTypeBotAddToChannel': (map) => InternalLinkTypeBotAddToChannel.fromMap(map),
    'internalLinkTypeChangePhoneNumber': (map) => InternalLinkTypeChangePhoneNumber.fromMap(map),
    'internalLinkTypeChatInvite': (map) => InternalLinkTypeChatInvite.fromMap(map),
    'internalLinkTypeFilterSettings': (map) => InternalLinkTypeFilterSettings.fromMap(map),
    'internalLinkTypeGame': (map) => InternalLinkTypeGame.fromMap(map),
    'internalLinkTypeInvoice': (map) => InternalLinkTypeInvoice.fromMap(map),
    'internalLinkTypeLanguagePack': (map) => InternalLinkTypeLanguagePack.fromMap(map),
    'internalLinkTypeLanguageSettings': (map) => InternalLinkTypeLanguageSettings.fromMap(map),
    'internalLinkTypeMessage': (map) => InternalLinkTypeMessage.fromMap(map),
    'internalLinkTypeMessageDraft': (map) => InternalLinkTypeMessageDraft.fromMap(map),
    'internalLinkTypePassportDataRequest': (map) => InternalLinkTypePassportDataRequest.fromMap(map),
    'internalLinkTypePhoneNumberConfirmation': (map) => InternalLinkTypePhoneNumberConfirmation.fromMap(map),
    'internalLinkTypePremiumFeatures': (map) => InternalLinkTypePremiumFeatures.fromMap(map),
    'internalLinkTypePrivacyAndSecuritySettings': (map) => InternalLinkTypePrivacyAndSecuritySettings.fromMap(map),
    'internalLinkTypeProxy': (map) => InternalLinkTypeProxy.fromMap(map),
    'internalLinkTypePublicChat': (map) => InternalLinkTypePublicChat.fromMap(map),
    'internalLinkTypeQrCodeAuthentication': (map) => InternalLinkTypeQrCodeAuthentication.fromMap(map),
    'internalLinkTypeSettings': (map) => InternalLinkTypeSettings.fromMap(map),
    'internalLinkTypeStickerSet': (map) => InternalLinkTypeStickerSet.fromMap(map),
    'internalLinkTypeTheme': (map) => InternalLinkTypeTheme.fromMap(map),
    'internalLinkTypeThemeSettings': (map) => InternalLinkTypeThemeSettings.fromMap(map),
    'internalLinkTypeUnknownDeepLink': (map) => InternalLinkTypeUnknownDeepLink.fromMap(map),
    'internalLinkTypeUnsupportedProxy': (map) => InternalLinkTypeUnsupportedProxy.fromMap(map),
    'internalLinkTypeUserPhoneNumber': (map) => InternalLinkTypeUserPhoneNumber.fromMap(map),
    'internalLinkTypeVideoChat': (map) => InternalLinkTypeVideoChat.fromMap(map),
    'messageLink': (map) => MessageLink.fromMap(map),
    'messageLinkInfo': (map) => MessageLinkInfo.fromMap(map),
    'filePart': (map) => FilePart.fromMap(map),
    'fileTypeNone': (map) => FileTypeNone.fromMap(map),
    'fileTypeAnimation': (map) => FileTypeAnimation.fromMap(map),
    'fileTypeAudio': (map) => FileTypeAudio.fromMap(map),
    'fileTypeDocument': (map) => FileTypeDocument.fromMap(map),
    'fileTypeNotificationSound': (map) => FileTypeNotificationSound.fromMap(map),
    'fileTypePhoto': (map) => FileTypePhoto.fromMap(map),
    'fileTypeProfilePhoto': (map) => FileTypeProfilePhoto.fromMap(map),
    'fileTypeSecret': (map) => FileTypeSecret.fromMap(map),
    'fileTypeSecretThumbnail': (map) => FileTypeSecretThumbnail.fromMap(map),
    'fileTypeSecure': (map) => FileTypeSecure.fromMap(map),
    'fileTypeSticker': (map) => FileTypeSticker.fromMap(map),
    'fileTypeThumbnail': (map) => FileTypeThumbnail.fromMap(map),
    'fileTypeUnknown': (map) => FileTypeUnknown.fromMap(map),
    'fileTypeVideo': (map) => FileTypeVideo.fromMap(map),
    'fileTypeVideoNote': (map) => FileTypeVideoNote.fromMap(map),
    'fileTypeVoiceNote': (map) => FileTypeVoiceNote.fromMap(map),
    'fileTypeWallpaper': (map) => FileTypeWallpaper.fromMap(map),
    'storageStatisticsByFileType': (map) => StorageStatisticsByFileType.fromMap(map),
    'storageStatisticsByChat': (map) => StorageStatisticsByChat.fromMap(map),
    'storageStatistics': (map) => StorageStatistics.fromMap(map),
    'storageStatisticsFast': (map) => StorageStatisticsFast.fromMap(map),
    'databaseStatistics': (map) => DatabaseStatistics.fromMap(map),
    'networkTypeNone': (map) => NetworkTypeNone.fromMap(map),
    'networkTypeMobile': (map) => NetworkTypeMobile.fromMap(map),
    'networkTypeMobileRoaming': (map) => NetworkTypeMobileRoaming.fromMap(map),
    'networkTypeWiFi': (map) => NetworkTypeWiFi.fromMap(map),
    'networkTypeOther': (map) => NetworkTypeOther.fromMap(map),
    'networkStatisticsEntryFile': (map) => NetworkStatisticsEntryFile.fromMap(map),
    'networkStatisticsEntryCall': (map) => NetworkStatisticsEntryCall.fromMap(map),
    'networkStatistics': (map) => NetworkStatistics.fromMap(map),
    'autoDownloadSettings': (map) => AutoDownloadSettings.fromMap(map),
    'autoDownloadSettingsPresets': (map) => AutoDownloadSettingsPresets.fromMap(map),
    'connectionStateWaitingForNetwork': (map) => ConnectionStateWaitingForNetwork.fromMap(map),
    'connectionStateConnectingToProxy': (map) => ConnectionStateConnectingToProxy.fromMap(map),
    'connectionStateConnecting': (map) => ConnectionStateConnecting.fromMap(map),
    'connectionStateUpdating': (map) => ConnectionStateUpdating.fromMap(map),
    'connectionStateReady': (map) => ConnectionStateReady.fromMap(map),
    'topChatCategoryUsers': (map) => TopChatCategoryUsers.fromMap(map),
    'topChatCategoryBots': (map) => TopChatCategoryBots.fromMap(map),
    'topChatCategoryGroups': (map) => TopChatCategoryGroups.fromMap(map),
    'topChatCategoryChannels': (map) => TopChatCategoryChannels.fromMap(map),
    'topChatCategoryInlineBots': (map) => TopChatCategoryInlineBots.fromMap(map),
    'topChatCategoryCalls': (map) => TopChatCategoryCalls.fromMap(map),
    'topChatCategoryForwardChats': (map) => TopChatCategoryForwardChats.fromMap(map),
    'tMeUrlTypeUser': (map) => TMeUrlTypeUser.fromMap(map),
    'tMeUrlTypeSupergroup': (map) => TMeUrlTypeSupergroup.fromMap(map),
    'tMeUrlTypeChatInvite': (map) => TMeUrlTypeChatInvite.fromMap(map),
    'tMeUrlTypeStickerSet': (map) => TMeUrlTypeStickerSet.fromMap(map),
    'tMeUrl': (map) => TMeUrl.fromMap(map),
    'tMeUrls': (map) => TMeUrls.fromMap(map),
    'suggestedActionEnableArchiveAndMuteNewChats': (map) => SuggestedActionEnableArchiveAndMuteNewChats.fromMap(map),
    'suggestedActionCheckPassword': (map) => SuggestedActionCheckPassword.fromMap(map),
    'suggestedActionCheckPhoneNumber': (map) => SuggestedActionCheckPhoneNumber.fromMap(map),
    'suggestedActionViewChecksHint': (map) => SuggestedActionViewChecksHint.fromMap(map),
    'suggestedActionConvertToBroadcastGroup': (map) => SuggestedActionConvertToBroadcastGroup.fromMap(map),
    'suggestedActionSetPassword': (map) => SuggestedActionSetPassword.fromMap(map),
    'count': (map) => Count.fromMap(map),
    'text': (map) => Text.fromMap(map),
    'seconds': (map) => Seconds.fromMap(map),
    'fileDownloadedPrefixSize': (map) => FileDownloadedPrefixSize.fromMap(map),
    'deepLinkInfo': (map) => DeepLinkInfo.fromMap(map),
    'textParseModeMarkdown': (map) => TextParseModeMarkdown.fromMap(map),
    'textParseModeHTML': (map) => TextParseModeHTML.fromMap(map),
    'proxyTypeSocks5': (map) => ProxyTypeSocks5.fromMap(map),
    'proxyTypeHttp': (map) => ProxyTypeHttp.fromMap(map),
    'proxyTypeMtproto': (map) => ProxyTypeMtproto.fromMap(map),
    'proxy': (map) => Proxy.fromMap(map),
    'proxies': (map) => Proxies.fromMap(map),
    'inputSticker': (map) => InputSticker.fromMap(map),
    'dateRange': (map) => DateRange.fromMap(map),
    'statisticalValue': (map) => StatisticalValue.fromMap(map),
    'statisticalGraphData': (map) => StatisticalGraphData.fromMap(map),
    'statisticalGraphAsync': (map) => StatisticalGraphAsync.fromMap(map),
    'statisticalGraphError': (map) => StatisticalGraphError.fromMap(map),
    'chatStatisticsMessageInteractionInfo': (map) => ChatStatisticsMessageInteractionInfo.fromMap(map),
    'chatStatisticsMessageSenderInfo': (map) => ChatStatisticsMessageSenderInfo.fromMap(map),
    'chatStatisticsAdministratorActionsInfo': (map) => ChatStatisticsAdministratorActionsInfo.fromMap(map),
    'chatStatisticsInviterInfo': (map) => ChatStatisticsInviterInfo.fromMap(map),
    'chatStatisticsSupergroup': (map) => ChatStatisticsSupergroup.fromMap(map),
    'chatStatisticsChannel': (map) => ChatStatisticsChannel.fromMap(map),
    'messageStatistics': (map) => MessageStatistics.fromMap(map),
    'point': (map) => Point.fromMap(map),
    'vectorPathCommandLine': (map) => VectorPathCommandLine.fromMap(map),
    'vectorPathCommandCubicBezierCurve': (map) => VectorPathCommandCubicBezierCurve.fromMap(map),
    'botCommandScopeDefault': (map) => BotCommandScopeDefault.fromMap(map),
    'botCommandScopeAllPrivateChats': (map) => BotCommandScopeAllPrivateChats.fromMap(map),
    'botCommandScopeAllGroupChats': (map) => BotCommandScopeAllGroupChats.fromMap(map),
    'botCommandScopeAllChatAdministrators': (map) => BotCommandScopeAllChatAdministrators.fromMap(map),
    'botCommandScopeChat': (map) => BotCommandScopeChat.fromMap(map),
    'botCommandScopeChatAdministrators': (map) => BotCommandScopeChatAdministrators.fromMap(map),
    'botCommandScopeChatMember': (map) => BotCommandScopeChatMember.fromMap(map),
    'updateAuthorizationState': (map) => UpdateAuthorizationState.fromMap(map),
    'updateNewMessage': (map) => UpdateNewMessage.fromMap(map),
    'updateMessageSendAcknowledged': (map) => UpdateMessageSendAcknowledged.fromMap(map),
    'updateMessageSendSucceeded': (map) => UpdateMessageSendSucceeded.fromMap(map),
    'updateMessageSendFailed': (map) => UpdateMessageSendFailed.fromMap(map),
    'updateMessageContent': (map) => UpdateMessageContent.fromMap(map),
    'updateMessageEdited': (map) => UpdateMessageEdited.fromMap(map),
    'updateMessageIsPinned': (map) => UpdateMessageIsPinned.fromMap(map),
    'updateMessageInteractionInfo': (map) => UpdateMessageInteractionInfo.fromMap(map),
    'updateMessageContentOpened': (map) => UpdateMessageContentOpened.fromMap(map),
    'updateMessageMentionRead': (map) => UpdateMessageMentionRead.fromMap(map),
    'updateMessageUnreadReactions': (map) => UpdateMessageUnreadReactions.fromMap(map),
    'updateMessageLiveLocationViewed': (map) => UpdateMessageLiveLocationViewed.fromMap(map),
    'updateNewChat': (map) => UpdateNewChat.fromMap(map),
    'updateChatTitle': (map) => UpdateChatTitle.fromMap(map),
    'updateChatPhoto': (map) => UpdateChatPhoto.fromMap(map),
    'updateChatPermissions': (map) => UpdateChatPermissions.fromMap(map),
    'updateChatLastMessage': (map) => UpdateChatLastMessage.fromMap(map),
    'updateChatPosition': (map) => UpdateChatPosition.fromMap(map),
    'updateChatReadInbox': (map) => UpdateChatReadInbox.fromMap(map),
    'updateChatReadOutbox': (map) => UpdateChatReadOutbox.fromMap(map),
    'updateChatActionBar': (map) => UpdateChatActionBar.fromMap(map),
    'updateChatAvailableReactions': (map) => UpdateChatAvailableReactions.fromMap(map),
    'updateChatDraftMessage': (map) => UpdateChatDraftMessage.fromMap(map),
    'updateChatMessageSender': (map) => UpdateChatMessageSender.fromMap(map),
    'updateChatMessageTtl': (map) => UpdateChatMessageTtl.fromMap(map),
    'updateChatNotificationSettings': (map) => UpdateChatNotificationSettings.fromMap(map),
    'updateChatPendingJoinRequests': (map) => UpdateChatPendingJoinRequests.fromMap(map),
    'updateChatReplyMarkup': (map) => UpdateChatReplyMarkup.fromMap(map),
    'updateChatTheme': (map) => UpdateChatTheme.fromMap(map),
    'updateChatUnreadMentionCount': (map) => UpdateChatUnreadMentionCount.fromMap(map),
    'updateChatUnreadReactionCount': (map) => UpdateChatUnreadReactionCount.fromMap(map),
    'updateChatVideoChat': (map) => UpdateChatVideoChat.fromMap(map),
    'updateChatDefaultDisableNotification': (map) => UpdateChatDefaultDisableNotification.fromMap(map),
    'updateChatHasProtectedContent': (map) => UpdateChatHasProtectedContent.fromMap(map),
    'updateChatHasScheduledMessages': (map) => UpdateChatHasScheduledMessages.fromMap(map),
    'updateChatIsBlocked': (map) => UpdateChatIsBlocked.fromMap(map),
    'updateChatIsMarkedAsUnread': (map) => UpdateChatIsMarkedAsUnread.fromMap(map),
    'updateChatFilters': (map) => UpdateChatFilters.fromMap(map),
    'updateChatOnlineMemberCount': (map) => UpdateChatOnlineMemberCount.fromMap(map),
    'updateScopeNotificationSettings': (map) => UpdateScopeNotificationSettings.fromMap(map),
    'updateNotification': (map) => UpdateNotification.fromMap(map),
    'updateNotificationGroup': (map) => UpdateNotificationGroup.fromMap(map),
    'updateActiveNotifications': (map) => UpdateActiveNotifications.fromMap(map),
    'updateHavePendingNotifications': (map) => UpdateHavePendingNotifications.fromMap(map),
    'updateDeleteMessages': (map) => UpdateDeleteMessages.fromMap(map),
    'updateChatAction': (map) => UpdateChatAction.fromMap(map),
    'updateUserStatus': (map) => UpdateUserStatus.fromMap(map),
    'updateUser': (map) => UpdateUser.fromMap(map),
    'updateBasicGroup': (map) => UpdateBasicGroup.fromMap(map),
    'updateSupergroup': (map) => UpdateSupergroup.fromMap(map),
    'updateSecretChat': (map) => UpdateSecretChat.fromMap(map),
    'updateUserFullInfo': (map) => UpdateUserFullInfo.fromMap(map),
    'updateBasicGroupFullInfo': (map) => UpdateBasicGroupFullInfo.fromMap(map),
    'updateSupergroupFullInfo': (map) => UpdateSupergroupFullInfo.fromMap(map),
    'updateServiceNotification': (map) => UpdateServiceNotification.fromMap(map),
    'updateFile': (map) => UpdateFile.fromMap(map),
    'updateFileGenerationStart': (map) => UpdateFileGenerationStart.fromMap(map),
    'updateFileGenerationStop': (map) => UpdateFileGenerationStop.fromMap(map),
    'updateFileDownloads': (map) => UpdateFileDownloads.fromMap(map),
    'updateFileAddedToDownloads': (map) => UpdateFileAddedToDownloads.fromMap(map),
    'updateFileDownload': (map) => UpdateFileDownload.fromMap(map),
    'updateFileRemovedFromDownloads': (map) => UpdateFileRemovedFromDownloads.fromMap(map),
    'updateCall': (map) => UpdateCall.fromMap(map),
    'updateGroupCall': (map) => UpdateGroupCall.fromMap(map),
    'updateGroupCallParticipant': (map) => UpdateGroupCallParticipant.fromMap(map),
    'updateNewCallSignalingData': (map) => UpdateNewCallSignalingData.fromMap(map),
    'updateUserPrivacySettingRules': (map) => UpdateUserPrivacySettingRules.fromMap(map),
    'updateUnreadMessageCount': (map) => UpdateUnreadMessageCount.fromMap(map),
    'updateUnreadChatCount': (map) => UpdateUnreadChatCount.fromMap(map),
    'updateOption': (map) => UpdateOption.fromMap(map),
    'updateStickerSet': (map) => UpdateStickerSet.fromMap(map),
    'updateInstalledStickerSets': (map) => UpdateInstalledStickerSets.fromMap(map),
    'updateTrendingStickerSets': (map) => UpdateTrendingStickerSets.fromMap(map),
    'updateRecentStickers': (map) => UpdateRecentStickers.fromMap(map),
    'updateFavoriteStickers': (map) => UpdateFavoriteStickers.fromMap(map),
    'updateSavedAnimations': (map) => UpdateSavedAnimations.fromMap(map),
    'updateSavedNotificationSounds': (map) => UpdateSavedNotificationSounds.fromMap(map),
    'updateSelectedBackground': (map) => UpdateSelectedBackground.fromMap(map),
    'updateChatThemes': (map) => UpdateChatThemes.fromMap(map),
    'updateLanguagePackStrings': (map) => UpdateLanguagePackStrings.fromMap(map),
    'updateConnectionState': (map) => UpdateConnectionState.fromMap(map),
    'updateTermsOfService': (map) => UpdateTermsOfService.fromMap(map),
    'updateUsersNearby': (map) => UpdateUsersNearby.fromMap(map),
    'updateAttachmentMenuBots': (map) => UpdateAttachmentMenuBots.fromMap(map),
    'updateWebAppMessageSent': (map) => UpdateWebAppMessageSent.fromMap(map),
    'updateReactions': (map) => UpdateReactions.fromMap(map),
    'updateDiceEmojis': (map) => UpdateDiceEmojis.fromMap(map),
    'updateAnimatedEmojiMessageClicked': (map) => UpdateAnimatedEmojiMessageClicked.fromMap(map),
    'updateAnimationSearchParameters': (map) => UpdateAnimationSearchParameters.fromMap(map),
    'updateSuggestedActions': (map) => UpdateSuggestedActions.fromMap(map),
    'updateNewInlineQuery': (map) => UpdateNewInlineQuery.fromMap(map),
    'updateNewChosenInlineResult': (map) => UpdateNewChosenInlineResult.fromMap(map),
    'updateNewCallbackQuery': (map) => UpdateNewCallbackQuery.fromMap(map),
    'updateNewInlineCallbackQuery': (map) => UpdateNewInlineCallbackQuery.fromMap(map),
    'updateNewShippingQuery': (map) => UpdateNewShippingQuery.fromMap(map),
    'updateNewPreCheckoutQuery': (map) => UpdateNewPreCheckoutQuery.fromMap(map),
    'updateNewCustomEvent': (map) => UpdateNewCustomEvent.fromMap(map),
    'updateNewCustomQuery': (map) => UpdateNewCustomQuery.fromMap(map),
    'updatePoll': (map) => UpdatePoll.fromMap(map),
    'updatePollAnswer': (map) => UpdatePollAnswer.fromMap(map),
    'updateChatMember': (map) => UpdateChatMember.fromMap(map),
    'updateNewChatJoinRequest': (map) => UpdateNewChatJoinRequest.fromMap(map),
    'updates': (map) => Updates.fromMap(map),
    'logStreamDefault': (map) => LogStreamDefault.fromMap(map),
    'logStreamFile': (map) => LogStreamFile.fromMap(map),
    'logStreamEmpty': (map) => LogStreamEmpty.fromMap(map),
    'logVerbosityLevel': (map) => LogVerbosityLevel.fromMap(map),
    'logTags': (map) => LogTags.fromMap(map),
    'testInt': (map) => TestInt.fromMap(map),
    'testString': (map) => TestString.fromMap(map),
    'testBytes': (map) => TestBytes.fromMap(map),
    'testVectorInt': (map) => TestVectorInt.fromMap(map),
    'testVectorIntObject': (map) => TestVectorIntObject.fromMap(map),
    'testVectorString': (map) => TestVectorString.fromMap(map),
    'testVectorStringObject': (map) => TestVectorStringObject.fromMap(map),
    'getAuthorizationState': (map) => GetAuthorizationState.fromMap(map),
    'setTdlibParameters': (map) => SetTdlibParameters.fromMap(map),
    'checkDatabaseEncryptionKey': (map) => CheckDatabaseEncryptionKey.fromMap(map),
    'setAuthenticationPhoneNumber': (map) => SetAuthenticationPhoneNumber.fromMap(map),
    'resendAuthenticationCode': (map) => ResendAuthenticationCode.fromMap(map),
    'checkAuthenticationCode': (map) => CheckAuthenticationCode.fromMap(map),
    'requestQrCodeAuthentication': (map) => RequestQrCodeAuthentication.fromMap(map),
    'registerUser': (map) => RegisterUser.fromMap(map),
    'checkAuthenticationPassword': (map) => CheckAuthenticationPassword.fromMap(map),
    'requestAuthenticationPasswordRecovery': (map) => RequestAuthenticationPasswordRecovery.fromMap(map),
    'checkAuthenticationPasswordRecoveryCode': (map) => CheckAuthenticationPasswordRecoveryCode.fromMap(map),
    'recoverAuthenticationPassword': (map) => RecoverAuthenticationPassword.fromMap(map),
    'checkAuthenticationBotToken': (map) => CheckAuthenticationBotToken.fromMap(map),
    'logOut': (map) => LogOut.fromMap(map),
    'close': (map) => Close.fromMap(map),
    'destroy': (map) => Destroy.fromMap(map),
    'confirmQrCodeAuthentication': (map) => ConfirmQrCodeAuthentication.fromMap(map),
    'getCurrentState': (map) => GetCurrentState.fromMap(map),
    'setDatabaseEncryptionKey': (map) => SetDatabaseEncryptionKey.fromMap(map),
    'getPasswordState': (map) => GetPasswordState.fromMap(map),
    'setPassword': (map) => SetPassword.fromMap(map),
    'getRecoveryEmailAddress': (map) => GetRecoveryEmailAddress.fromMap(map),
    'setRecoveryEmailAddress': (map) => SetRecoveryEmailAddress.fromMap(map),
    'checkRecoveryEmailAddressCode': (map) => CheckRecoveryEmailAddressCode.fromMap(map),
    'resendRecoveryEmailAddressCode': (map) => ResendRecoveryEmailAddressCode.fromMap(map),
    'requestPasswordRecovery': (map) => RequestPasswordRecovery.fromMap(map),
    'checkPasswordRecoveryCode': (map) => CheckPasswordRecoveryCode.fromMap(map),
    'recoverPassword': (map) => RecoverPassword.fromMap(map),
    'resetPassword': (map) => ResetPassword.fromMap(map),
    'cancelPasswordReset': (map) => CancelPasswordReset.fromMap(map),
    'createTemporaryPassword': (map) => CreateTemporaryPassword.fromMap(map),
    'getTemporaryPasswordState': (map) => GetTemporaryPasswordState.fromMap(map),
    'getMe': (map) => GetMe.fromMap(map),
    'getUser': (map) => GetUser.fromMap(map),
    'getUserFullInfo': (map) => GetUserFullInfo.fromMap(map),
    'getBasicGroup': (map) => GetBasicGroup.fromMap(map),
    'getBasicGroupFullInfo': (map) => GetBasicGroupFullInfo.fromMap(map),
    'getSupergroup': (map) => GetSupergroup.fromMap(map),
    'getSupergroupFullInfo': (map) => GetSupergroupFullInfo.fromMap(map),
    'getSecretChat': (map) => GetSecretChat.fromMap(map),
    'getChat': (map) => GetChat.fromMap(map),
    'getMessage': (map) => GetMessage.fromMap(map),
    'getMessageLocally': (map) => GetMessageLocally.fromMap(map),
    'getRepliedMessage': (map) => GetRepliedMessage.fromMap(map),
    'getChatPinnedMessage': (map) => GetChatPinnedMessage.fromMap(map),
    'getCallbackQueryMessage': (map) => GetCallbackQueryMessage.fromMap(map),
    'getMessages': (map) => GetMessages.fromMap(map),
    'getMessageThread': (map) => GetMessageThread.fromMap(map),
    'getMessageViewers': (map) => GetMessageViewers.fromMap(map),
    'getFile': (map) => GetFile.fromMap(map),
    'getRemoteFile': (map) => GetRemoteFile.fromMap(map),
    'loadChats': (map) => LoadChats.fromMap(map),
    'getChats': (map) => GetChats.fromMap(map),
    'searchPublicChat': (map) => SearchPublicChat.fromMap(map),
    'searchPublicChats': (map) => SearchPublicChats.fromMap(map),
    'searchChats': (map) => SearchChats.fromMap(map),
    'searchChatsOnServer': (map) => SearchChatsOnServer.fromMap(map),
    'searchChatsNearby': (map) => SearchChatsNearby.fromMap(map),
    'getTopChats': (map) => GetTopChats.fromMap(map),
    'removeTopChat': (map) => RemoveTopChat.fromMap(map),
    'addRecentlyFoundChat': (map) => AddRecentlyFoundChat.fromMap(map),
    'removeRecentlyFoundChat': (map) => RemoveRecentlyFoundChat.fromMap(map),
    'clearRecentlyFoundChats': (map) => ClearRecentlyFoundChats.fromMap(map),
    'getRecentlyOpenedChats': (map) => GetRecentlyOpenedChats.fromMap(map),
    'checkChatUsername': (map) => CheckChatUsername.fromMap(map),
    'getCreatedPublicChats': (map) => GetCreatedPublicChats.fromMap(map),
    'checkCreatedPublicChatsLimit': (map) => CheckCreatedPublicChatsLimit.fromMap(map),
    'getSuitableDiscussionChats': (map) => GetSuitableDiscussionChats.fromMap(map),
    'getInactiveSupergroupChats': (map) => GetInactiveSupergroupChats.fromMap(map),
    'getGroupsInCommon': (map) => GetGroupsInCommon.fromMap(map),
    'getChatHistory': (map) => GetChatHistory.fromMap(map),
    'getMessageThreadHistory': (map) => GetMessageThreadHistory.fromMap(map),
    'deleteChatHistory': (map) => DeleteChatHistory.fromMap(map),
    'deleteChat': (map) => DeleteChat.fromMap(map),
    'searchChatMessages': (map) => SearchChatMessages.fromMap(map),
    'searchMessages': (map) => SearchMessages.fromMap(map),
    'searchSecretMessages': (map) => SearchSecretMessages.fromMap(map),
    'searchCallMessages': (map) => SearchCallMessages.fromMap(map),
    'searchOutgoingDocumentMessages': (map) => SearchOutgoingDocumentMessages.fromMap(map),
    'deleteAllCallMessages': (map) => DeleteAllCallMessages.fromMap(map),
    'searchChatRecentLocationMessages': (map) => SearchChatRecentLocationMessages.fromMap(map),
    'getActiveLiveLocationMessages': (map) => GetActiveLiveLocationMessages.fromMap(map),
    'getChatMessageByDate': (map) => GetChatMessageByDate.fromMap(map),
    'getChatSparseMessagePositions': (map) => GetChatSparseMessagePositions.fromMap(map),
    'getChatMessageCalendar': (map) => GetChatMessageCalendar.fromMap(map),
    'getChatMessageCount': (map) => GetChatMessageCount.fromMap(map),
    'getChatScheduledMessages': (map) => GetChatScheduledMessages.fromMap(map),
    'getMessagePublicForwards': (map) => GetMessagePublicForwards.fromMap(map),
    'getChatSponsoredMessage': (map) => GetChatSponsoredMessage.fromMap(map),
    'removeNotification': (map) => RemoveNotification.fromMap(map),
    'removeNotificationGroup': (map) => RemoveNotificationGroup.fromMap(map),
    'getMessageLink': (map) => GetMessageLink.fromMap(map),
    'getMessageEmbeddingCode': (map) => GetMessageEmbeddingCode.fromMap(map),
    'getMessageLinkInfo': (map) => GetMessageLinkInfo.fromMap(map),
    'translateText': (map) => TranslateText.fromMap(map),
    'recognizeSpeech': (map) => RecognizeSpeech.fromMap(map),
    'rateSpeechRecognition': (map) => RateSpeechRecognition.fromMap(map),
    'getChatAvailableMessageSenders': (map) => GetChatAvailableMessageSenders.fromMap(map),
    'setChatMessageSender': (map) => SetChatMessageSender.fromMap(map),
    'sendMessage': (map) => SendMessage.fromMap(map),
    'sendMessageAlbum': (map) => SendMessageAlbum.fromMap(map),
    'sendBotStartMessage': (map) => SendBotStartMessage.fromMap(map),
    'sendInlineQueryResultMessage': (map) => SendInlineQueryResultMessage.fromMap(map),
    'forwardMessages': (map) => ForwardMessages.fromMap(map),
    'resendMessages': (map) => ResendMessages.fromMap(map),
    'sendChatScreenshotTakenNotification': (map) => SendChatScreenshotTakenNotification.fromMap(map),
    'addLocalMessage': (map) => AddLocalMessage.fromMap(map),
    'deleteMessages': (map) => DeleteMessages.fromMap(map),
    'deleteChatMessagesBySender': (map) => DeleteChatMessagesBySender.fromMap(map),
    'deleteChatMessagesByDate': (map) => DeleteChatMessagesByDate.fromMap(map),
    'editMessageText': (map) => EditMessageText.fromMap(map),
    'editMessageLiveLocation': (map) => EditMessageLiveLocation.fromMap(map),
    'editMessageMedia': (map) => EditMessageMedia.fromMap(map),
    'editMessageCaption': (map) => EditMessageCaption.fromMap(map),
    'editMessageReplyMarkup': (map) => EditMessageReplyMarkup.fromMap(map),
    'editInlineMessageText': (map) => EditInlineMessageText.fromMap(map),
    'editInlineMessageLiveLocation': (map) => EditInlineMessageLiveLocation.fromMap(map),
    'editInlineMessageMedia': (map) => EditInlineMessageMedia.fromMap(map),
    'editInlineMessageCaption': (map) => EditInlineMessageCaption.fromMap(map),
    'editInlineMessageReplyMarkup': (map) => EditInlineMessageReplyMarkup.fromMap(map),
    'editMessageSchedulingState': (map) => EditMessageSchedulingState.fromMap(map),
    'getMessageAvailableReactions': (map) => GetMessageAvailableReactions.fromMap(map),
    'setMessageReaction': (map) => SetMessageReaction.fromMap(map),
    'getMessageAddedReactions': (map) => GetMessageAddedReactions.fromMap(map),
    'getTextEntities': (map) => GetTextEntities.fromMap(map),
    'parseTextEntities': (map) => ParseTextEntities.fromMap(map),
    'parseMarkdown': (map) => ParseMarkdown.fromMap(map),
    'getMarkdownText': (map) => GetMarkdownText.fromMap(map),
    'getFileMimeType': (map) => GetFileMimeType.fromMap(map),
    'getFileExtension': (map) => GetFileExtension.fromMap(map),
    'cleanFileName': (map) => CleanFileName.fromMap(map),
    'getLanguagePackString': (map) => GetLanguagePackString.fromMap(map),
    'getJsonValue': (map) => GetJsonValue.fromMap(map),
    'getJsonString': (map) => GetJsonString.fromMap(map),
    'getThemeParametersJsonString': (map) => GetThemeParametersJsonString.fromMap(map),
    'setPollAnswer': (map) => SetPollAnswer.fromMap(map),
    'getPollVoters': (map) => GetPollVoters.fromMap(map),
    'stopPoll': (map) => StopPoll.fromMap(map),
    'hideSuggestedAction': (map) => HideSuggestedAction.fromMap(map),
    'getLoginUrlInfo': (map) => GetLoginUrlInfo.fromMap(map),
    'getLoginUrl': (map) => GetLoginUrl.fromMap(map),
    'getInlineQueryResults': (map) => GetInlineQueryResults.fromMap(map),
    'answerInlineQuery': (map) => AnswerInlineQuery.fromMap(map),
    'getWebAppUrl': (map) => GetWebAppUrl.fromMap(map),
    'sendWebAppData': (map) => SendWebAppData.fromMap(map),
    'openWebApp': (map) => OpenWebApp.fromMap(map),
    'closeWebApp': (map) => CloseWebApp.fromMap(map),
    'answerWebAppQuery': (map) => AnswerWebAppQuery.fromMap(map),
    'getCallbackQueryAnswer': (map) => GetCallbackQueryAnswer.fromMap(map),
    'answerCallbackQuery': (map) => AnswerCallbackQuery.fromMap(map),
    'answerShippingQuery': (map) => AnswerShippingQuery.fromMap(map),
    'answerPreCheckoutQuery': (map) => AnswerPreCheckoutQuery.fromMap(map),
    'setGameScore': (map) => SetGameScore.fromMap(map),
    'setInlineGameScore': (map) => SetInlineGameScore.fromMap(map),
    'getGameHighScores': (map) => GetGameHighScores.fromMap(map),
    'getInlineGameHighScores': (map) => GetInlineGameHighScores.fromMap(map),
    'deleteChatReplyMarkup': (map) => DeleteChatReplyMarkup.fromMap(map),
    'sendChatAction': (map) => SendChatAction.fromMap(map),
    'openChat': (map) => OpenChat.fromMap(map),
    'closeChat': (map) => CloseChat.fromMap(map),
    'viewMessages': (map) => ViewMessages.fromMap(map),
    'openMessageContent': (map) => OpenMessageContent.fromMap(map),
    'clickAnimatedEmojiMessage': (map) => ClickAnimatedEmojiMessage.fromMap(map),
    'getInternalLinkType': (map) => GetInternalLinkType.fromMap(map),
    'getExternalLinkInfo': (map) => GetExternalLinkInfo.fromMap(map),
    'getExternalLink': (map) => GetExternalLink.fromMap(map),
    'readAllChatMentions': (map) => ReadAllChatMentions.fromMap(map),
    'readAllChatReactions': (map) => ReadAllChatReactions.fromMap(map),
    'createPrivateChat': (map) => CreatePrivateChat.fromMap(map),
    'createBasicGroupChat': (map) => CreateBasicGroupChat.fromMap(map),
    'createSupergroupChat': (map) => CreateSupergroupChat.fromMap(map),
    'createSecretChat': (map) => CreateSecretChat.fromMap(map),
    'createNewBasicGroupChat': (map) => CreateNewBasicGroupChat.fromMap(map),
    'createNewSupergroupChat': (map) => CreateNewSupergroupChat.fromMap(map),
    'createNewSecretChat': (map) => CreateNewSecretChat.fromMap(map),
    'upgradeBasicGroupChatToSupergroupChat': (map) => UpgradeBasicGroupChatToSupergroupChat.fromMap(map),
    'getChatListsToAddChat': (map) => GetChatListsToAddChat.fromMap(map),
    'addChatToList': (map) => AddChatToList.fromMap(map),
    'getChatFilter': (map) => GetChatFilter.fromMap(map),
    'createChatFilter': (map) => CreateChatFilter.fromMap(map),
    'editChatFilter': (map) => EditChatFilter.fromMap(map),
    'deleteChatFilter': (map) => DeleteChatFilter.fromMap(map),
    'reorderChatFilters': (map) => ReorderChatFilters.fromMap(map),
    'getRecommendedChatFilters': (map) => GetRecommendedChatFilters.fromMap(map),
    'getChatFilterDefaultIconName': (map) => GetChatFilterDefaultIconName.fromMap(map),
    'setChatTitle': (map) => SetChatTitle.fromMap(map),
    'setChatPhoto': (map) => SetChatPhoto.fromMap(map),
    'setChatMessageTtl': (map) => SetChatMessageTtl.fromMap(map),
    'setChatPermissions': (map) => SetChatPermissions.fromMap(map),
    'setChatTheme': (map) => SetChatTheme.fromMap(map),
    'setChatDraftMessage': (map) => SetChatDraftMessage.fromMap(map),
    'setChatNotificationSettings': (map) => SetChatNotificationSettings.fromMap(map),
    'toggleChatHasProtectedContent': (map) => ToggleChatHasProtectedContent.fromMap(map),
    'toggleChatIsMarkedAsUnread': (map) => ToggleChatIsMarkedAsUnread.fromMap(map),
    'toggleChatDefaultDisableNotification': (map) => ToggleChatDefaultDisableNotification.fromMap(map),
    'setChatAvailableReactions': (map) => SetChatAvailableReactions.fromMap(map),
    'setChatClientData': (map) => SetChatClientData.fromMap(map),
    'setChatDescription': (map) => SetChatDescription.fromMap(map),
    'setChatDiscussionGroup': (map) => SetChatDiscussionGroup.fromMap(map),
    'setChatLocation': (map) => SetChatLocation.fromMap(map),
    'setChatSlowModeDelay': (map) => SetChatSlowModeDelay.fromMap(map),
    'pinChatMessage': (map) => PinChatMessage.fromMap(map),
    'unpinChatMessage': (map) => UnpinChatMessage.fromMap(map),
    'unpinAllChatMessages': (map) => UnpinAllChatMessages.fromMap(map),
    'joinChat': (map) => JoinChat.fromMap(map),
    'leaveChat': (map) => LeaveChat.fromMap(map),
    'addChatMember': (map) => AddChatMember.fromMap(map),
    'addChatMembers': (map) => AddChatMembers.fromMap(map),
    'setChatMemberStatus': (map) => SetChatMemberStatus.fromMap(map),
    'banChatMember': (map) => BanChatMember.fromMap(map),
    'canTransferOwnership': (map) => CanTransferOwnership.fromMap(map),
    'transferChatOwnership': (map) => TransferChatOwnership.fromMap(map),
    'getChatMember': (map) => GetChatMember.fromMap(map),
    'searchChatMembers': (map) => SearchChatMembers.fromMap(map),
    'getChatAdministrators': (map) => GetChatAdministrators.fromMap(map),
    'clearAllDraftMessages': (map) => ClearAllDraftMessages.fromMap(map),
    'getSavedNotificationSound': (map) => GetSavedNotificationSound.fromMap(map),
    'getSavedNotificationSounds': (map) => GetSavedNotificationSounds.fromMap(map),
    'addSavedNotificationSound': (map) => AddSavedNotificationSound.fromMap(map),
    'removeSavedNotificationSound': (map) => RemoveSavedNotificationSound.fromMap(map),
    'getChatNotificationSettingsExceptions': (map) => GetChatNotificationSettingsExceptions.fromMap(map),
    'getScopeNotificationSettings': (map) => GetScopeNotificationSettings.fromMap(map),
    'setScopeNotificationSettings': (map) => SetScopeNotificationSettings.fromMap(map),
    'resetAllNotificationSettings': (map) => ResetAllNotificationSettings.fromMap(map),
    'toggleChatIsPinned': (map) => ToggleChatIsPinned.fromMap(map),
    'setPinnedChats': (map) => SetPinnedChats.fromMap(map),
    'getAttachmentMenuBot': (map) => GetAttachmentMenuBot.fromMap(map),
    'toggleBotIsAddedToAttachmentMenu': (map) => ToggleBotIsAddedToAttachmentMenu.fromMap(map),
    'downloadFile': (map) => DownloadFile.fromMap(map),
    'getFileDownloadedPrefixSize': (map) => GetFileDownloadedPrefixSize.fromMap(map),
    'cancelDownloadFile': (map) => CancelDownloadFile.fromMap(map),
    'getSuggestedFileName': (map) => GetSuggestedFileName.fromMap(map),
    'uploadFile': (map) => UploadFile.fromMap(map),
    'cancelUploadFile': (map) => CancelUploadFile.fromMap(map),
    'writeGeneratedFilePart': (map) => WriteGeneratedFilePart.fromMap(map),
    'setFileGenerationProgress': (map) => SetFileGenerationProgress.fromMap(map),
    'finishFileGeneration': (map) => FinishFileGeneration.fromMap(map),
    'readFilePart': (map) => ReadFilePart.fromMap(map),
    'deleteFile': (map) => DeleteFile.fromMap(map),
    'addFileToDownloads': (map) => AddFileToDownloads.fromMap(map),
    'toggleDownloadIsPaused': (map) => ToggleDownloadIsPaused.fromMap(map),
    'toggleAllDownloadsArePaused': (map) => ToggleAllDownloadsArePaused.fromMap(map),
    'removeFileFromDownloads': (map) => RemoveFileFromDownloads.fromMap(map),
    'removeAllFilesFromDownloads': (map) => RemoveAllFilesFromDownloads.fromMap(map),
    'searchFileDownloads': (map) => SearchFileDownloads.fromMap(map),
    'getMessageFileType': (map) => GetMessageFileType.fromMap(map),
    'getMessageImportConfirmationText': (map) => GetMessageImportConfirmationText.fromMap(map),
    'importMessages': (map) => ImportMessages.fromMap(map),
    'replacePrimaryChatInviteLink': (map) => ReplacePrimaryChatInviteLink.fromMap(map),
    'createChatInviteLink': (map) => CreateChatInviteLink.fromMap(map),
    'editChatInviteLink': (map) => EditChatInviteLink.fromMap(map),
    'getChatInviteLink': (map) => GetChatInviteLink.fromMap(map),
    'getChatInviteLinkCounts': (map) => GetChatInviteLinkCounts.fromMap(map),
    'getChatInviteLinks': (map) => GetChatInviteLinks.fromMap(map),
    'getChatInviteLinkMembers': (map) => GetChatInviteLinkMembers.fromMap(map),
    'revokeChatInviteLink': (map) => RevokeChatInviteLink.fromMap(map),
    'deleteRevokedChatInviteLink': (map) => DeleteRevokedChatInviteLink.fromMap(map),
    'deleteAllRevokedChatInviteLinks': (map) => DeleteAllRevokedChatInviteLinks.fromMap(map),
    'checkChatInviteLink': (map) => CheckChatInviteLink.fromMap(map),
    'joinChatByInviteLink': (map) => JoinChatByInviteLink.fromMap(map),
    'getChatJoinRequests': (map) => GetChatJoinRequests.fromMap(map),
    'processChatJoinRequest': (map) => ProcessChatJoinRequest.fromMap(map),
    'processChatJoinRequests': (map) => ProcessChatJoinRequests.fromMap(map),
    'createCall': (map) => CreateCall.fromMap(map),
    'acceptCall': (map) => AcceptCall.fromMap(map),
    'sendCallSignalingData': (map) => SendCallSignalingData.fromMap(map),
    'discardCall': (map) => DiscardCall.fromMap(map),
    'sendCallRating': (map) => SendCallRating.fromMap(map),
    'sendCallDebugInformation': (map) => SendCallDebugInformation.fromMap(map),
    'sendCallLog': (map) => SendCallLog.fromMap(map),
    'getVideoChatAvailableParticipants': (map) => GetVideoChatAvailableParticipants.fromMap(map),
    'setVideoChatDefaultParticipant': (map) => SetVideoChatDefaultParticipant.fromMap(map),
    'createVideoChat': (map) => CreateVideoChat.fromMap(map),
    'getVideoChatRtmpUrl': (map) => GetVideoChatRtmpUrl.fromMap(map),
    'replaceVideoChatRtmpUrl': (map) => ReplaceVideoChatRtmpUrl.fromMap(map),
    'getGroupCall': (map) => GetGroupCall.fromMap(map),
    'startScheduledGroupCall': (map) => StartScheduledGroupCall.fromMap(map),
    'toggleGroupCallEnabledStartNotification': (map) => ToggleGroupCallEnabledStartNotification.fromMap(map),
    'joinGroupCall': (map) => JoinGroupCall.fromMap(map),
    'startGroupCallScreenSharing': (map) => StartGroupCallScreenSharing.fromMap(map),
    'toggleGroupCallScreenSharingIsPaused': (map) => ToggleGroupCallScreenSharingIsPaused.fromMap(map),
    'endGroupCallScreenSharing': (map) => EndGroupCallScreenSharing.fromMap(map),
    'setGroupCallTitle': (map) => SetGroupCallTitle.fromMap(map),
    'toggleGroupCallMuteNewParticipants': (map) => ToggleGroupCallMuteNewParticipants.fromMap(map),
    'inviteGroupCallParticipants': (map) => InviteGroupCallParticipants.fromMap(map),
    'getGroupCallInviteLink': (map) => GetGroupCallInviteLink.fromMap(map),
    'revokeGroupCallInviteLink': (map) => RevokeGroupCallInviteLink.fromMap(map),
    'startGroupCallRecording': (map) => StartGroupCallRecording.fromMap(map),
    'endGroupCallRecording': (map) => EndGroupCallRecording.fromMap(map),
    'toggleGroupCallIsMyVideoPaused': (map) => ToggleGroupCallIsMyVideoPaused.fromMap(map),
    'toggleGroupCallIsMyVideoEnabled': (map) => ToggleGroupCallIsMyVideoEnabled.fromMap(map),
    'setGroupCallParticipantIsSpeaking': (map) => SetGroupCallParticipantIsSpeaking.fromMap(map),
    'toggleGroupCallParticipantIsMuted': (map) => ToggleGroupCallParticipantIsMuted.fromMap(map),
    'setGroupCallParticipantVolumeLevel': (map) => SetGroupCallParticipantVolumeLevel.fromMap(map),
    'toggleGroupCallParticipantIsHandRaised': (map) => ToggleGroupCallParticipantIsHandRaised.fromMap(map),
    'loadGroupCallParticipants': (map) => LoadGroupCallParticipants.fromMap(map),
    'leaveGroupCall': (map) => LeaveGroupCall.fromMap(map),
    'endGroupCall': (map) => EndGroupCall.fromMap(map),
    'getGroupCallStreams': (map) => GetGroupCallStreams.fromMap(map),
    'getGroupCallStreamSegment': (map) => GetGroupCallStreamSegment.fromMap(map),
    'toggleMessageSenderIsBlocked': (map) => ToggleMessageSenderIsBlocked.fromMap(map),
    'blockMessageSenderFromReplies': (map) => BlockMessageSenderFromReplies.fromMap(map),
    'getBlockedMessageSenders': (map) => GetBlockedMessageSenders.fromMap(map),
    'addContact': (map) => AddContact.fromMap(map),
    'importContacts': (map) => ImportContacts.fromMap(map),
    'getContacts': (map) => GetContacts.fromMap(map),
    'searchContacts': (map) => SearchContacts.fromMap(map),
    'removeContacts': (map) => RemoveContacts.fromMap(map),
    'getImportedContactCount': (map) => GetImportedContactCount.fromMap(map),
    'changeImportedContacts': (map) => ChangeImportedContacts.fromMap(map),
    'clearImportedContacts': (map) => ClearImportedContacts.fromMap(map),
    'searchUserByPhoneNumber': (map) => SearchUserByPhoneNumber.fromMap(map),
    'sharePhoneNumber': (map) => SharePhoneNumber.fromMap(map),
    'getUserProfilePhotos': (map) => GetUserProfilePhotos.fromMap(map),
    'getStickers': (map) => GetStickers.fromMap(map),
    'searchStickers': (map) => SearchStickers.fromMap(map),
    'getInstalledStickerSets': (map) => GetInstalledStickerSets.fromMap(map),
    'getArchivedStickerSets': (map) => GetArchivedStickerSets.fromMap(map),
    'getTrendingStickerSets': (map) => GetTrendingStickerSets.fromMap(map),
    'getAttachedStickerSets': (map) => GetAttachedStickerSets.fromMap(map),
    'getStickerSet': (map) => GetStickerSet.fromMap(map),
    'searchStickerSet': (map) => SearchStickerSet.fromMap(map),
    'searchInstalledStickerSets': (map) => SearchInstalledStickerSets.fromMap(map),
    'searchStickerSets': (map) => SearchStickerSets.fromMap(map),
    'changeStickerSet': (map) => ChangeStickerSet.fromMap(map),
    'viewTrendingStickerSets': (map) => ViewTrendingStickerSets.fromMap(map),
    'reorderInstalledStickerSets': (map) => ReorderInstalledStickerSets.fromMap(map),
    'getRecentStickers': (map) => GetRecentStickers.fromMap(map),
    'addRecentSticker': (map) => AddRecentSticker.fromMap(map),
    'removeRecentSticker': (map) => RemoveRecentSticker.fromMap(map),
    'clearRecentStickers': (map) => ClearRecentStickers.fromMap(map),
    'getFavoriteStickers': (map) => GetFavoriteStickers.fromMap(map),
    'addFavoriteSticker': (map) => AddFavoriteSticker.fromMap(map),
    'removeFavoriteSticker': (map) => RemoveFavoriteSticker.fromMap(map),
    'getStickerEmojis': (map) => GetStickerEmojis.fromMap(map),
    'searchEmojis': (map) => SearchEmojis.fromMap(map),
    'getAnimatedEmoji': (map) => GetAnimatedEmoji.fromMap(map),
    'getAllAnimatedEmojis': (map) => GetAllAnimatedEmojis.fromMap(map),
    'getEmojiSuggestionsUrl': (map) => GetEmojiSuggestionsUrl.fromMap(map),
    'getSavedAnimations': (map) => GetSavedAnimations.fromMap(map),
    'addSavedAnimation': (map) => AddSavedAnimation.fromMap(map),
    'removeSavedAnimation': (map) => RemoveSavedAnimation.fromMap(map),
    'getRecentInlineBots': (map) => GetRecentInlineBots.fromMap(map),
    'searchHashtags': (map) => SearchHashtags.fromMap(map),
    'removeRecentHashtag': (map) => RemoveRecentHashtag.fromMap(map),
    'getWebPagePreview': (map) => GetWebPagePreview.fromMap(map),
    'getWebPageInstantView': (map) => GetWebPageInstantView.fromMap(map),
    'setProfilePhoto': (map) => SetProfilePhoto.fromMap(map),
    'deleteProfilePhoto': (map) => DeleteProfilePhoto.fromMap(map),
    'setName': (map) => SetName.fromMap(map),
    'setBio': (map) => SetBio.fromMap(map),
    'setUsername': (map) => SetUsername.fromMap(map),
    'setLocation': (map) => SetLocation.fromMap(map),
    'changePhoneNumber': (map) => ChangePhoneNumber.fromMap(map),
    'resendChangePhoneNumberCode': (map) => ResendChangePhoneNumberCode.fromMap(map),
    'checkChangePhoneNumberCode': (map) => CheckChangePhoneNumberCode.fromMap(map),
    'setCommands': (map) => SetCommands.fromMap(map),
    'deleteCommands': (map) => DeleteCommands.fromMap(map),
    'getCommands': (map) => GetCommands.fromMap(map),
    'setMenuButton': (map) => SetMenuButton.fromMap(map),
    'getMenuButton': (map) => GetMenuButton.fromMap(map),
    'setDefaultGroupAdministratorRights': (map) => SetDefaultGroupAdministratorRights.fromMap(map),
    'setDefaultChannelAdministratorRights': (map) => SetDefaultChannelAdministratorRights.fromMap(map),
    'getActiveSessions': (map) => GetActiveSessions.fromMap(map),
    'terminateSession': (map) => TerminateSession.fromMap(map),
    'terminateAllOtherSessions': (map) => TerminateAllOtherSessions.fromMap(map),
    'toggleSessionCanAcceptCalls': (map) => ToggleSessionCanAcceptCalls.fromMap(map),
    'toggleSessionCanAcceptSecretChats': (map) => ToggleSessionCanAcceptSecretChats.fromMap(map),
    'setInactiveSessionTtl': (map) => SetInactiveSessionTtl.fromMap(map),
    'getConnectedWebsites': (map) => GetConnectedWebsites.fromMap(map),
    'disconnectWebsite': (map) => DisconnectWebsite.fromMap(map),
    'disconnectAllWebsites': (map) => DisconnectAllWebsites.fromMap(map),
    'setSupergroupUsername': (map) => SetSupergroupUsername.fromMap(map),
    'setSupergroupStickerSet': (map) => SetSupergroupStickerSet.fromMap(map),
    'toggleSupergroupSignMessages': (map) => ToggleSupergroupSignMessages.fromMap(map),
    'toggleSupergroupJoinToSendMessages': (map) => ToggleSupergroupJoinToSendMessages.fromMap(map),
    'toggleSupergroupJoinByRequest': (map) => ToggleSupergroupJoinByRequest.fromMap(map),
    'toggleSupergroupIsAllHistoryAvailable': (map) => ToggleSupergroupIsAllHistoryAvailable.fromMap(map),
    'toggleSupergroupIsBroadcastGroup': (map) => ToggleSupergroupIsBroadcastGroup.fromMap(map),
    'reportSupergroupSpam': (map) => ReportSupergroupSpam.fromMap(map),
    'getSupergroupMembers': (map) => GetSupergroupMembers.fromMap(map),
    'closeSecretChat': (map) => CloseSecretChat.fromMap(map),
    'getChatEventLog': (map) => GetChatEventLog.fromMap(map),
    'getPaymentForm': (map) => GetPaymentForm.fromMap(map),
    'validateOrderInfo': (map) => ValidateOrderInfo.fromMap(map),
    'sendPaymentForm': (map) => SendPaymentForm.fromMap(map),
    'getPaymentReceipt': (map) => GetPaymentReceipt.fromMap(map),
    'getSavedOrderInfo': (map) => GetSavedOrderInfo.fromMap(map),
    'deleteSavedOrderInfo': (map) => DeleteSavedOrderInfo.fromMap(map),
    'deleteSavedCredentials': (map) => DeleteSavedCredentials.fromMap(map),
    'createInvoiceLink': (map) => CreateInvoiceLink.fromMap(map),
    'getSupportUser': (map) => GetSupportUser.fromMap(map),
    'getBackgrounds': (map) => GetBackgrounds.fromMap(map),
    'getBackgroundUrl': (map) => GetBackgroundUrl.fromMap(map),
    'searchBackground': (map) => SearchBackground.fromMap(map),
    'setBackground': (map) => SetBackground.fromMap(map),
    'removeBackground': (map) => RemoveBackground.fromMap(map),
    'resetBackgrounds': (map) => ResetBackgrounds.fromMap(map),
    'getLocalizationTargetInfo': (map) => GetLocalizationTargetInfo.fromMap(map),
    'getLanguagePackInfo': (map) => GetLanguagePackInfo.fromMap(map),
    'getLanguagePackStrings': (map) => GetLanguagePackStrings.fromMap(map),
    'synchronizeLanguagePack': (map) => SynchronizeLanguagePack.fromMap(map),
    'addCustomServerLanguagePack': (map) => AddCustomServerLanguagePack.fromMap(map),
    'setCustomLanguagePack': (map) => SetCustomLanguagePack.fromMap(map),
    'editCustomLanguagePackInfo': (map) => EditCustomLanguagePackInfo.fromMap(map),
    'setCustomLanguagePackString': (map) => SetCustomLanguagePackString.fromMap(map),
    'deleteLanguagePack': (map) => DeleteLanguagePack.fromMap(map),
    'registerDevice': (map) => RegisterDevice.fromMap(map),
    'processPushNotification': (map) => ProcessPushNotification.fromMap(map),
    'getPushReceiverId': (map) => GetPushReceiverId.fromMap(map),
    'getRecentlyVisitedTMeUrls': (map) => GetRecentlyVisitedTMeUrls.fromMap(map),
    'setUserPrivacySettingRules': (map) => SetUserPrivacySettingRules.fromMap(map),
    'getUserPrivacySettingRules': (map) => GetUserPrivacySettingRules.fromMap(map),
    'getOption': (map) => GetOption.fromMap(map),
    'setOption': (map) => SetOption.fromMap(map),
    'setAccountTtl': (map) => SetAccountTtl.fromMap(map),
    'getAccountTtl': (map) => GetAccountTtl.fromMap(map),
    'deleteAccount': (map) => DeleteAccount.fromMap(map),
    'removeChatActionBar': (map) => RemoveChatActionBar.fromMap(map),
    'reportChat': (map) => ReportChat.fromMap(map),
    'reportChatPhoto': (map) => ReportChatPhoto.fromMap(map),
    'getChatStatistics': (map) => GetChatStatistics.fromMap(map),
    'getMessageStatistics': (map) => GetMessageStatistics.fromMap(map),
    'getStatisticalGraph': (map) => GetStatisticalGraph.fromMap(map),
    'getStorageStatistics': (map) => GetStorageStatistics.fromMap(map),
    'getStorageStatisticsFast': (map) => GetStorageStatisticsFast.fromMap(map),
    'getDatabaseStatistics': (map) => GetDatabaseStatistics.fromMap(map),
    'optimizeStorage': (map) => OptimizeStorage.fromMap(map),
    'setNetworkType': (map) => SetNetworkType.fromMap(map),
    'getNetworkStatistics': (map) => GetNetworkStatistics.fromMap(map),
    'addNetworkStatistics': (map) => AddNetworkStatistics.fromMap(map),
    'resetNetworkStatistics': (map) => ResetNetworkStatistics.fromMap(map),
    'getAutoDownloadSettingsPresets': (map) => GetAutoDownloadSettingsPresets.fromMap(map),
    'setAutoDownloadSettings': (map) => SetAutoDownloadSettings.fromMap(map),
    'getBankCardInfo': (map) => GetBankCardInfo.fromMap(map),
    'getPassportElement': (map) => GetPassportElement.fromMap(map),
    'getAllPassportElements': (map) => GetAllPassportElements.fromMap(map),
    'setPassportElement': (map) => SetPassportElement.fromMap(map),
    'deletePassportElement': (map) => DeletePassportElement.fromMap(map),
    'setPassportElementErrors': (map) => SetPassportElementErrors.fromMap(map),
    'getPreferredCountryLanguage': (map) => GetPreferredCountryLanguage.fromMap(map),
    'sendPhoneNumberVerificationCode': (map) => SendPhoneNumberVerificationCode.fromMap(map),
    'resendPhoneNumberVerificationCode': (map) => ResendPhoneNumberVerificationCode.fromMap(map),
    'checkPhoneNumberVerificationCode': (map) => CheckPhoneNumberVerificationCode.fromMap(map),
    'sendEmailAddressVerificationCode': (map) => SendEmailAddressVerificationCode.fromMap(map),
    'resendEmailAddressVerificationCode': (map) => ResendEmailAddressVerificationCode.fromMap(map),
    'checkEmailAddressVerificationCode': (map) => CheckEmailAddressVerificationCode.fromMap(map),
    'getPassportAuthorizationForm': (map) => GetPassportAuthorizationForm.fromMap(map),
    'getPassportAuthorizationFormAvailableElements': (map) => GetPassportAuthorizationFormAvailableElements.fromMap(map),
    'sendPassportAuthorizationForm': (map) => SendPassportAuthorizationForm.fromMap(map),
    'sendPhoneNumberConfirmationCode': (map) => SendPhoneNumberConfirmationCode.fromMap(map),
    'resendPhoneNumberConfirmationCode': (map) => ResendPhoneNumberConfirmationCode.fromMap(map),
    'checkPhoneNumberConfirmationCode': (map) => CheckPhoneNumberConfirmationCode.fromMap(map),
    'setBotUpdatesStatus': (map) => SetBotUpdatesStatus.fromMap(map),
    'uploadStickerFile': (map) => UploadStickerFile.fromMap(map),
    'getSuggestedStickerSetName': (map) => GetSuggestedStickerSetName.fromMap(map),
    'checkStickerSetName': (map) => CheckStickerSetName.fromMap(map),
    'createNewStickerSet': (map) => CreateNewStickerSet.fromMap(map),
    'addStickerToSet': (map) => AddStickerToSet.fromMap(map),
    'setStickerSetThumbnail': (map) => SetStickerSetThumbnail.fromMap(map),
    'setStickerPositionInSet': (map) => SetStickerPositionInSet.fromMap(map),
    'removeStickerFromSet': (map) => RemoveStickerFromSet.fromMap(map),
    'getMapThumbnailFile': (map) => GetMapThumbnailFile.fromMap(map),
    'getPremiumLimit': (map) => GetPremiumLimit.fromMap(map),
    'getPremiumFeatures': (map) => GetPremiumFeatures.fromMap(map),
    'getPremiumStickers': (map) => GetPremiumStickers.fromMap(map),
    'viewPremiumFeature': (map) => ViewPremiumFeature.fromMap(map),
    'clickPremiumSubscriptionButton': (map) => ClickPremiumSubscriptionButton.fromMap(map),
    'getPremiumState': (map) => GetPremiumState.fromMap(map),
    'canPurchasePremium': (map) => CanPurchasePremium.fromMap(map),
    'assignAppStoreTransaction': (map) => AssignAppStoreTransaction.fromMap(map),
    'assignGooglePlayTransaction': (map) => AssignGooglePlayTransaction.fromMap(map),
    'acceptTermsOfService': (map) => AcceptTermsOfService.fromMap(map),
    'sendCustomRequest': (map) => SendCustomRequest.fromMap(map),
    'answerCustomQuery': (map) => AnswerCustomQuery.fromMap(map),
    'setAlarm': (map) => SetAlarm.fromMap(map),
    'getCountries': (map) => GetCountries.fromMap(map),
    'getCountryCode': (map) => GetCountryCode.fromMap(map),
    'getPhoneNumberInfo': (map) => GetPhoneNumberInfo.fromMap(map),
    'getPhoneNumberInfoSync': (map) => GetPhoneNumberInfoSync.fromMap(map),
    'getApplicationDownloadLink': (map) => GetApplicationDownloadLink.fromMap(map),
    'getDeepLinkInfo': (map) => GetDeepLinkInfo.fromMap(map),
    'getApplicationConfig': (map) => GetApplicationConfig.fromMap(map),
    'saveApplicationLogEvent': (map) => SaveApplicationLogEvent.fromMap(map),
    'addProxy': (map) => AddProxy.fromMap(map),
    'editProxy': (map) => EditProxy.fromMap(map),
    'enableProxy': (map) => EnableProxy.fromMap(map),
    'disableProxy': (map) => DisableProxy.fromMap(map),
    'removeProxy': (map) => RemoveProxy.fromMap(map),
    'getProxies': (map) => GetProxies.fromMap(map),
    'getProxyLink': (map) => GetProxyLink.fromMap(map),
    'pingProxy': (map) => PingProxy.fromMap(map),
    'setLogStream': (map) => SetLogStream.fromMap(map),
    'getLogStream': (map) => GetLogStream.fromMap(map),
    'setLogVerbosityLevel': (map) => SetLogVerbosityLevel.fromMap(map),
    'getLogVerbosityLevel': (map) => GetLogVerbosityLevel.fromMap(map),
    'getLogTags': (map) => GetLogTags.fromMap(map),
    'setLogTagVerbosityLevel': (map) => SetLogTagVerbosityLevel.fromMap(map),
    'getLogTagVerbosityLevel': (map) => GetLogTagVerbosityLevel.fromMap(map),
    'addLogMessage': (map) => AddLogMessage.fromMap(map),
    'testCallEmpty': (map) => TestCallEmpty.fromMap(map),
    'testCallString': (map) => TestCallString.fromMap(map),
    'testCallBytes': (map) => TestCallBytes.fromMap(map),
    'testCallVectorInt': (map) => TestCallVectorInt.fromMap(map),
    'testCallVectorIntObject': (map) => TestCallVectorIntObject.fromMap(map),
    'testCallVectorString': (map) => TestCallVectorString.fromMap(map),
    'testCallVectorStringObject': (map) => TestCallVectorStringObject.fromMap(map),
    'testSquareInt': (map) => TestSquareInt.fromMap(map),
    'testNetwork': (map) => TestNetwork.fromMap(map),
    'testProxy': (map) => TestProxy.fromMap(map),
    'testGetDifference': (map) => TestGetDifference.fromMap(map),
    'testUseUpdate': (map) => TestUseUpdate.fromMap(map),
    'testReturnError': (map) => TestReturnError.fromMap(map),
  };

  /// Create a [Td] instance from a JSON [String].
  static Td? fromMap(Map<String, dynamic> map) {
    return _tdMap.containsKey(map['@type']) ? _tdMap[map['@type']]!(map) : null;
  }
}
