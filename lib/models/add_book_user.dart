class Book {
  late String id;
  late String name;
  late String auther;
  late String details;

  Book();

  Book.fromMap(Map<String, dynamic> documentMap) {
    name = documentMap['name'];
    auther = documentMap['auther'];
    details = documentMap['details'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['auther'] = auther;
    map['details'] = details;
    return map;
  }
}