//TODO:⚙️ iOS setup
//Add the following lines to the didFinishLaunchingWithOptions
//method in the AppDelegate.m/AppDelegate.swift file of your iOS project
//
//Swift:
// if #available(iOS 10.0, *) {
//   UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
// }

//TODO:Release build configuration.
/*
Release build configuration
Before creating the release build of your app 
(which is the default setting when building an APK or app bundle) you will likely 
need to customise your ProGuard configuration file as per this link and add the following line:

-keep class com.dexterous.** { *; }
After doing so, rules specific to the GSON dependency being used by the plugin will
 also needed to be added. These rules can be found here. The example app has a consolidated Proguard 
 rules (proguard-rules.pro) file that combines these together for reference here.

⚠️ Ensure that you have configured the resources that should be kept so that resources 
like your notification icons aren't discarded by the R8 compiler by following the instructions 
here. Without doing this, you might not see the icon you've specified in your app's notifications. 
The configuration used by the example app can be found here where it is specifying that all drawable 
resources should be kept, as well as the file used to play a custom notification sound (sound file is located here).
*/
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'routes/pages.dart';

///push notifications at a specific time and cancel them.
class ControlNotification {
  static ControlNotification controlNotification;

  static const _androidChannelId = '#TodoChannelId0';
  static const _androidChannelName = 'reminder Notification';
  static const _androidChannelDescription =
      'remind the user if they add a reminder to a specific note';

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final androidInitializationSettings =
      AndroidInitializationSettings('notification_icon');

  IOSInitializationSettings iosInitializationSettings;

  InitializationSettings initializationSettings;

  BuildContext context;

  ///Singleton
  factory ControlNotification(BuildContext context) {
    controlNotification ??= ControlNotification._(context);

    return controlNotification;
  }

  ControlNotification._(this.context) {
    iosInitializationSettings = IOSInitializationSettings(
      //For Ios 10 or below.
      onDidReceiveLocalNotification: (id, title, body, payload) =>
          selectNotification(payload),
      requestSoundPermission: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );

    initializationSettings = InitializationSettings(
      androidInitializationSettings,
      iosInitializationSettings,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  ///When The user press the notification.
  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  ///Push notification now.
  ///
  ///For testing only :)
  Future<void> pushNotification({
    int id = 0,
    String title = '',
    String body = '',
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _androidChannelId,
      _androidChannelName,
      _androidChannelDescription,
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'title:$title , desciption:$body',
    );

    const iOSPlatformChannelSpecifics = IOSNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Some Data to Send if you want',
    );
  }

  Future<void> pushScheduledNotification({
    int id = 0,
    String title = '',
    String body = '',
    @required DateTime dateTime,
  }) async {
    if (dateTime == null) return;

    // final scheduledNotificationDateTime = DateTime.now().add(Duration(
    //     days: dateTime.day, hours: dateTime.hour, minutes: dateTime.minute));

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _androidChannelId,
      _androidChannelName,
      _androidChannelDescription,
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'title:$title , desciption:$body',
    );

    const iOSPlatformChannelSpecifics = IOSNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
      id,
      title,
      body,
      dateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
