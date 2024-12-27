class Video {
  final List<String> movieIds;

  Video({
    required this.movieIds,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      movieIds: List<String>.from(json['videos']),
    );
  }
}
