import 'package:firebase_practice/screens/authenticate/register.dart';
import 'package:firebase_practice/screens/authenticate/sign_in_w_email.dart';
import 'package:firebase_practice/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Sign in anon'),
              onPressed: () async {
                dynamic result = await AuthService().signInAnon();
                if (result == null) {
                  print('error signing in');
                }
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign in'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignInEmail()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
