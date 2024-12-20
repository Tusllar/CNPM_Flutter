class Movie1 {
  final String? title;
  final String? overview;
  final String? releaseDate;
  final String? posterPath;
  final String? backdropPath;
  final int? id;

  Movie1({
    required this.posterPath,
    required this.id,
    required this.backdropPath,
    required this.title,
    required this.overview,
    required this.releaseDate,
  });

  factory Movie1.fromJson(Map<String, dynamic> json) {
    return Movie1(
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int?,
    );
  }
}
