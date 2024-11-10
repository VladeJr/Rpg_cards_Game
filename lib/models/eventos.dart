class Event {
  final String title;
  final String description;
  final DateTime date;

  Event({
    required this.title,
    required this.description,
    required this.date,
  });

  // Converter o evento para JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  // Criar um evento a partir de JSON
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
}
