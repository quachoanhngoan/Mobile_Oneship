import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:oneship_merchant_app/config/routes/app_router.dart';
import 'package:oneship_merchant_app/config/theme/theme_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      initialRoute: AppRouter.homepage,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(
            1.0,
          )),
          child: child!,
        );
      },
      getPages: AppRouter.routes,
    );
  }
}
