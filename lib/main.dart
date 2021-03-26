import 'package:examples/routes.dart';
import 'package:examples/screens/group_chat.dart';
import 'package:examples/screens/informations.dart';
import 'package:examples/screens/phonenumber.dart';
import 'package:examples/screens/search_group.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue[400],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: PhoneNumber.routeName,
        routes: routes,
      ),
    );
  }
}
