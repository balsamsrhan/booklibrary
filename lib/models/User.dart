
class Users {
  late String id;
  late String name;
  late String email;
  late String password;


  Users();

  Users.fromMap(Map<String, dynamic> documentMap) {
    name = documentMap['name'];
    email = documentMap['email'];
    password = documentMap['password'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}