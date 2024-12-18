import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:oneship_merchant_app/config/routes/app_router.dart';
import 'package:oneship_merchant_app/config/theme/theme_config.dart';

String? firebaseToken;

class MerchantApp extends StatefulWidget {
  const MerchantApp({super.key});

  @override
  State<MerchantApp> createState() => _MerchantAppState();
}

class _MerchantAppState extends State<MerchantApp> {
  @override
  void initState() {
    initFirebaseMessaging();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    super.initState();
  }

  Future<void> initFirebaseMessaging() async {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      final firebaseMessaging = FirebaseMessaging.instance;
      final NotificationSettings checkPermission =
          await firebaseMessaging.requestPermission();

      if (checkPermission.authorizationStatus ==
          AuthorizationStatus.authorized) {
        firebaseToken = await firebaseMessaging.getToken();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('vi'),
      ],
      enableLog: true,
      debugShowCheckedModeBanner: false,
      theme: Themings.lightTheme,
      title: 'Merchant',
      initialRoute: AppRoutes.splash,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(
            1.0,
          )),
          child: child!,
        );
      },
      getPages: AppRoutes.routes,
    );
  }
}
