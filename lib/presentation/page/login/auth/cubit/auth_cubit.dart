import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/app.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/core/helper/device.helper.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/dto/request_login.dart';
import 'package:oneship_merchant_app/presentation/data/model/user/user_model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/auth_repository.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  AuthCubit(this.repository) : super(AuthState());

  loginSubmit(
    String phone,
    String password,
  ) async {
    emit(state.copyWith(loadingState: EState.loading));
    if (phone.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        loadingState: EState.failure,
      ));
      return;
    }

    //TODO: get firebase token
    // if (firebaseToken == null) {
    //   await getDeviceToken();
    //   if (firebaseToken == null) {
    //     dialogService.showAlertDialog(
    //         title: "Thông báo",
    //         description: "Bạn chưa cấp quyền cho ứng dụng, vui lòng thử lại",
    //         buttonTitle: 'OK');
    //   }
    //   return;
    // }
    final response = await execute(() => repository.login(RequestLoginDto(
          password: password,
          username: phone,
          deviceToken: firebaseToken ?? "test",
        )));
    response.when(success: (data) {
      if (data == null) {
        emit(state.copyWith(
          loadingState: EState.failure,
        ));
        return;
      }
      emit(state.copyWith(
        loadingState: EState.success,
        userData: data,
      ));
      prefManager.token = data.accessToken!;
      prefManager.refreshToken = data.refreshToken!;
      prefManager.user = data;
      Get.offAllNamed(AppRoutes.homepage);
    }, failure: (error) {
      emit(state.copyWith(
        loadingState: EState.failure,
      ));
    });
  }

  loginSMS(
    String idToken,
  ) async {
    emit(state.copyWith(loadingState: EState.loading));

    if (firebaseToken == null) {
      await getDeviceToken();
      if (firebaseToken == null) {
        dialogService.showAlertDialog(
            title: "Thông báo",
            description: "Bạn chưa cấp quyền cho ứng dụng, vui lòng thử lại",
            buttonTitle: 'OK');
      }
      return;
    }
    final response = await execute(() => repository.loginSms(RequestLoginSms(
          idToken: idToken,
          deviceToken: firebaseToken ?? "test",
        )));
    response.when(success: (data) {
      if (data == null) {
        emit(state.copyWith(
          loadingState: EState.failure,
        ));
        return;
      }
      emit(state.copyWith(
        loadingState: EState.success,
        userData: data,
      ));
      prefManager.token = data.accessToken!;
      prefManager.refreshToken = data.refreshToken!;
      prefManager.user = data;
      Get.offAllNamed(AppRoutes.homepage);
    }, failure: (error) {
      emit(state.copyWith(
        loadingState: EState.failure,
      ));
    });
  }

  logout() {
    prefManager.logout();
    Get.offAllNamed(AppRoutes.onBoardingPage);
  }
}
