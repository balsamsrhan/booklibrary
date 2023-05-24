class User {
  late String id;
  late String nameuser;
  late String email;
  //late String pasword;

  User();

  User.fromMap(Map<String, dynamic> documentMap) {
    nameuser = documentMap['nameuser'];
    email = documentMap['email'];
    //pasword = documentMap['password'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['nameuser'] = nameuser;
    map['email'] = email;
   // map['password'] = pasword;
    return map;
  }
}