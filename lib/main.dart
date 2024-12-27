import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/app.dart';
import 'package:oneship_merchant_app/core/repositories/auth/auth_repository.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/my_http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/presentation/page/bottom_tab/bottom_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/register/register_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/register/register_page.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();
    await dotenv.load(fileName: ".env.dev");
    HttpOverrides.global = MyHttpOverrides();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await Firebase.initializeApp(
      name: 'MerchantApp',
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await setCrashlyticsCollection();

    await initializeDependencies();
    await injector.get<AuthRepositoy>().init();

    runApp(
      MultiBlocProvider(providers: [
        BlocProvider(create: (context) => injector<AuthCubit>()),
        BlocProvider(create: (context) => injector<StoreCubit>()),
        BlocProvider(create: (context) => injector<BottomCubit>()),
        BlocProvider(create: (context) => injector<MenuDinerCubit>()),

        // BlocProvider(create: (context) => injector<RegisterStoreCubit>()),
        BlocProvider(
          create: (context) => RegisterCubit(),
          child: const RegisterPage(),
        ),
        // BlocProvider(create: (context) => injector<ToppingCustomCubit>()),
      ], child: const MerchantApp()),
    );
  }, (error, stackTrace) {
    print(error);
    log('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

Future<void> setCrashlyticsCollection() async {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  if (!FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
    await FirebaseCrashlytics.instance.deleteUnsentReports();
  }
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
}
