import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_tracker/features/profile/data/models/user_response.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;
  String? get uid => _auth.currentUser?.uid;

  // 🔐 LOGIN
  Future<User?> login({required String email, required String password}) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  // 📝 REGISTER
  Future<User?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = result.user!.uid;

      // 2️⃣ Create user in Firestore
      await _db.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'createdAt': Timestamp.now(),
        'isPremium': false,
      });

      await _auth.signOut();
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  // 🚪 LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  // 🔁 RESET PASSWORD
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // ❗ Error Handler
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password';
      case 'email-already-in-use':
        return 'Email already registered';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      default:
        return 'Authentication failed';
    }
  }

  Future<UserResponse?> getUserProfile() async {
    try {
      final doc = await _db.collection('users').doc(uid).get();

      if (doc.exists) {
        return UserResponse.fromFirestore(doc.data()!);
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
    return null;
  }

  //
  // Future<Map<String, dynamic>?> getUserProfile() async {
  //   if (currentUser == null) return null;
  //
  //   final doc = await _db.collection('users').doc(currentUser?.uid).get();
  //
  //   return doc.data();
  // }
}
