import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:email_validator/email_validator.dart';

import 'Utils.dart';

class Signup extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const Signup({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _emailController = TextEditingController();
  final _PassWordController = TextEditingController();
  final _nameController =TextEditingController();
  final _FamilynameController =TextEditingController();
  final _cinController=TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var user;
    List images = ["g.png", "t.png", "f.png"];
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    @override
    void dispose() {
      // TODO: implement dispose
      _emailController.dispose();
      _PassWordController.dispose();

      super.dispose();
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(children: [
            SizedBox(
              height: 100,
            ),
            Container(
              width: w,
              height: h,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/pexels-shvets-production-7194896.jpg"),
                    fit: BoxFit.cover //fit the container

                    ),
              ),
            ),
            Column(children: [
              Container(
                  width: w,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                            child: TextFormField(

                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? "Enter a Valid email"
                                  : null,
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "email",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 1)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 1))), ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                            child: TextFormField(
 obscureText: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && value.length < 6
                                      ? "Enter min 6 charaters"
                                      : null,
                              controller: _PassWordController,
                              decoration: InputDecoration(
                                hintText: "mot de passe",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 1)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 1))), ),
                          ),
                          SizedBox(height: 14,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                            child: TextFormField(


                              controller: _nameController,
                              decoration: InputDecoration(
                                  hintText: "nom",
                                  focusedBorder: OutlineInputBorder(

                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 1)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 1))),   ),
                          ),SizedBox(height: 14,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                            child: TextFormField(
                              controller: _FamilynameController,
                              decoration: InputDecoration(
                                 hintText: "prenom",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 1)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 1))), ),
                          ),SizedBox(height: 14,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                            child: TextFormField(
                               controller: _cinController,
                              decoration: InputDecoration(
                                hintText: "CIN",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 1)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 1))),
                            ),
                          ),SizedBox(height: 14,)
                        ]),
                  )),
              SizedBox(height: 18),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  signUp();

                },
                child: Container(
                  width: w / 2,
                  height: h * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: AssetImage("images/loginbtn.png"),
                        fit: BoxFit.cover //fit the container

                        ),
                  ),
                  child: Center(
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.05,
              ),
              RichText(
                text: TextSpan(
                  text: "Signup using the Folowing methods",
                  style: TextStyle(color: Colors.grey[500], fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              GestureDetector(
                child: RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: "Dont have an acount?",
                      style: TextStyle(color: Colors.grey[500], fontSize: 20),
                      children: [
                        TextSpan(
                            text: "Create",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold))
                      ]),
                ),
              )
            ]),
          ]),
        ));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _PassWordController.text.trim(),

      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    storeNewUser(_emailController.text.trim(),_nameController.text.trim(),_FamilynameController.text.trim(),int.parse(_cinController.text.trim()),);
    Navigator.of(context);
  }
  storeNewUser(String email,String name,String familyName,int cin,) async{
    var user =await FirebaseAuth.instance.currentUser!;
    CollectionReference qr = FirebaseFirestore.instance.collection('qr');

    FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'email':email,
      "nom":name,
      "Prenom":familyName,
      "Cin":cin,
      "id":user.uid,



    });
    qr.add({
      'email':email,
      "nom":name,
      "Prenom":familyName,
      "Cin":cin
    });


  }
}
