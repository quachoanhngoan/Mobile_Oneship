import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepositoy {
  init();

  Future loginWithPhone(String phone);

  Future loginWithOTP(String verificationId, String smsCode);
}

class AuthRepositoryImpl extends AuthRepositoy {
  late final FirebaseAuth _auth;

  @override
  init() {
    _auth = FirebaseAuth.instance;
  }

  @override
  Future loginWithPhone(String phone) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          String? idToken = await userCredential.user?.getIdToken();
          log("idToken: $idToken");
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            log('The provided phone number is not valid.');
          } else {
            log('The provided phone number is error: $e');
          }
        },
        codeSent: (verificationId, resendToken) {
          log("Verification ID: $verificationId and $resendToken");
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  @override
  Future loginWithOTP(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      String? idToken = await userCredential.user?.getIdToken();
      log("idToken: $idToken");
    } catch (e) {}
  }
}
