import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFiestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getFirebaseFirestore() {
    return _firestore;
  }
}
