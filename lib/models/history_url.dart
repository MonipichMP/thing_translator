class HistoryUrl {
  int id;
  String imageUrl;
  String english;
  String khmer;
  String score;
  String date;

  HistoryUrl({
    this.id,
    this.imageUrl,
    this.english,
    this.khmer,
    this.score,
    this.date,
  });

  factory HistoryUrl.fromJson(Map<String, dynamic> json) {
    return HistoryUrl(
      id: json['id'],
      imageUrl: json['imageUrl'],
      english: json['english'],
      khmer: json['khmer'],
      score: json['score'],
      date: json['date'],
    );
  }
}
