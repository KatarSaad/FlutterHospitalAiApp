import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/adminPanel.dart';
import 'package:untitled3/qrs.dart';

import 'Users.dart';
class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.4),
      body:StreamBuilder<List<Qr>>(
        stream: readQrs(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return Text("Something is wrong${snapshot.error}");}

          else if (snapshot.hasData) {
            final users = snapshot.data!;

           // _qr="${user.email}-${user.nom}-${user.prenom}-${user.Cin}-$formattedDate";



            return ListView(
              shrinkWrap: true,
              children:  users.map(buildQr).toList(),
            );
          }
          else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
  Widget buildQr(Qr qrs) => GestureDetector(
    onTap:(){ Get.to(Admin(id: qrs.id ,));},
    child:  Card(
      color: Colors.white.withOpacity(0.5),
      elevation: 5,
      child: ListTile(
        leading: Icon(Icons.healing),
        title: Text(qrs.qruser),
        subtitle: Text(qrs.id),
        trailing: Text(qrs.date),
      ),
    ),
  );

  Future<Qr?> readQr()async{
    final docUser=FirebaseFirestore.instance.collection("qr").doc();
    final snapshot=await docUser.get();
    if (snapshot.exists){
      return Qr.fromJasonQr(snapshot.data()!);
    }

  }
  Stream<List<Qr>> readQrs() => FirebaseFirestore.instance
      .collection("qr")
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Qr.fromJasonQr(doc.data())).toList());

}
