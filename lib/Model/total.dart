class Total {
  late int? Id;
  late int? userId;
  late String? year;
  late int? totalAmount;

  Total({this.Id,this.userId, this.year, this.totalAmount});

  Total.formMap(dynamic ojb){
    this.Id = ojb['Id'];
    this.userId = ojb['userId'];
    this.totalAmount = ojb['totalAmount'];
    this.year = ojb['year'];
  }

  Map<String, dynamic> toMap(){
    var map = <String,dynamic>{
      'userId' : userId,
      'totalAmount' : totalAmount,
      'year' : year,
    };
    return map;
  }


}