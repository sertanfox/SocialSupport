import 'package:examples/screens/informations.dart';
import 'package:examples/services/service_phone_number.dart';
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


  ///VALIDATE OTP FUTURE VOID
  //TODO: ADD FUNCTION VALIDATE OTP


  String _verificationCode;
  String _id;


  ///HERE IS THE LOGIN USER
  //TODO: ADD LOGIN USER

  @override
  void initState() {
    super.initState();
     ServicePhone().verifyPhone('+90${widget.phoneNum}');
    print('The phone number has been taken +90${widget.phoneNum}');

    // _loginUser();
  }


  @override
  Widget build(BuildContext context) {
   // phoneNumber = ModalRoute.of(context).settings.arguments;
    return _buildBodyContent(context);

    //   Scaffold(
    //   // debugShowCheckedModeBanner: false,
    //   body: Center(
    //     child: OtpScreen.withGradientBackground(
    //       topColor: Colors.blue[400],
    //       bottomColor: Colors.blue[300],
    //       otpLength: 6,
    //       validateOtp: validateOtp,
    //       routeCallback: moveToNextScreen,
    //       themeColor: Colors.white,
    //       titleColor: Colors.white,
    //       title: "Telefon Numarası Doğrulama",
    //       subTitle: "'e gönderilen doğrulama kodunu giriniz:",
    //     ),
    //   ),
    // );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Screen'),
        elevation:0,
      centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: EdgeInsets.only( left: 25.0, right: 25.0),
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
                          child:  Text('Login',style: TextStyle(fontSize: 19),) ),
                      onPressed: ()  {
                        try {
                           ServicePhone(verificationId: _id).signInWithOTP(_verificationCode, _id);
                        } catch (e){
                          print(' Error occured could not login ${e.toString()}');
                        }

                      }),
                ))

          ],
        ),
      )
    );
  }
}

