// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:oneship_merchant_app/service/pref_manager.dart';

// part 'auth_state.dart';

// class AuthBloc extends Cubit<AuthState> {
//   static AuthBloc of(BuildContext context) => BlocProvider.of(context);

//   AuthBloc(this._authLoginUseCase, this._authGetProvinceUseCase,
//       this._authRepository, this._frauDetectionCategoryRepository)
//       : super(AuthState(
//           auth: injector<PrefManager>().userModel,
//           vehicleType: injector<PrefManager>().temperatures,
//         ));

//   Timer? timerCheckProfile;
//   int timeOut = 10;
//   final DialogService _dialogService = injector<DialogService>();
//   FocusNode? passwordFocusNode;
//   FocusNode? emailFocusNode;
//   FocusNode? phoneFocusNode;

//   TextEditingController? emailController;
//   TextEditingController? passwordController;

//   void loginSubmit() async {
//     final vPhoneAndEmail = validatePhoneAndEmail();
//     if (!vPhoneAndEmail) {
//       return;
//     }
//     final vPassword = validatePassword();
//     if (!vPassword) {
//       return;
//     }
//     emit(state.copyWith(
//       status: AuthStatusBloc.loading,
//     ));
//     injector<PrefManager>().provinceId = state.selectionProvince!.id.toString();
//     injector<PrefManager>().province = state.selectionProvince;

//     final data = await _authLoginUseCase.execute(RequestLogin(
//       email: state.email,
//       phone: state.phone,
//       isLoginWithPhone: state.isLoginWithPhone,
//       password: state.password,
//       deviceId: Helper.instance.isDevMode() ? state.email : null,
//     ));
//     if (data is DataSuccess && data.data != null) {
//       injector<PrefManager>().token = data.data?.apiKey ?? "";
//       injector<PrefManager>().userId = data.data?.user?.id.toString() ?? "";
//       injector<PrefManager>().userModel = data.data?.user;
//       Get.offAllNamed(VillRoutes.homeNew);

//       if (Helper.instance.isDevMode()) {
//         saveUserLoginDev(AccountDev(
//           email: state.email,
//           password: state.password,
//           province: state.selectionProvince,
//         ));
//       }

//       emit(state.copyWith(
//         status: AuthStatusBloc.authenticated,
//         password: "",
//         email: "",
//       ));

//       return;
//     }
//     if (data is DataFailed) {
//       emit(state.copyWith(
//         status: AuthStatusBloc.initial,
//       ));
//       _dialogService.showDialogFailure(
//         textConfirm: "Xác nhận",
//         content: data.error?.message ?? "Đã có lỗi xảy ra",
//         confirm: () {
//           Get.back();
//         },
//       );
//       return;
//     }
//     if (data is DataError) {
//       emit(state.copyWith(
//         status: AuthStatusBloc.initial,
//       ));
//       _dialogService.showDialogFailure(
//         textConfirm: "Xác nhận",
//         content: data.errorString ?? "Đã có lỗi xảy ra",
//         confirm: () {
//           Get.back();
//         },
//       );
//       return;
//     }
//   }

//   bool validatePhoneAndEmail() {
//     if (state.isLoginWithPhone) {
//       if (!Helper.instance.checkPhone(state.phone)) {
//         DialogService.instance.showDialogConfirmOnePress(
//             content: "Số điện thoại không hợp lệ",
//             textConfirm: "Đồng ý",
//             onConfirm: () {
//               Get.back();
//               phoneFocusNode?.requestFocus();
//             },
//             colorTextConfirm: Colors.black);
//       }

//       return true;
//     }
//     if (state.email.isEmpty) {
//       _dialogService.showDialogFailure(
//           content: "Email không được để trống",
//           confirm: () {
//             Get.back();
//             emailFocusNode?.requestFocus();
//           },
//           textConfirm: "Đồng ý");
//       return false;
//     }
//     if (!Helper.instance.checkEmail(state.email)) {
//       _dialogService.showDialogFailure(
//           content: "Email không hợp lệ",
//           confirm: () {
//             Get.back();
//             emailFocusNode?.requestFocus();
//           },
//           textConfirm: "Đồng ý");
//       return false;
//     }
//     return true;
//   }

//   bool validatePassword() {
//     if (state.password.isEmpty) {
//       _dialogService.showDialogFailure(
//         textConfirm: "Xác nhận",
//         content: "Mật khẩu không được để trống",
//         confirm: () {
//           Get.back();
//           passwordFocusNode?.requestFocus();
//         },
//       );
//       return false;
//     }
//     return true;
//   }

//   void getLoopUserProfile(SocketStatus statusNeedCheck) async {
//     timerCheckProfile?.cancel();
//     timerCheckProfile =
//         Timer.periodic(const Duration(seconds: 1), (timer) async {
//       timeOut--;
//       if (kDebugMode) {
//         print("Reconnect socket");
//       }

//       if (timeOut == 0) {
//         if (statusNeedCheck.isConnected()) {
//           Get.context?.read<HomeBloc>().emitOnlineStatus();
//         }
//         timerCheckProfile?.cancel();
//         timeOut = 5;
//       }
//       final data = await _authRepository.getDataProfile();

//       if (data is DataSuccess && data.data != null) {
//         emitUser(data.data!);
//       }
//     });
//   }

//   void errorOnOff() {
//     emit(state.copyWith(
//       isErrorOnOff: true,
//     ));
//   }

//   void emitUser(UserModel user) {
//     emit(state.copyWith(
//       auth: user,
//     ));

//     AppData.instance.isDriverOnline = user.isDriverOnline;

//     if (AppData.instance.isDriverOnline) {
//       AppData.instance.isEmitOnline = false;
//       timerCheckProfile?.cancel();
//       timeOut = 10;
//     }
//   }

//   void getUserInfo() async {
//     emit(state.copyWith(
//       countRequest: 0,
//     ));
//     final data = await _authRepository.getDataProfile(isShowError: true);

//     if (data is DataSuccess && data.data != null) {
//       if (data.data?.driver?.available == false) {
//         emit(state.copyWith(
//           status: AuthStatusBloc.blocked,
//         ));
//         return;
//       }
//       emit(state.copyWith(
//         auth: data.data,
//       ));
//       AppData.instance.isDriverOnline = data.data!.isDriverOnline;

//       if (data.data?.driver?.isFaceVerified == 0 &&
//           Get.currentRoute != VillRoutes.introVerifyFace) {
//         Get.toNamed(VillRoutes.introVerifyFace);
//       }
//       injector<PrefManager>().userModel = data.data;
//       return;
//     }
//   }

//   void unauthenticated() {
//     timerCheckProfile?.cancel();
//     timeOut = 5;

//     injector<PrefManager>().logout();

//     emit(state.copyWith(status: AuthStatusBloc.unauthenticated));
//   }

//   void expiredToken() {
//     timerCheckProfile?.cancel();
//     timeOut = 12;
//     if (state.status == AuthStatusBloc.expiredToken) return;
//     if (state.status == AuthStatusBloc.unauthenticated) return;

//     emit(state.copyWith(status: AuthStatusBloc.expiredToken));
//   }

//   void logoutSubmit() async {
//     timerCheckProfile?.cancel();
//     timeOut = 12;

//     final data = await _authRepository.logout();

//     if (data is DataSuccess) {
//       injector<PrefManager>().logout();
//       emit(state.reset());
//     }
//     if (data is DataFailed) {
//       expiredToken();
//     }
//   }

//   void init() async {
//     emit(state.copyWith(
//       statusProvince: ProvinceStatus.loading,
//     ));
//     final data = await _authGetProvinceUseCase.execute(NoParam());

//     if (data is DataSuccess && data.data != null) {
//       emit(state.copyWith(
//         statusProvince: ProvinceStatus.loaded,
//         listProvince: data.data,
//       ));
//       try {
//         final province = injector<PrefManager>().province;
//         if (province != null) {
//           emit(state.copyWith(
//             selectionProvince: province,
//           ));
//         } else {
//           final getCurrentProvince = data.data?.firstWhere((element) =>
//               element.id.toString() == injector<PrefManager>().provinceId);
//           emit(state.copyWith(
//             selectionProvince: getCurrentProvince,
//           ));
//           injector<PrefManager>().province = getCurrentProvince;
//         }
//       } catch (e) {
//         log(" Lỗi khi lấy danh sách tỉnh thành: ${data.data} \n ${e.toString()}");
//       }
//     }
//     if (data is DataFailed) {
//       emit(state.copyWith(
//         statusProvince: ProvinceStatus.failure,
//         messageError: data.error?.message ?? AppErrorString.kRequestProvince,
//       ));
//     }
//   }

//   void loginProvinceChanged(ProvinceEntity province) async {
//     emit(state.copyWith(selectionProvince: province));
//     Get.back();
//   }

//   void setProvinceDev(ProvinceEntity province) async {
//     emit(state.copyWith(selectionProvince: province));
//   }

//   void searchProvinceChanged(String province) async {
//     //List<ProvinceEntity> searchList = [];

//     final searchText = removeDiacritics(province).toUpperCase();
//     final searchList = state.listProvince
//         .where(
//             (s) => removeDiacritics(s.name).toUpperCase().contains(searchText))
//         .toList();

//     emit(state.copyWith(
//       statusProvince: ProvinceStatus.initial,
//       isSearch: province != "",
//       listProvinceSearch: searchList,
//     ));
//   }

//   void loginEmailChanged(String email) async {
//     emit(
//       state.copyWith(
//         email: email,
//       ),
//     );
//   }

//   void hidePasswordChange() async {
//     emit(state.copyWith(isHidePassword: !state.isHidePassword));
//   }

//   void loginPasswordChanged(String password) async {
//     emit(state.copyWith(password: password));
//   }

//   setIsLoginWithPhone(bool isLoginWithPhone) {
//     emit(state.copyWith(isLoginWithPhone: isLoginWithPhone));
//   }

//   setPhone(String phone) {
//     emit(state.copyWith(phone: phone));
//   }

//   setEmail(String email) {
//     emit(state.copyWith(email: email));
//     emailController?.text = email;
//   }

//   setPassword(String password) {
//     emit(state.copyWith(password: password));
//     passwordController?.text = password;
//   }

//   getVehicleInUse() async {
//     if (state.vehicleType != null) {
//       return;
//     }
//     final data = await execute(() => _authRepository.getVehicleInUse());

//     data.when(
//       success: (data) {
//         emit(state.copyWith(vehicleType: data));
//         injector<PrefManager>().temperatures = data;
//       },
//     );
//   }

//   saveUserLoginDev(AccountDev accountDev) {
//     injector<PrefManager>().addListUserDev(accountDev);
//   }

//   getFraudDetection() async {
//     final data = await execute(
//         () => _frauDetectionCategoryRepository.getFraudDetection());

//     data.when(success: (data) {
//       emit(state.copyWith(
//         frauDetectionCategory: data,
//       ));
//     });
//   }
// }
