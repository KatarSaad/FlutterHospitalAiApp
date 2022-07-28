import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:flutter/material.dart';
class UserManagement{
  
   storeNewUser(user,context) async{
    var user =await FirebaseAuth.instance.currentUser!;
    
    FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'email':user.email,"uid":user.uid


    });
  }
  
  
}