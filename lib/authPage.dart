import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled3/signin.dart';
import 'package:untitled3/sinup.dart';
class AuthPase extends StatefulWidget {
  const AuthPase({Key? key}) : super(key: key);

  @override
  State<AuthPase> createState() => _AuthPaseState();
}

class _AuthPaseState extends State<AuthPase> {
  bool isLogin=true;

  @override
  Widget build(BuildContext context)=> isLogin?SignIn(onClickedSignup: toggle,):Signup(onClickedSignIn: toggle,);
  void toggle()=> setState(()=>isLogin=!isLogin);

  }


