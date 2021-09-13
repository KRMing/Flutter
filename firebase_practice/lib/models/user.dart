class FirebaseUser {
  final String? uid;

  FirebaseUser({this.uid});

  @override
  String toString() {
    return 'FirebaseUser{uid: $uid}';
  }
}