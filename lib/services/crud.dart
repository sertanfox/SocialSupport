import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods {
  /*
  bool isloggedIn() {
    if (FirebaseAuth.instance.currentUser() != null)
      return true;
    else
      return false;
  }
  */

  Future<void> addData(Map userData) async {
    print("İŞLEM TAMAM");
    Firestore.instance.collection('test').add(userData).catchError((e) {
      print(e);
    });
  }
}
