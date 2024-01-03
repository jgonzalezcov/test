class Score {
  final int id;
  final int score;
  final String date;
  final String topic;

  Score({
    required this.id,
    required this.score,
    required this.date,
    required this.topic,
  });

  // Método para convertir el objeto Score a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'date': date,
      'topic': topic,
    };
  }

  // Constructor para crear un objeto Score a partir de un mapa
  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      id: map['id'],
      score: map['score'],
      date: map['date'],
      topic: map['topic'],
    );
  }
}
