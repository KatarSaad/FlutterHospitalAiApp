import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class GetUserData1 extends StatelessWidget {
  final String documentId;
  late String  result="";


  GetUserData1({required this.documentId});
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    CollectionReference users=FirebaseFirestore.instance.collection('users');
    Map <String,dynamic> data  =users.doc(documentId).get() as Map <String,dynamic>;
    result =  "${data["email"]}-${data["nom"]}-${data['Prenom']}-${data['Cin']}-$formattedDate";
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('classes').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       return Text("");
      },
    );
    return Container();
  }
}
