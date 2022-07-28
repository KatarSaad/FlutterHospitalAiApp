import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/appointments.dart';

class Historic extends StatefulWidget {
  const Historic({Key? key}) : super(key: key);

  @override
  State<Historic> createState() => _HistoricState();
}

class _HistoricState extends State<Historic> {
  var user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body:StreamBuilder<List<Appointmnet>>(
        stream:readAppointments(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return Text("Something is wrong${snapshot.error}");}

          else if (snapshot.hasData) {
            final usersA = snapshot.data!;



            return ListView(
              shrinkWrap: true,
              children:  usersA.map(buildRendezvous).toList(),
            );
          }
          else {
            return Center(child: CircularProgressIndicator(),);
          }
        },

      ),



    )

    ;
  }


  Future getPayments() async {
    var a = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid).collection("RendezVous").doc().get();

    return a;
  }


  Widget buildRendezvous(Appointmnet rv) => GestureDetector(
    onTap:(){ },
    child: Card(
      color: Colors.white.withOpacity(0.5),
      elevation: 5,
      child: ListTile(
        leading: Icon(Icons.healing),
        title: Text(rv.clasification),
        subtitle: Text(rv.cost),
        trailing: Icon(Icons.medical_services),
      ),
    ),
  );





  Stream<List<Appointmnet>> readAppointments() => FirebaseFirestore.instance
      .collection("users").doc(user.uid).collection("rendezVous")
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Appointmnet.fromJasonRendezvous(doc.data())).toList());
  }
