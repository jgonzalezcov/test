// question_model.dart

import 'package:flutter/foundation.dart';

class Question extends ChangeNotifier {
  final String topic;
  final String questionText;
  final List<String> alternatives;
  final int correctAlternativeIndex;
  late String _playerResponse;

  Question({
    required this.topic,
    required this.questionText,
    required this.alternatives,
    required this.correctAlternativeIndex,
    String? playerResponse,
  }) : _playerResponse = playerResponse ?? '';

  String get playerResponse => _playerResponse;

  set playerResponse(String value) {
    _playerResponse = value;
    notifyListeners();
  }
}
