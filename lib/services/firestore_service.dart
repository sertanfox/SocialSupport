import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examples/models/user.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveUser(User user) {
    return _db.collection('users').document(user.id).setData(user.tomap());
  }
}
