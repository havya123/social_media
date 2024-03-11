import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/app/store/app_store.dart';

class NotificationController extends GetxController {
  Future<NotificationController> init() async {
    try {
      bool isAllowedToSendNotification =
          await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowedToSendNotification) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
      await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelKey: "friend_request_channel",
            channelName: "Friend Request",
            channelDescription: "Channel of sending friend request",
            defaultColor: Colors.redAccent,
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            locked: false,
          )
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: "friend_request_channel",
              channelGroupName: "Friend Request")
        ],
      );
      AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      );
    } catch (e) {}
    return this;
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  Future<void> sendFriendRequest(
      String userToken, String body, String title) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/social-media-b5d9c/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ya29.AIzaSyB7W50joaUzlcmSWeRHQWVfQMqh0NIAhPw',
        },
        body: jsonEncode(
          <String, dynamic>{
            'message': <String, dynamic>{
              "topic": "news",
              "notification": {
                'body': body,
                'title': title,
              }
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': userToken,
            'token': AppStore.to.deviceToken
          },
        ),
      );
      response;
    } catch (e) {
      e;
    }
  }
}
