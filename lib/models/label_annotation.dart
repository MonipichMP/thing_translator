class LabelAnnotationList {
  List<LabelAnnotation> data;

  LabelAnnotationList({this.data});

  factory LabelAnnotationList.fromJson(Map<String, dynamic> json) {
    var list = json["labelAnnotations"] as List;
    List<LabelAnnotation> labelAnnotationList =
        list.map((i) => LabelAnnotation.fromJson(i)).toList();
    return LabelAnnotationList(
        data: labelAnnotationList
        );
  }
}

class LabelAnnotation {
  String description;
  double score;

  LabelAnnotation({
    this.description,
    this.score
  });

  factory LabelAnnotation.fromJson(Map<String, dynamic> json) {
    return LabelAnnotation(
    description: json['description'] as String,
    score: json['score'] as double
  );
  }
}