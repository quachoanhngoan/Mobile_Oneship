import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'presentation/data/validations/user_validation.dart';

final injector = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetit',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> initializeDependencies() async {
  //register your dependencies here
  // getIt.registerSingleton<AuthService>(AuthService());

  injector.registerSingleton<UserValidate>(UserValidate());
}
