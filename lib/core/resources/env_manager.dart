import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvManager {
  static final _instance = EnvManager._();

  factory EnvManager() => _instance;

  EnvManager._();
  static EnvManager get shared => _instance;

  String get api => dotenv.env['BASE_URL']!;
}
