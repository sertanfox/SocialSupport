import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class Service {
  Future<void> signIn(AuthCredential authCred);
  Future <void> signInWithOTP(smsCode, verId);
}

class ServicePhone extends Service {
  String verificationId;
  bool codeSent;
  ServicePhone({@required this.verificationId});


 Future<void> signInWithOTP(smsCode, verId) async {
    AuthCredential authCred = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
   await signIn(authCred);
  }


  Future<void> signIn(AuthCredential authCred) async {
    await FirebaseAuth.instance.signInWithCredential(authCred);
  }


  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) async {
      await signIn(authResult);
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
        timeout: const Duration(seconds: 8),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
