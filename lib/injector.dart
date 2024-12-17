import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:oneship_merchant_app/core/datasource/auth_api_service.dart';
import 'package:oneship_merchant_app/core/repositories/auth/auth_repository.dart';

import 'presentation/data/validations/user_validation.dart';

final injector = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetit',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> initializeDependencies() async {
  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());
  //register your dependencies here
  // getIt.registerSingleton<AuthService>(AuthService());

  injector.registerSingleton<Dio>(dio);

  injector.registerSingleton<AuthApiService>(AuthApiService(injector<Dio>()));

  injector.registerSingleton<UserValidate>(UserValidate());
  injector.registerSingleton<AuthRepositoy>(
      AuthRepositoryImpl(injector<AuthApiService>()));
}
