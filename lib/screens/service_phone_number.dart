import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class Service {
  Future<void> signIn(AuthCredential authCreds);
  Future <void> signInWithOTP(smsCode, verId);
}

class ServicePhone extends Service {
  String verificationId;
  bool codeSent;
  ServicePhone({@required this.verificationId});


 Future<void> signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }


  Future<void> signIn(AuthCredential authCreds) async {
    await FirebaseAuth.instance.signInWithCredential(authCreds);
  }


  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
        this.codeSent = true;

    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
