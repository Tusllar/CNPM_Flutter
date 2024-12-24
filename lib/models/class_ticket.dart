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
