import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationManager._instance();

  static final NotificationManager _notificationManager =
      NotificationManager._instance();

  factory NotificationManager() => _notificationManager;

  createNotification() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  callNotification(String title, String body) {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_channel', 'High Importance Notification',
        description: "This channel is for important notification",
        importance: Importance.max);

    flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description),
        ));
  }

  Future callNotificationAfterDelay(DateTime date, TimeOfDay timeOfDay) async {
    var scheduleNotificationDateTime =
        date.add(Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute));

    log(date.toString() + timeOfDay.toString());
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_channel', 'High Importance Notification',
        description: "This channel is for important notification",
        importance: Importance.max);

    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Test Title',
        'Test Body',
        scheduleNotificationDateTime,
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description),
        ));
  }
}
