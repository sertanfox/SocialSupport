import 'package:examples/screens/informations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Verify_Screen extends StatefulWidget {
  String phoneNum;

  Verify_Screen({Key key, this.phoneNum}) : super(key: key);
  static String routeName = "/verify_screen";

  @override
  _Verify_ScreenState createState() => _Verify_ScreenState();
}

class _Verify_ScreenState extends State<Verify_Screen> {
  String verificationId;
  String _verificationCode;
  bool codeSent;

  @override
  void initState() {
    super.initState();
    verifyPhone('+90${widget.phoneNum}');
    print('The phone number has been taken +90${widget.phoneNum}');
  }

  ///Function to Sign in with OTP. Once the Sms Code is taken
  Future<bool> signInWithOTP(smsCode, verId) async {
    PhoneAuthCredential authCred =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    await signIn(authCred);
  }

  /// Sign In to Firebase with AuthCredential
  Future<void> signIn(AuthCredential authCred) async {
    await FirebaseAuth.instance.signInWithCredential(authCred);
  }

  /// This function verifies the phone then set the sms code
  Future<void> verifyPhone(String phoneNo) async {
    print('Phone number reached verifyphone $phoneNo');
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      return signIn(authResult);
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
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyContent(context);
  }

  ///=== === === === === === === === === === === === === === === === ===

  Widget _buildBodyContent(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Verify Screen'),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter OTP'),
                    onChanged: (val) {
                      setState(() {
                        this._verificationCode = val;
                      });
                    },
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Container(
                    height: 45,
                    child: ElevatedButton(
                        child: Center(
                            child: Text(
                          'Login',
                          style: TextStyle(fontSize: 19),
                        )),
                        onPressed: () async {
                          bool isSignedIn = await signInWithOTP(
                              _verificationCode, verificationId);
                          if (isSignedIn != null && isSignedIn != false) {
                            Navigator.pushReplacementNamed(
                                context, Informations.routeName);
                          } else {
                            return Center(
                                child: Text('Error while Login',
                                    style: TextStyle(fontSize: 17)));
                          }
                        }),
                  ))
            ],
          ),
        ));
  }
}
