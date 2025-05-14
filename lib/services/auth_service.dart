import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String pass) async {
    final cred = await _auth.signInWithEmailAndPassword(
        email: email, password: pass);
    return cred.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
