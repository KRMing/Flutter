import 'package:firebase_practice/screens/authenticate/authenticate.dart';
import 'package:firebase_practice/screens/home/home.dart';
import 'package:firebase_practice/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<WrapperBloc, WrapperState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Authenticate(),
    );
  }
}
