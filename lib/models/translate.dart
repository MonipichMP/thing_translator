class Translate {
  String translatedText;

  Translate({this.translatedText});

  factory Translate.fromJSon(Map<String, dynamic> json) {
    return Translate(
      translatedText: json['translatedText'] as String,
    );
  }
}