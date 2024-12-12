import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/app.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();
  runApp(const MyApp());
}
