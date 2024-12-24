class Movie2 {
  final int id;
  final String? video_id;
  final String? title;
  final String? director;
  final String? actors;
  final String? genre;
  final String? time_movie;
  final String? releaseDate;
  final String? language;
  final String? rating;
  final String? overview;
  final String? backdropPath;
  final String? posterPath;
  Movie2({
    required this.id,
    required this.video_id,
    required this.title,
    required this.director,
    required this.actors,
    required this.genre,
    required this.time_movie,
    required this.releaseDate,
    required this.language,
    required this.rating,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
  });

  factory Movie2.fromJson(Map<String, dynamic> json) {
    return Movie2(
        id: json['id'],
        video_id: json['video_id'],
        title: json['title'],
        director: json['director'],
        actors: json['actors'],
        genre: json['genre'],
        time_movie: json['time_movie'],
        releaseDate: json['duration'],
        language: json['lang'],
        rating: json['rating'],
        overview: json['review'],
        posterPath: json['poster_url'],
        backdropPath: json['background_url']);
  }
}
