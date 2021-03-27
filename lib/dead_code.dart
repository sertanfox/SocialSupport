
///____________________________________________________\
///LOGIN USER

// _loginUser() async {
//   // ignore: unnecessary_statements
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   await _auth.verifyPhoneNumber(
//       phoneNumber: '+90${widget.phoneNum}',
//       timeout: Duration(seconds: 120),
//       verificationCompleted: (AuthCredential credential) async {
//         await _auth.signInWithCredential(credential).then((value) async {
//           if (value.user != null) {
//             Navigator.of(context).pushNamed(Verify_Screen.routeName);
//           }
//         });
//         //FirebaseUser user = result.user;
//       },
//       verificationFailed: (AuthException exception) {
//         print("PROBLEM IS HERE: ");
//       },
//       codeSent: (String verificationId, [int forceResendingToken]) {
//         setState(() {
//           _verificationCode = verificationId;
//         });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         setState(() {
//           _verificationCode = verificationId;
//         });
//       });
// }


///________________________________________________________
///VALIDATE Ordimport 'package:flutter/cupertino.dart';
// eredTraversalPolicyFuture<String> validateOtp(String otp) async {
//   try {
//     await Future.delayed(Duration(milliseconds: 2000));
//     await FirebaseAuth.instance
//         .signInWithCredential(PhoneAuthProvider.getCredential(
//         verificationId: _verificationCode, smsCode: otp))
//         .then((value) async {
//       if (value.user != null) {
//         Navigator.of(context).pushNamed(Verify_Screen.routeName);
//       }
//     });
//   } catch (e) {
//     FocusScope.of(context).unfocus();
//   }
// }
//
// void moveToNextScreen(context) {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => Informations()));
// }