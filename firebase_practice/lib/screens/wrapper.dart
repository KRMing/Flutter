import 'package:firebase_practice/screens/authenticate/authenticate.dart';
import 'package:firebase_practice/screens/home/home.dart';
import 'package:firebase_practice/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool? _isUserSignedIn;

  @override
  void initState() {
    super.initState();
    _isUserSignedIn = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WrapperBloc, WrapperState>(
      listener: (context, state) => _onStateChange(state),
      child: childWidget()
    );
  }

  Widget childWidget() {
    assert(_isUserSignedIn != null);
    return _isUserSignedIn! ? Home() : Authenticate();
  }

  void _onStateChange(WrapperState state) {
    if (state is UserSignedInState) {
      setState(() {
        _isUserSignedIn = true;
      });
    }
    else if (state is UserSignedOutState) {
      setState(() {
        _isUserSignedIn = false;
      });
    }
    else {
      print('undefined');
    }
  }
}
