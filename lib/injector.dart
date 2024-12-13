import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:oneship_merchant_app/presentation/data/repository/auth_repository.dart';
import 'package:oneship_merchant_app/service/pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/data/utils.dart';
import 'presentation/page/login/auth/cubit/auth_cubit.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  //register your dependencies here
  injector.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  injector.registerSingleton<PrefManager>(PrefManager(injector()));

  injector.registerSingleton<Dio>(Dio());
  injector.registerSingleton<DioUtil>(DioUtil(
    injector(),
    injector(),
  ));
  await repositoryModule();
  blocModule();
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
