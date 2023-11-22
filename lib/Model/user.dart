class User{
  late int? userId;
  late String? emial;
  late String? password;
  late String? username;

  User({this.userId,this.emial,this.password,this.username});

  User.fromMap(dynamic obj){
    this.userId = obj['userId'];
    this.emial = obj['email'];
    this.password = obj['password'];
    this.username = obj['username'];
  }


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'email' : emial ,
      'password' : password,
      'username' : username
    };
    return map;
  }

}