import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetUserData extends StatefulWidget {
  final String documentId;



  GetUserData({required this.documentId});


  @override
  State<GetUserData> createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
           // d{'qruser']="${data["email"]}-${data["nom"]}-${data['Prenom']}-${data['Cin']}-$formattedDate";}

            return Text(
                "${data["email"]}-${data["nom"]}-${data['Prenom']}-${data['Cin']}-$formattedDate");
          }
          return Text('loading');
        }));

    return Container();
  }
}
