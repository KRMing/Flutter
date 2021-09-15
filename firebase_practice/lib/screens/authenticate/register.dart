import 'package:firebase_practice/screens/authenticate/sign_in_w_email.dart';
import 'package:firebase_practice/screens/home/home.dart';
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

  bool _buttonEnabled = true;

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
              AbsorbPointer(
                absorbing: !_buttonEnabled,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[400],
                  ),
                  onPressed: () async {
                    setState(() {
                      _buttonEnabled = false;
                    });
                    if (_key.currentState != null && _key.currentState!.validate()) {
                      dynamic result = await AuthService().registerWithEmailAndPassword(_email, _password);
                      if (result is String) {
                        _checkError(result);
                      }
                      else {
                        print(result.toString());
                        Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => Home()),
                              (r) => false,
                        );
                      }
                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
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

  void _checkError(String code) {
    String? _errorText;
    switch (code) {
      case 'invalid-email':
        _errorText = 'email format not valid';
        break;
      case 'user-disabled':
        _errorText = 'user email has been disabled';
        break;
      case 'user-not-found':
        _errorText = 'there is no registered user for that email';
        break;
      case 'wrong-password':
        _errorText = 'wrong password';
        break;
      case 'email-already-in-use':
        _errorText = 'this email is already registered';
        break;
      case 'operation-not-allowed':
        _errorText = 'the following email address is not enabled';
        break;
      case 'weak-password':
        _errorText = 'password is not strong enough';
        break;
      case 'too-many-requests':
        _errorText = 'access temporarily blocked due to too many requests';
        break;
      default:
        print('uncaught case: $code, please debug');
        break;
    }
    _rebuild(_errorText);
  }

  void _rebuild(String? errorText) {
    if (errorText != null) {
      setState(() {
        _error = errorText;
      });
    }

    setState(() {
      _buttonEnabled = true;
    });
  }
}
