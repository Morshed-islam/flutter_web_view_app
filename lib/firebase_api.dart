// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  final _firebaseMessaging =   FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    _firebaseMessaging.subscribeToTopic('all_user');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    log("token : $fcmToken");
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async{
    log('notification');
    log("title: ${message.notification?.title}");
    log("body: ${message.notification?.body}");
    log("payload: ${message.data}");

  }

}