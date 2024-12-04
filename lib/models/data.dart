class Movie {
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final int id;

  Movie(
      {required this.title,
      required this.posterPath,
      required this.id,
      required this.overview,
      required this.backdropPath,
      required this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      backdropPath: 'https://image.tmdb.org/t/p/w500' + json['backdrop_path'],
      posterPath: 'https://image.tmdb.org/t/p/w500' + json['poster_path'],
    );
  }
}
