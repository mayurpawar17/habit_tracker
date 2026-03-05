import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getUserProfile() async {

    final uid = _auth.currentUser!.uid;

    final doc = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    return doc.data()!;
  }
}