
class Qr{

  final String qruser;
  final String date;
  final String id;


  Qr({
    required this.qruser,
    required this.date,
    required this.id
});

static Qr fromJasonQr (Map<String,dynamic> jason)=>
    Qr(
      id:jason["id"]??"",
      qruser: jason["qruser"]??"",
      date: jason["date"]??""
    )  ;
}
