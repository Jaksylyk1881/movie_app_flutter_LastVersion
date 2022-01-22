class Review {
  String _author;
  String _content;
  Review(this._author, this._content);

  String get content => _content;

  String get author => _author;
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        json['author'] as String,
        json['content'] as String,
        );
  }
}
