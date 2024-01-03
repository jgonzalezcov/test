import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:test/src/models/question_model.dart';
import 'dart:async';
import 'package:test/src/providers/questions_provider.dart';
import 'package:test/src/database/db.dart';

class QuestionWidget extends StatefulWidget {
  final Question? question;
  final int currentIndex;
  final Function() onAnswerSelected;
  final int questionIndex;
  final bool isSpeechComplete;
  final int numberOfQuestion;

  const QuestionWidget({
    required this.question,
    required this.onAnswerSelected,
    required this.currentIndex,
    required this.questionIndex,
    required this.isSpeechComplete,
    required this.numberOfQuestion,
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int selectedAnswer = -1;
  bool isWidgetVisible = true;
  bool finished = false;
  AudioPlayer audioPlayer = AudioPlayer();

  void checkAnswer() {
    if (selectedAnswer == widget.question?.correctAlternativeIndex) {
      Provider.of<QuestionsProvider>(context, listen: false)
          .updatePlayerResponse(widget.questionIndex, 'correcta');
    } else {
      Provider.of<QuestionsProvider>(context, listen: false)
          .updatePlayerResponse(widget.questionIndex, 'error');
    }
  }

  void _playSound() async {
    await audioPlayer.play(
      AssetSource('sounds/megaman_select.mp3'),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color blackWithTransparency = Colors.red.withOpacity(0.9);
    Color redWithTransparency = Colors.black.withOpacity(0.7);

    return Column(
      children: <Widget>[
        const SizedBox(height: 50),
        Center(
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            height: 170,
            width: double.infinity,
            child: Text(
              widget.question?.questionText ?? "",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Column(
          children: (widget.question?.alternatives ?? []).asMap().entries.map(
            (entry) {
              final index = entry.key;
              final alternative = entry.value;
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: (selectedAnswer == index &&
                          widget.currentIndex == widget.questionIndex)
                      ? blackWithTransparency
                      : redWithTransparency,
                ),
                child: RadioListTile(
                  activeColor: Colors.white,
                  title: widget.currentIndex == widget.questionIndex &&
                          widget.isSpeechComplete
                      ? Text(
                          alternative,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )
                      : const Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.visibility_off,
                            color: Colors.white,
                          ),
                        ),
                  value: index,
                  groupValue: selectedAnswer,
                  onChanged: (value) {
                    if (widget.currentIndex == widget.questionIndex &&
                        widget.isSpeechComplete) {
                      setState(() {
                        selectedAnswer = value!;
                      });

                      _playSound();
                      checkAnswer();
                      widget.onAnswerSelected();
                      if (widget.numberOfQuestion == widget.questionIndex) {
                        finished = true;
                        Timer(
                          const Duration(seconds: 2),
                          () async {
                            setState(() {
                              isWidgetVisible = false;
                            });
                            await DB.insertScore(
                                Provider.of<QuestionsProvider>(
                                  context,
                                  listen: false,
                                ).correctAnswersCount,
                                Provider.of<QuestionsProvider>(context,
                                        listen: false)
                                    .topicSelect);

                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              'Result',
                              (route) => false,
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              );
            },
          ).toList(),
        )
      ],
    );
  }
}
