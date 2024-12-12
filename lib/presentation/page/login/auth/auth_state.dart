


// // ignore_for_file: public_member_api_docs, sort_constructors_first
// part of 'auth_bloc.dart';

// enum AuthStatusBloc {
//   initial,
//   loading,
//   loaded,
//   authenticated,
//   unauthenticated,
//   blocked,
//   expiredToken,
//   failure
// }

// enum ProvinceStatus { initial, loading, loaded, failure, selected }

// class AuthState extends Equatable {
//   final UserModel? auth;
//   final Temperatures? vehicleType;
//   final String email;
//   final String phone;
//   final String password;
//   final String messageError;
//   final AuthStatusBloc status;
//   final ProvinceStatus statusProvince;
//   final bool isHidePassword;
//   final bool isErrorOnOff;
//   final List<ProvinceEntity> listProvince;
//   final List<ProvinceEntity> listProvinceSearch;
//   final ProvinceEntity? selectionProvince;
//   final bool isOnline;
//   final bool isSearch;
//   final bool isLoginWithPhone;

//   final FrauDetectionCategory? frauDetectionCategory;

//   const AuthState({
//     this.auth,
//     this.email = "",
//     this.phone = "",
//     this.password = "",
//     this.messageError = "",
//     this.listProvince = const [],
//     this.listProvinceSearch = const [],
//     this.status = AuthStatusBloc.initial,
//     this.statusProvince = ProvinceStatus.initial,
//     this.isHidePassword = true,
//     this.selectionProvince,
//     this.isOnline = false,
//     this.isSearch = false,
//     this.isErrorOnOff = false,
//     this.isLoginWithPhone = false,
//     this.vehicleType,
//     this.frauDetectionCategory,
//   });

//   AuthState reset() {
//     return const AuthState(
//       status: AuthStatusBloc.unauthenticated,
//       statusProvince: ProvinceStatus.initial,
//       auth: null,
//       email: "",
//       phone: "",
//       password: "",
//       messageError: "",
//       isHidePassword: true,
//       listProvince: [],
//       listProvinceSearch: [],
//       selectionProvince: null,
//       isOnline: false,
//       isSearch: false,
//       isErrorOnOff: false,
//       isLoginWithPhone: false,
//       vehicleType: null,
//     );
//   }

//   AuthState copyWith({
//     UserModel? auth,
//     Temperatures? vehicleType,
//     String? email,
//     String? phone,
//     String? password,
//     String? messageError,
//     AuthStatusBloc? status,
//     ProvinceStatus? statusProvince,
//     bool? isHidePassword,
//     bool? isErrorOnOff,
//     int? countRequest,
//     List<ProvinceEntity>? listProvince,
//     List<ProvinceEntity>? listProvinceSearch,
//     ProvinceEntity? selectionProvince,
//     bool? isOnline,
//     bool? isSearch,
//     bool? isLoginWithPhone,
//     FrauDetectionCategory? frauDetectionCategory,
//   }) {
//     return AuthState(
//       auth: auth ?? this.auth,
//       vehicleType: vehicleType ?? this.vehicleType,
//       email: email ?? this.email,
//       phone: phone ?? this.phone,
//       password: password ?? this.password,
//       messageError: messageError ?? this.messageError,
//       status: status ?? this.status,
//       statusProvince: statusProvince ?? this.statusProvince,
//       isHidePassword: isHidePassword ?? this.isHidePassword,
//       isErrorOnOff: isErrorOnOff ?? this.isErrorOnOff,
//       listProvince: listProvince ?? this.listProvince,
//       listProvinceSearch: listProvinceSearch ?? this.listProvinceSearch,
//       selectionProvince: selectionProvince ?? this.selectionProvince,
//       isOnline: isOnline ?? this.isOnline,
//       isSearch: isSearch ?? this.isSearch,
//       isLoginWithPhone: isLoginWithPhone ?? this.isLoginWithPhone,
//       frauDetectionCategory:
//           frauDetectionCategory ?? this.frauDetectionCategory,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         auth,
//         status,
//         statusProvince,
//         isHidePassword,
//         email,
//         phone,
//         messageError,
//         password,
//         selectionProvince,
//         listProvince,
//         listProvinceSearch,
//         isOnline,
//         isSearch,
//         isErrorOnOff,
//         isLoginWithPhone,
//         vehicleType,
//         frauDetectionCategory,
//       ];
// }
