import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // opcional: salvar perfil

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login
  Future<User?> signIn(String email, String pass) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
    return cred.user;
  }

  // Cadastro
  Future<User?> signUp(String email, String pass) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );

    // (Opcional) salva um documento de perfil no Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(cred.user!.uid)
        .set({
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return cred.user;
  }

  Future<void> signOut() => _auth.signOut();
}
