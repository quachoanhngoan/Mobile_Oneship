import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:oneship_merchant_app/presentation/data/repository/auth_repository.dart';
import 'package:oneship_merchant_app/service/pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/data/utils.dart';
import 'presentation/page/login/cubit/auth_cubit.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
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
  injector.registerSingleton<Dio>(dio);

  //register your dependencies here
  injector.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  injector.registerSingleton<PrefManager>(PrefManager(injector()));

  // injector.registerSingleton<Dio>(Dio());
  injector.registerSingleton<DioUtil>(DioUtil(
    injector(),
    injector(),
  ));
  await repositoryModule();
  blocModule();
  // getIt.registerSingleton<AuthService>(AuthService());

  injector.registerSingleton<AuthApiService>(AuthApiService(injector<Dio>()));

  injector.registerSingleton<UserValidate>(UserValidate());
  injector.registerSingleton<AuthRepositoy>(
      AuthRepositoryImpl(injector<AuthApiService>()));
}

Future<void> repositoryModule() async {
  injector.registerSingleton<AuthRepository>(
    AuthImpl(
      injector(),
    ),
  );
}

void blocModule() {
  injector.registerFactory<AuthCubit>(
    () => AuthCubit(injector()),
  );
}

PrefManager get prefManager => injector<PrefManager>();
