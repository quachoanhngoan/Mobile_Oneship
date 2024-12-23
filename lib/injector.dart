import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:oneship_merchant_app/presentation/data/repository/auth_repository.dart';
import 'package:oneship_merchant_app/presentation/data/repository/store_repository.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/service/pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/data/utils.dart';
import 'presentation/page/login/cubit/auth_cubit.dart';
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
  final dio = Dio(BaseOptions(headers: {
    'Accept': '*/*',
    // 'Content-Type': 'application/json',
  }));

  // dio.interceptors.add(AwesomeDioInterceptor());
  injector.registerSingleton<Dio>(dio);

  //register your dependencies here
  injector.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  injector.registerSingleton<PrefManager>(PrefManager(injector()));

  injector.registerSingleton<DioUtil>(DioUtil(
    injector(),
    injector(),
  ));
  await repositoryModule();
  blocModule();

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
  injector.registerSingleton<StoreRepository>(
    StoreImpl(
      injector(),
    ),
  );
}

void blocModule() {
  injector.registerFactory<AuthCubit>(
    () => AuthCubit(injector()),
  );
  injector.registerFactory<StoreCubit>(
    () => StoreCubit(injector()),
  );
  injector.registerFactory<RegisterStoreCubit>(
    () => RegisterStoreCubit(injector()),
  );
}

PrefManager get prefManager => injector<PrefManager>();
