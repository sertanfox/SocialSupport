import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class Service {
  Future<void> signIn(AuthCredential authCred);
  Future <void> signInWithOTP(smsCode, verId);
  Future<void> verifyPhone(String phoneNo);
}

class ServicePhone extends Service {
  String verificationId;
  bool codeSent;
  ServicePhone({@required this.verificationId});

@override
 Future<void> signInWithOTP(smsCode, verId) async {
    AuthCredential authCred = PhoneAuthProvider.credential(
        verificationId: verId, smsCode: smsCode);
   await signIn(authCred);
  }

  @override
  Future<void> signIn(AuthCredential authCred) async {
    await FirebaseAuth.instance.signInWithCredential(authCred);
  }

  @override
  Future<void> verifyPhone(String phoneNo) async {
  print('Phone number reached verifyphone $phoneNo');
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
       signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}