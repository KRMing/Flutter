import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser? _firebaseUserFromUser(User? user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }

  Stream<FirebaseUser?> get user {
    // return _auth.authStateChanges().map((user) => _firebaseUserFromUser(user));
    return _auth.authStateChanges().map(_firebaseUserFromUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _firebaseUserFromUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password

  // register with email & password

  // sign out
}