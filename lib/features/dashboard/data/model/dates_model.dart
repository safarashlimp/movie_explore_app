class DatesModel {
  final String maximum;
  final String minimum;

  DatesModel({
    required this.maximum,
    required this.minimum,
  });

  factory DatesModel.fromJson(Map<String, dynamic> json) {
    return DatesModel(
      maximum: json['maximum'],
      minimum: json['minimum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maximum': maximum,
      'minimum': minimum,
    };
  }
}
