class Predictions {

  final String id;
  final String result;
  final String symptoms;
  final String date;


  Predictions({
    required this.result,
    required this.symptoms,
    required this.id,
    required this.date
  });

  static Predictions fromJasonPredictions(Map<String,dynamic> jason)=>
      Predictions(
          id:jason["id"]??"",
          symptoms: jason["symptoms"]??"",
          result: jason["result"]??"",
          date:jason["date"]??""
      )  ;
}

