import 'package:oneship_merchant_app/presentation/data/model/user/user_model.dart';

class RegisterArg {
  final bool isRegister;
  // final bool isChangePass;
  final UserM? userData;

  RegisterArg(
      {
      // this.isChangePass = false,
      this.isRegister = false,
      this.userData});
}
