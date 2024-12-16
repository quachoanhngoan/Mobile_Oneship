import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:oneship_merchant_app/app.dart';
import 'package:oneship_merchant_app/core/repositories/auth/auth_repository.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/page/login/auth/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/register/register_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/register/register_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();
  await injector.get<AuthRepositoy>().init();

  await runZonedGuarded<Future<void>>(() async {
    runApp(
      MultiBlocProvider(providers: [
        BlocProvider(create: (context) => injector<AuthCubit>()),
        BlocProvider(
          create: (context) => RegisterCubit(),
          child: const RegisterPage(),
        )
      ], child: const MerchantApp()),
    );
  }, (error, stackTrace) {
    log('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
