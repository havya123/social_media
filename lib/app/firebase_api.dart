import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:social_media/manage/controller/notification_controller.dart';

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();
    final fCMToken = await firebaseMessaging.getToken();
    bool isAllowedToSendNotification =
        await AwesomeNotifications().isNotificationAllowed();
    if (isAllowedToSendNotification) {
      await AwesomeNotifications().requestPermissionToSendNotifications(
          channelKey: "friend_request_channel");
    }
    await AwesomeNotifications().initialize(null, [
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
    ], channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: "friend_request_channel",
          channelGroupName: "Friend Request")
    ]);
  }
}
