class Video{
  String _name;
  String _link;

  Video(this._name, this._link);

  String get link => _link;

  String get name => _name;

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      json['name'] as String,
      json['key'] as String,
    );
  }
}