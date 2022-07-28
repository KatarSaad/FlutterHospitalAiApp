class Appointmnet {

  final String cost;
  final String clasification;
  final String id;


  Appointmnet({
    required this.clasification,
    required this.cost,
    required this.id
  });

  static Appointmnet fromJasonRendezvous(Map<String,dynamic> jason)=>
      Appointmnet(
          id:jason["id"]??"",
          cost: jason["cost"]??"",
          clasification: jason["rendezvouss"]??""
      )  ;
}

