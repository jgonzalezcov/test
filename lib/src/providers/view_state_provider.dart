import 'package:flutter/material.dart';

class ViewStateProvider with ChangeNotifier {
  String _vScreen = '';
  bool _finished = false;

  String get viewScreen => _vScreen;
  bool get finished => _finished;
  void setViewScreen(String textScreen) {
    _vScreen = textScreen;
    notifyListeners();
  }

  void setFinished(bool state) {
    _finished = state;
    notifyListeners();
  }
}
