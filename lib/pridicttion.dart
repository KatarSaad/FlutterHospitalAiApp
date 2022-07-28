import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:untitled3/ListOfPredictions.dart';
import 'dart:convert';

import 'package:untitled3/predictions.dart';

class Pridict extends StatefulWidget {
  const Pridict({Key? key}) : super(key: key);

  @override
  State<Pridict> createState() => _PridictState();
}

class _PridictState extends State<Pridict> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  String name = "";
  final user = FirebaseAuth.instance.currentUser!;
  List<String> symptoms = [
    'itching',
    'skin_rash',
    'nodal_skin_eruptions',
    'continuous_sneezing',
    'shivering',
    'chills',
    'joint_pain',
    'stomach_pain',
    'acidity',
    'ulcers_on_tongue',
    'muscle_wasting',
    'vomiting',
    'burning_micturition',
    'spotting_ urination',
    'fatigue',
    'weight_gain',
    'anxiety',
    'cold_hands_and_feets',
    'mood_swings',
    'weight_loss',
    'restlessness',
    'lethargy',
    'patches_in_throat',
    'irregular_sugar_level',
    'cough',
    'high_fever',
    'sunken_eyes',
    'breathlessness',
    'sweating',
    'dehydration',
    'indigestion',
    'headache',
    'yellowish_skin',
    'dark_urine',
    'nausea',
    'loss_of_appetite',
    'pain_behind_the_eyes',
    'back_pain',
    'constipation',
    'abdominal_pain',
    'diarrhoea',
    'mild_fever',
    'yellow_urine',
    'yellowing_of_eyes',
    'acute_liver_failure',
    'fluid_overload',
    'swelling_of_stomach',
    'swelled_lymph_nodes',
    'malaise',
    'blurred_and_distorted_vision',
    'phlegm',
    'throat_irritation',
    'redness_of_eyes',
    'sinus_pressure',
    'runny_nose',
    'congestion',
    'chest_pain',
    'weakness_in_limbs',
    'fast_heart_rate',
    'pain_during_bowel_movements',
    'pain_in_anal_region',
    'bloody_stool',
    'irritation_in_anus',
    'neck_pain',
    'dizziness',
    'cramps',
    'bruising',
    'obesity',
    'swollen_legs',
    'swollen_blood_vessels',
    'puffy_face_and_eyes',
    'enlarged_thyroid',
    'brittle_nails',
    'swollen_extremeties',
    'excessive_hunger',
    'extra_marital_contacts',
    'drying_and_tingling_lips',
    'slurred_speech',
    'knee_pain',
    'hip_joint_pain',
    'muscle_weakness',
    'stiff_neck',
    'swelling_joints',
    'movement_stiffness',
    'spinning_movements',
    'loss_of_balance',
    'unsteadiness',
    'weakness_of_one_body_side',
    'loss_of_smell',
    'bladder_discomfort',
    'foul_smell_of urine',
    'continuous_feel_of_urine',
    'passage_of_gases',
    'internal_itching',
    'toxic_look_(typhos)',
    'depression',
    'irritability',
    'muscle_pain',
    'altered_sensorium',
    'red_spots_over_body',
    'belly_pain',
    'abnormal_menstruation',
    'dischromic _patches',
    'watering_from_eyes',
    'increased_appetite',
    'polyuria',
    'family_history',
    'mucoid_sputum',
    'rusty_sputum',
    'lack_of_concentration',
    'visual_disturbances',
    'receiving_blood_transfusion',
    'receiving_unsterile_injections',
    'coma',
    'stomach_bleeding',
    'distention_of_abdomen',
    'history_of_alcohol_consumption',
    'fluid_overload',
    'blood_in_sputum',
    'prominent_veins_on_calf',
    'palpitations',
    'painful_walking',
    'pus_filled_pimples',
    'blackheads',
    'scurring',
    'skin_peeling',
    'silver_like_dusting',
    'small_dents_in_nails',
    'inflammatory_nails',
    'blister',
    'red_sore_around_nose',
    'yellow_crust_ooze'
  ];

  String final_response = "";
  final _formkey = GlobalKey<FormState>();

  Future<void> _savingData() async {
    final validation = _formkey.currentState?.validate();
    if (!validation!) {
      return;
    }
    _formkey.currentState?.save();
  }

  DropdownMenuItem<String> buidMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );
  String? value;

  String? value1;

  String? value2;

  String? value3;

  String? value4;

  _showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: SingleChildScrollView(
        child: Stack(
          children:[
            Container(
              width: w,
              height: h ,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/augustine-wong-3Om4DHcaAc0-unsplash.jpg"),
                    fit: BoxFit.cover //fit the container

                ),
              ),
            ), Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  // decoration: BoxDecoration(color: Colors.orange),
                  child: OutlineButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: Text("Prediction Maladie",style: TextStyle(fontSize: 25),),
                    icon: Icon(Icons.find_in_page_outlined),
                    onPressed: () async {
                      if (value != null &&
                          value2 != null &&
                          value3 != null &&
                          value4 != null) {
                        final url = "http://10.0.2.2:5000/name";

                        var uri = Uri.parse(url);
                        final response = await http.post(uri,
                            body: json.encode({
                              "name": [value, value1, value2, value3, value4]
                            }));
                        Timer(Duration(seconds: 2), () {});

                        final responser = await http.get(uri);
                        final decoded = json.decode(responser.body.toString())
                            as Map<String, dynamic>;
                        print(decoded.toString() +
                            "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
                        setState(() {
                          final_response = decoded['name'];
                        });
                        print(response);
                        addPrediction();
                      } else {
                        _showToast("Remplir tous les Symptommes");
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  final_response,
                  style: TextStyle(fontSize: 26),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        "Symptome 1",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 3),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton(
                            value: value,
                            items: symptoms.map(buidMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => this.value = value as String?)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        "Symptome 2",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 3),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton(
                            value: value1,
                            items: symptoms.map(buidMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => this.value1 = value as String?)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        "Symptome 3",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 3),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton(
                            value: value2,
                            items: symptoms.map(buidMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => this.value2 = value as String?)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        "Symptome 4",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 3),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton(
                            value: value3,
                            items: symptoms.map(buidMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => this.value3 = value as String?)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        "Symptome 5",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 3),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton(
                            value: value4,
                            items: symptoms.map(buidMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => this.value4 = value as String?)),
                      ),
                    ],
                  ),
                ),SizedBox(height: 50,), Container(
    // decoration: BoxDecoration(color: Colors.orange),
    child: OutlineButton.icon(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    label: Text("List des Predictions",style: TextStyle(fontSize: 25),),
    icon: Icon(Icons.find_in_page_outlined), onPressed: () { Get.to(PredictionList()); },))


    ],
            ),
          )],
        ),
      ),
    );
  }

  Widget buildPrediction(Predictions rv) => GestureDetector(
        onTap: () {},
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
      .collection("users")
      .doc(user.uid)
      .collection("predictions")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Predictions.fromJasonPredictions(doc.data()))
          .toList());

  Future addPrediction() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    CollectionReference addIt =
        await FirebaseFirestore.instance.collection("users");
    addIt.doc(user.uid).collection("predictions").doc().set({
      "id": user.uid,
      "result": final_response.toString(),
      "symptoms":
          "Symptoms:${value} , ${value1} , ${value2} , ${value3} , ${value4} ,",
      "date": formattedDate
    });
  }
}
