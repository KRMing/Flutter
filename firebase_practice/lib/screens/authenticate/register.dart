import 'package:firebase_practice/di/injector.dart';
import 'package:firebase_practice/screens/authenticate/sign_in.dart';
import 'package:firebase_practice/screens/authenticate/sign_in_w_email.dart';
import 'package:firebase_practice/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register for Brew Crew'),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignInEmail()),
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
                obscureText: true,
                validator: (val) => (val != null && val.length < 6) ? 'Enter a password 6+ chars long' : null,
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
                  if (_key.currentState != null && _key.currentState!.validate()) {
                    dynamic result = AuthService().registerWithEmailAndPassword(_email, _password);
                    if (result == null) {
                      setState(() {
                        _error = 'please supply a valid email';
                      });
                    }
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Text(
                _error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
