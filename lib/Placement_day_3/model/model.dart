// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

List<Usermodel> usermodelFromJson(String str) => List<Usermodel>.from(json.decode(str).map((x) => Usermodel.fromJson(x)));

String usermodelToJson(List<Usermodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usermodel {
  int id;
  String email;
  String password;
  String name;
  Role role;
  String avatar;
  DateTime creationAt;
  DateTime updatedAt;

  Usermodel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    required this.creationAt,
    required this.updatedAt,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    name: json["name"],
    role: roleValues.map[json["role"]]!,
    avatar: json["avatar"],
    creationAt: DateTime.parse(json["creationAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "name": name,
    "role": roleValues.reverse[role],
    "avatar": avatar,
    "creationAt": creationAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

enum Role {
  ADMIN,
  CUSTOMER
}

final roleValues = EnumValues({
  "admin": Role.ADMIN,
  "customer": Role.CUSTOMER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

