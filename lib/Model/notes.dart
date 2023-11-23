class Notes{
  late int? noteId;
  late String? email;
  late String? date;
  late String? name;
  late String? year;

  Notes({this.noteId, this.name, this.date, this.year, this.email});

  Notes.formMap(dynamic ojb){
    this.noteId = ojb['noteId'];
    this.name = ojb['name'];
    this.date = ojb['date'];
    this.year = ojb['year'];
    this.email = ojb['email'];
  }

  Map<String, dynamic> toMap(){
    var map = <String,dynamic>{
      'name' : name,
      'date' : date,
      'year' : year,
      'email' : email
    };
    return map;
  }

}