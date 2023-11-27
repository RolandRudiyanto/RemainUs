class Notes{
  late int? noteId;
  late String? username;
  late String? date;
  late String? name;
  late String? year;
  late int? total;

  Notes({this.noteId, this.name, this.date, this.year, this.username,this.total});

  Notes.formMap(dynamic ojb){
    this.noteId = ojb['noteId'];
    this.name = ojb['name'];
    this.date = ojb['date'];
    this.year = ojb['year'];
    this.username = ojb['username'];
    this.total = ojb['total'];
  }

  Map<String, dynamic> toMap(){
    var map = <String,dynamic>{
      'name' : name,
      'date' : date,
      'year' : year,
      'username' : username,
      'total' : total,
    };
    return map;
  }

}