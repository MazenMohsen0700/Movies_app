class ParentalGuideModel {
  final String type;
  final String text;

  ParentalGuideModel({
    required this.type,
    required this.text,
  });

  factory ParentalGuideModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return ParentalGuideModel(
      type: json['type'] ?? '',
      text: json['parental_guide_text'] ?? '',
    );
  }
}
