import 'dart:html';

class Total {
  late int? totalId;
  late int? notesId;
  late int? total;

  Total({this.totalId, this.notesId, this.total});

  Total.formMap(dynamic ojb){
    this.totalId = ojb['totalId'];
    this.notesId = ojb['notesId'];
    this.total = ojb['total'];
  }

  Map<String, dynamic> toMap(){
    var map = <String,dynamic>{
      'notesId':notesId,
      'total':total
    };
    return map;
  }


}