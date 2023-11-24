class User{
  late int? userId;
  late String? password;
  late String? username;

  User({this.userId,this.password,this.username});

  User.fromMap(dynamic obj){
    this.userId = obj['userId'];
    this.password = obj['password'];
    this.username = obj['username'];
  }


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'password' : password,
      'username' : username
    };
    return map;
  }

}