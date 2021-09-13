import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anon
  Future signInAnon() async {
    try {
      await _auth.signInAnonymously();
    }
    catch (e) {

    }
  }

  // sign in with email & password

  // register with email & password

  // sign out
}