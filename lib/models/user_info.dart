import 'package:flutter/cupertino.dart';

class UserInfoC {
  String? id;
  String? name;
  String? surname;
  String? mail;

  UserInfoC({this.id, this.name, this.surname, @required this.mail});

  UserInfoC.fromJson(Map<String, Object?> json)
      : this(
            id: json["id"]! as String,
            name: json["name"]! as String,
            surname: json["surname"]! as String,
            mail: json["mail"]! as String);

  Map<String, Object?> toJson() =>
      {"id": id, "name": name, "surname": surname, "mail": mail};
}
