import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/predictions.dart';
class PredictionList extends StatefulWidget {
  const PredictionList({Key? key}) : super(key: key);

  @override
  State<PredictionList> createState() => _PredictionListState();
}

class _PredictionListState extends State<PredictionList> {
  var user=FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder<List<Predictions>>(
        stream:readPredictions(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return Text("Something is wrong${snapshot.error}");}

          else if (snapshot.hasData) {
            final usersA = snapshot.data!;



            return ListView(
              shrinkWrap: true,
              children:  usersA.map(buildPrediction).toList(),
            );
          }
          else {
            return Center(child: CircularProgressIndicator(),);
          }
        },

      ),
    );
  }
  Widget buildPrediction(Predictions rv) => GestureDetector(
    onTap:(){ },
    child: Card(
      color: Colors.white.withOpacity(0.5),
      elevation: 5,
      child: ListTile(
        leading: Icon(Icons.healing),
        title: Text(rv.result),
        subtitle: Text(rv.symptoms),
        trailing: Text(rv.date),
      ),
    ),
  );


  Stream<List<Predictions>> readPredictions() => FirebaseFirestore.instance
      .collection("users").doc(user.uid).collection("predictions")
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Predictions.fromJasonPredictions(doc.data())).toList());

}
