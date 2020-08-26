class History {
  int id;
  String imageFile;
  String english;
  String khmer;
  String score;
  String date;

  History({
    this.id,
    this.imageFile,
    this.english,
    this.khmer,
    this.score,
    this.date,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      imageFile: json['imageFile'],
      english: json['english'],
      khmer: json['khmer'],
      score: json['score'],
      date: json['date'],
    );
  }
}
