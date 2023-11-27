class Belanja{
  late int? belanjaId;
  late int? noteId;
  late String? img;
  late String? name;
  late int? quantity;
  late int? harga;


  Belanja({this.belanjaId, this.noteId, this.name, this.img, this.quantity, this.harga});

  Belanja.formMap(dynamic ojb){
    this.belanjaId = ojb['belanjaId'];
    this.noteId = ojb['noteId'];
    this.name = ojb['name'];
    this.img = ojb['img'];
    this.quantity = ojb['quantity'];
    this.harga = ojb['harga'];
  }

  Map<String, dynamic> toMap(){
    var map = <String,dynamic>{
      'noteId': noteId,
      'name' : name,
      'img' : img,
      'quantity' : quantity,
      'harga' : harga,
    };
    return map;
  }

}