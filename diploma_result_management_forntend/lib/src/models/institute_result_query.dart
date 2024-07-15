import 'dart:convert';

class InstituteResultQuery {
  final String examType;
  final int regulation;
  final String heldOn;
  final int semester;
  final int eiin;

  InstituteResultQuery({
    required this.examType,
    required this.regulation,
    required this.heldOn,
    required this.semester,
    required this.eiin,
  });

  InstituteResultQuery copyWith({
    String? examType,
    int? regulation,
    String? heldOn,
    int? semester,
    int? eiin,
  }) =>
      InstituteResultQuery(
        examType: examType ?? this.examType,
        regulation: regulation ?? this.regulation,
        heldOn: heldOn ?? this.heldOn,
        semester: semester ?? this.semester,
        eiin: eiin ?? this.eiin,
      );

  factory InstituteResultQuery.fromJson(String str) =>
      InstituteResultQuery.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InstituteResultQuery.fromMap(Map<String, dynamic> json) =>
      InstituteResultQuery(
        examType: json["examType"],
        regulation: json["regulation"],
        heldOn: json["heldOn"],
        semester: json["semester"],
        eiin: json["eiin"],
      );

  Map<String, dynamic> toMap() => {
        "examType": examType,
        "regulation": regulation,
        "heldOn": heldOn,
        "semester": semester,
        "eiin": eiin,
      };
}
