import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:oneship_merchant_app/app.dart';

// ignore: depend_on_referenced_packages

Future<void> getDeviceToken() async {
  try {
    final firebaseMessaging = FirebaseMessaging.instance;
    final NotificationSettings checkPermission =
        await firebaseMessaging.requestPermission();

    if (checkPermission.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await firebaseMessaging.getToken();
      firebaseToken = token;
    }
  } catch (e) {
    print(e);
  }
}
