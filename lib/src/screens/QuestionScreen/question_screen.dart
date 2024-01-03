import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/src/providers/chronometer.dart';
import 'package:test/src/providers/view_state_provider.dart';
import 'package:test/src/screens/QuestionScreen/widgets/background/background_widget.dart';
import 'package:test/src/screens/QuestionScreen/widgets/carousel_widget/carousel_widget.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      var cronometroProvider =
          Provider.of<CronometerProvider>(context, listen: false);
      cronometroProvider.iniciarCronometro();
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = Provider.of<ViewStateProvider>(context).viewScreen;

    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 38, 63, 113)),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 38, 63, 113),
            ),
          ),
          const BackgroundWidget(),
          const CarouselWidget()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega de regreso a la pantalla HomeScreen
          Navigator.pop(context);
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
