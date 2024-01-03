import 'dart:async';
import 'package:flutter/material.dart';

class CronometerProvider with ChangeNotifier {
  int segundos = 0;
  int minutos = 0;
  int horas = 0;
  late Timer _timer;
  bool _cronometroActivo = false;

  bool get cronometroActivo => _cronometroActivo;

  String getTiempoTranscurrido() {
    return '$horas:$minutos:$segundos';
  }

  void iniciarCronometro() {
    if (!_cronometroActivo) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _actualizarTiempo();
      });
      _cronometroActivo = true;
      notifyListeners();
    }
  }

  void detenerCronometro() {
    if (_cronometroActivo) {
      _timer.cancel();
      _cronometroActivo = false;
      notifyListeners();
    }
  }

  void reiniciarCronometro() {
    _detenerCronometro();
    _resetearTiempo();
    _iniciarCronometro();
    notifyListeners();
  }

  void _iniciarCronometro() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _actualizarTiempo();
    });
    _cronometroActivo = true;
  }

  void _detenerCronometro() {
    if (_cronometroActivo) {
      _timer.cancel();
      _cronometroActivo = false;
    }
  }

  void _resetearTiempo() {
    segundos = 0;
    minutos = 0;
    horas = 0;
  }

  void _actualizarTiempo() {
    segundos++;
    if (segundos == 60) {
      segundos = 0;
      minutos++;
      if (minutos == 60) {
        minutos = 0;
        horas++;
      }
    }
    notifyListeners();
  }
}
