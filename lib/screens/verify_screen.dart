import 'package:examples/screens/informations.dart';
import 'package:examples/screens/service_phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';

class Verify_Screen extends StatefulWidget {
  String phoneNum ;

  Verify_Screen({Key key, this.phoneNum}) : super(key: key);
  static String routeName = "/verify_screen";

  @override
  _Verify_ScreenState createState() => _Verify_ScreenState();
}

class _Verify_ScreenState extends State<Verify_Screen> {
  // ignore: missing_return
  Future<String> validateOtp(String otp) async {
    try {
      await Future.delayed(Duration(milliseconds: 2000));
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.getCredential(
              verificationId: _verificationCode, smsCode: otp))
          .then((value) async {
        if (value.user != null) {
          Navigator.of(context).pushNamed(Verify_Screen.routeName);
        }
      });
    } catch (e) {
      FocusScope.of(context).unfocus();
    }
  }

  void moveToNextScreen(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Informations()));
  }

  @override
  void initState() {
    super.initState();
    print('The phone number has been taken ${widget.phoneNum}');
   // _loginUser();
  }



  String _verificationCode;
  String _id;


  _loginUser() async {
    // ignore: unnecessary_statements
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
        phoneNumber: '+90${widget.phoneNum}',
        timeout: Duration(seconds: 120),
        verificationCompleted: (AuthCredential credential) async {
          await _auth.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              Navigator.of(context).pushNamed(Verify_Screen.routeName);
            }
          });
          //FirebaseUser user = result.user;
        },
        verificationFailed: (AuthException exception) {
          print("PROBLEM IS HERE: ");
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          setState(() {
            _verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationCode = verificationId;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
   // phoneNumber = ModalRoute.of(context).settings.arguments;
    return _buildBodyContent();

      Scaffold(
      // debugShowCheckedModeBanner: false,
      body: Center(
        child: OtpScreen.withGradientBackground(
          topColor: Colors.blue[400],
          bottomColor: Colors.blue[300],
          otpLength: 6,
          validateOtp: validateOtp,
          routeCallback: moveToNextScreen,
          themeColor: Colors.white,
          titleColor: Colors.white,
          title: "Telefon Numarası Doğrulama",
          subTitle: "'e gönderilen doğrulama kodunu giriniz:",
        ),
      ),
    );
  }

  Widget _buildBodyContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Screen'),
        elevation:0,
      centerTitle: true,
      ),
      body: Center(
        child: Column(
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
                child: RaisedButton(
                    child: Center(
                        child:  Text('Login') ),
                    onPressed: () async {
                      try {
                        await  ServicePhone().signInWithOTP(_verificationCode, _id);
                      } catch (e){
                        print(' Error occured could not login ${e.toString()}');
                      }

                    }))

          ],
        ),
      )
    );
  }
}

class SuccessfulOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            "Numara doğrulamanız başarılı",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
