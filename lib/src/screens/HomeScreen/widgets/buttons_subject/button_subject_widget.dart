import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/src/providers/questions_provider.dart';

class ButtonSubjectWidget extends StatefulWidget {
  const ButtonSubjectWidget({
    Key? key,
    required this.textButton,
  }) : super(key: key);

  final String textButton;

  @override
  State<ButtonSubjectWidget> createState() => _ButtonSubjectWidgetState();
}

class _ButtonSubjectWidgetState extends State<ButtonSubjectWidget> {
  AudioPlayer audioPlayer = AudioPlayer();

  void _playSound() async {
    await audioPlayer.play(AssetSource(
      'sounds/dk_select.mp3',
    ));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // DESCOMENTAR LINEA DE ABAJO PARA RESETEAR CONTENIDO DEL SCORE_PLAYER DE LA BD//
        //await DB.deleteAllScores();
        // DESCOMENTAR LINEA DE ABAJO PARA ELIMINAR TABLA SCORE_PLAYER DE LA BD//
        //await DB.dropScoresTable();
        _playSound();
        final viewTopicProvider =
            Provider.of<QuestionsProvider>(context, listen: false);
        viewTopicProvider.setSelectedTopic(widget.textButton);

        Navigator.pushNamed(context, 'Question');
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child: Container(
            width: 250,
            height: 80,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imgs/button2.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.play_arrow,
                        size: 48,
                        color: Colors.white,
                      ),
                      Positioned(
                        top: 3.0,
                        left: 3.0,
                        child: Icon(
                          Icons.play_arrow,
                          size: 48,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.textButton,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Fredoka',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
