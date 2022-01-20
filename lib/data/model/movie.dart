class Movie {
  int _id;
  String _title;
  String _originalTitle;
  double _voteAverage;
  String _releaseDate;
  String _overview;
  String _posterPath;

  Movie(
    this._id,
    this._title,
    this._originalTitle,
    this._voteAverage,
    this._releaseDate,
    this._overview,
    this._posterPath,
  );

  String get posterPath => _posterPath;

  String get overview => _overview;

  String get releaseDate => _releaseDate;

  double get voteAverage => _voteAverage;

  String get originalTitle => _originalTitle;

  String get title => _title;

  int get id => _id;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        json['id'] as int,
        json['title'] as String,
        json['original_title'] as String,
        json['vote_average'].toDouble() as double,
        json['release_date'] as String,
        json['overview'] as String,
        json['poster_path'] as String);
  }
}
