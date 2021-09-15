import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/models/user.dart';
import 'package:firebase_practice/services/database.dart';

class AuthService {
  AuthService._();

  static final AuthService _instance = AuthService._();
  factory AuthService() => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser? _firebaseUserFromUser(User? user) {
    return (user != null) ? FirebaseUser(uid: user.uid) : null;
  }

  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges().map((user) => _firebaseUserFromUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      print(result.credential.runtimeType);
      return _firebaseUserFromUser(result.user);
    }
    on FirebaseAuthException catch (e) {
      print(e.code);
      return e.code;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _firebaseUserFromUser(result.user);
    }
    on FirebaseAuthException catch (e) {
      print('exception');
      print(e.code);
      return e.code;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await DatabaseService(uid: result.user?.uid).updateUserData('0', 'new crew member', 100);
      return _firebaseUserFromUser(result.user);
    }
    on FirebaseAuthException catch (e) {
      print(e.code);
      return e.code;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    on FirebaseAuthException catch (e) {
      print(e.code);
      return e.code;
    }
  }
}