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

class Movie2 {
  final String? title;
  final String? overview;
  final String? language;
  final String? releaseDate;
  final String? posterPath;
  final String? backdropPath;
  final int? votecount;
  Movie2({
    this.title,
    this.releaseDate,
    this.posterPath,
    this.overview,
    this.language,
    this.backdropPath,
    this.votecount,
  });

  factory Movie2.fromJson(Map<String, dynamic> json) {
    return Movie2(
      title: json['title'] as String?,
      language: json['original_language'] as String?,
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] as String?,
      posterPath:
          "https://image.tmdb.org/t/p/w500" + json['poster_path'] as String?,
      backdropPath:
          "https://image.tmdb.org/t/p/w500" + json['backdrop_path'] as String?,
      votecount: json['vote_count'] as int?,
    );
  }
}

class Ticket {
  final int id;
  final String date;
  final String time;
  final String seats;
  final int totalprice;
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
        id: json['id'],
        date: json['date'],
        time: json['time'],
        seats: json['seats'],
        totalprice: json['totalPrice'],
        title: json['title'],
        backdropPath: json['backdropPath'],
        row_seat: json['row_seat']);
  }
}
