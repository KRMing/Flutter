import 'package:firebase_practice/di/injector.dart';
import 'package:firebase_practice/screens/authenticate/register.dart';
import 'package:firebase_practice/screens/authenticate/sign_in.dart';
import 'package:firebase_practice/screens/home/home.dart';
import 'package:firebase_practice/services/auth.dart';
import 'package:flutter/material.dart';

class SignInEmail extends StatefulWidget {
  const SignInEmail({Key? key}) : super(key: key);

  @override
  _SignInEmailState createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
  String _email = '';
  String _password = '';
  String _error = '';
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Brew Crew'),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Register()),
                (r) => r.isFirst,
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => (val != null && val.isEmpty) ? 'Enter an email' : null,
                onChanged: (val) {
                  _email = val;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => (val != null && val.length < 6) ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val) {
                  _password = val;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[400],
                ),
                onPressed: () async {
                  print(_key.currentState);
                  if (_key.currentState != null && _key.currentState!.validate()) {
                    print('valid');
                    dynamic result = AuthService().signInWithEmailAndPassword(_email, _password);
                    if (result == null) {
                      setState(() {
                        _error = 'please supply a valid email';
                      });
                    }
                    else {
                      print(result);
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => Home()),
                        (r) => false,
                      );
                    }
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
