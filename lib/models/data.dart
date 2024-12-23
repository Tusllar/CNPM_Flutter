class Movie {
  final String? title;
  final String? overview;
  final String? releaseDate;
  final String? posterPath;
  final String? backdropPath;
  final int? id;

  Movie({
    required this.posterPath,
    required this.id,
    required this.backdropPath,
    required this.title,
    required this.overview,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int?,
    );
  }
}

// class Movie2 {
//   final String? title;
//   final String? overview;
//   final String? language;
//   final String? releaseDate;
//   final String? posterPath;
//   final String? backdropPath;
//   final int? votecount;
//   Movie2({
//     this.title,
//     this.releaseDate,
//     this.posterPath,
//     this.overview,
//     this.language,
//     this.backdropPath,
//     this.votecount,
//   });
//
//   factory Movie2.fromJson(Map<String, dynamic> json) {
//     return Movie2(
//       title: json['title'] as String?,
//       language: json['original_language'] as String?,
//       overview: json['overview'] as String?,
//       releaseDate: json['release_date'] as String?,
//       posterPath:
//           "https://image.tmdb.org/t/p/w500" + json['poster_path'] as String?,
//       backdropPath:
//           "https://image.tmdb.org/t/p/w500" + json['backdrop_path'] as String?,
//       votecount: json['vote_count'] as int?,
//     );
//   }
// }

class Ticket {
  final int id;
  final String date;
  final String time;
  final String seats;
  final String totalprice;
  final String title;
  final String backdropPath;
  final int row_seat;

  Ticket({
    required this.id,
    required this.date,
    required this.time,
    required this.seats,
    required this.totalprice,
    required this.title,
    required this.backdropPath,
    required this.row_seat,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        id: json['ticket_id'],
        date: json['dates'],
        time: json['times'],
        seats: json['seats'],
        totalprice: json['totalPrice'],
        title: json['movie_title'],
        backdropPath: json['backdropPath'],
        row_seat: json['seat_number']);
  }
}

// class Nowplaying {
//
//   Nowplaying(
//       {});
//   factory Nowplaying.fromJson(Map<String, dynamic> json) {
//     return Nowplaying(
//         );
//   }
// }

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
