import 'package:firebase_practice/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.brown[800],
            ),
            label: Text(
              'logout',
              style: TextStyle(
                color: Colors.brown[800]
              ),
            ),
            onPressed: () async {
              await AuthService().signOut();
            },
          )
        ],
      ),
    );
  }
}
