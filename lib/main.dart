import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/src/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // Con esto me aseguro que flutter este inicializado
  WidgetsFlutterBinding.ensureInitialized();
  // Es para mantener que siempre se vea horizontal
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dotenv.load();
  runApp(const MyApp());
}
