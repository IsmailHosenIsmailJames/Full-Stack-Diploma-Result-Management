import 'dart:convert';

class IndividualResultQuery {
  final String examType;
  final int regulation;
  final String heldOn;
  final int semester;
  final int roll;

  IndividualResultQuery({
    required this.examType,
    required this.regulation,
    required this.heldOn,
    required this.semester,
    required this.roll,
  });

  IndividualResultQuery copyWith({
    String? examType,
    int? regulation,
    String? heldOn,
    int? semester,
    int? roll,
  }) =>
      IndividualResultQuery(
        examType: examType ?? this.examType,
        regulation: regulation ?? this.regulation,
        heldOn: heldOn ?? this.heldOn,
        semester: semester ?? this.semester,
        roll: roll ?? this.roll,
      );

  factory IndividualResultQuery.fromJson(String str) =>
      IndividualResultQuery.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IndividualResultQuery.fromMap(Map<String, dynamic> json) =>
      IndividualResultQuery(
        examType: json["examType"],
        regulation: json["regulation"],
        heldOn: json["heldOn"],
        semester: json["semester"],
        roll: json["roll"],
      );

  Map<String, dynamic> toMap() => {
        "examType": examType,
        "regulation": regulation,
        "heldOn": heldOn,
        "semester": semester,
        "roll": roll,
      };
}
