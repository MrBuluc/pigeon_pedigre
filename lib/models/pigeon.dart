class Pigeon {
  String? id;
  String? momId;
  String? dadId;

  Pigeon({this.id, this.momId, this.dadId});

  Pigeon.fromJson(Map<String, Object?> json)
      : this(
            id: json["id"] as String,
            momId: json["momId"] as String,
            dadId: json["dadId"] as String);

  Map<String, Object?> toJson() => {"id": id, "momId": momId, "dadId": dadId};
}
