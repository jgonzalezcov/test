import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:test/src/models/question_model.dart';
import 'package:test/src/providers/questions_provider.dart';
import 'package:test/src/screens/QuestionScreen/widgets/question_widget/question_widget.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;
  late CarouselController _carouselController;
  late FlutterTts flutterTts;
  bool isSpeechComplete = false;
  late QuestionsProvider _questionsProvider;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.9);
    flutterTts.setLanguage("es-US");

    _questionsProvider = Provider.of<QuestionsProvider>(context, listen: false);
    speakQuestion();
  }

  void goToNextPage() {
    if (_currentIndex < _questionsProvider.questions.length - 1) {
      _carouselController.nextPage();
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  // Función para leer la pregunta actual
  Future<void> speakQuestion() async {
    isSpeechComplete = false;
    if (_currentIndex == 0) {
      // Si es la primera pregunta, retraso de 1 segundo
      await Future.delayed(const Duration(milliseconds: 1500));
    } else {
      // Si es una pregunta diferente, retraso de 500 milisegundos
      await Future.delayed(const Duration(milliseconds: 500));
    }

    final questions = _questionsProvider.questions
        .where((question) => question.topic == _questionsProvider.topicSelect)
        .toList();

    if (_currentIndex < questions.length) {
      final currentQuestion = questions[_currentIndex];
      await flutterTts.speak(currentQuestion.questionText);
    }

    await flutterTts.awaitSpeakCompletion(true);
    setState(() {
      isSpeechComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionsProvider = Provider.of<QuestionsProvider>(context);
    List<Question> questions = questionsProvider.questions
        .where((question) => question.topic == questionsProvider.topicSelect)
        .toList();
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 600.0,
            initialPage: 0,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            autoPlay: false,
            pauseAutoPlayOnTouch: false,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              speakQuestion();
            },
          ),
          items: [
            ...questions.asMap().entries.map((entry) {
              final index = entry.key;
              final question = entry.value;

              return QuestionWidget(
                question: question,
                onAnswerSelected: goToNextPage,
                currentIndex: _currentIndex,
                questionIndex: index,
                isSpeechComplete: isSpeechComplete,
                numberOfQuestion: questions.length - 1,
              );
            }),
            const Hero(
              tag: 'loadingHero',
              child: Image(
                image: AssetImage('assets/imgs/loading.gif'),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                if (_currentIndex > 0) {
                  _carouselController.previousPage();
                }
              },
              child: const Text('Anterior'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_currentIndex < questions.length - 1) {
                  _carouselController.nextPage();
                }
              },
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ],
    );
  }
}
