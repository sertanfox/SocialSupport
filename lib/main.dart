import 'package:examples/components/validators.dart';
import 'package:examples/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:examples/screens/phonenumber.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget with Validators {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[400],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: PhoneNumber.routeName,
      routes: routes,
    );
  }
}
