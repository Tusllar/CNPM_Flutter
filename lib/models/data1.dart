class Date {
  final int id;
  final int? movie_id;
  final String? date;

  Date({
    required this.id,
    required this.movie_id,
    required this.date,
  });

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      id: json['id'],
      movie_id: json['movie_id'],
      date: json['date'],
    );
  }
}

class Time {
  final int id;
  final int? schedule_id;
  final String? time;

  Time({
    required this.id,
    required this.schedule_id,
    required this.time,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      id: json['id'],
      schedule_id: json['schedule_id'],
      time: json['time'],
    );
  }
}

class Seat {
  final Set<String> seats;

  Seat({
    required this.seats,
  });
  // Factory constructor để tạo đối tượng Seat từ JSON
  factory Seat.fromJson(Map<String, dynamic> json) {
    // Chuyển đổi danh sách ghế (List) thành Set<String>
    return Seat(
      seats: Set<String>.from(json['seats']),
    );
  }
}
