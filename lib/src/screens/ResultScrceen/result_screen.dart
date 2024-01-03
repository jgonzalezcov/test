import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/src/database/db.dart';
import 'package:test/src/models/score_model.dart';
import 'package:test/src/providers/questions_provider.dart';
import 'package:test/src/screens/QuestionScreen/widgets/background/background_widget.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  bool isHeroVisible = true;

  @override
  void initState() {
    super.initState();
    // Inicia el temporizador para ocultar el Hero después de 2 segundos
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isHeroVisible = false;
      });
    });
    // Elimina registros que no están en los top 10
    deleteNonTopScoresAndBuildWidget();
  }

  // Método para eliminar registros y reconstruir el widget
  Future<void> deleteNonTopScoresAndBuildWidget() async {
    await DB.deleteNonTopScores();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var questionsProvider = Provider.of<QuestionsProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          AnimatedOpacity(
            opacity: isHeroVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: const Hero(
              tag: 'loadingHero',
              child: Image(
                image: AssetImage('assets/imgs/loading.gif'),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isHeroVisible ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(
                  alignment: Alignment.center,
                  width: 310,
                  height: 100,
                  decoration: BoxDecoration(
                    color:
                        (questionsProvider.correctAnswersCount / 10) * 100 >= 50
                            ? Colors.green
                            : Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Text(
                          'Respuestas correctas: ${questionsProvider.correctAnswersCount} de 10 (${(questionsProvider.correctAnswersCount / 10 * 100).toStringAsFixed(0)}%)',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color:
                                (questionsProvider.correctAnswersCount / 10) *
                                            100 >=
                                        50
                                    ? Colors.blue
                                    : Colors.red,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              (questionsProvider.correctAnswersCount /
                                          10 *
                                          100) >=
                                      50
                                  ? 'APROBADO'
                                  : 'REPROBADO',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      var question = questionsProvider.questions[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Text(
                              '${index + 1}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            question.playerResponse == 'correcta'
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )
                          ],
                        ),
                      );
                    },
                  ),
                )),
              ],
            ),
          ),
          AnimatedOpacity(
            opacity: isHeroVisible ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 300),
                  Container(
                    width: 400,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Text(
                        'TOP 10 MEJORES RESULTADOS',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          border: Border.all(color: Colors.green)),
                      child: FutureBuilder<List<Score>>(
                        future: DB.getTopScores(questionsProvider.topicSelect),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text('No hay puntajes');
                          } else {
                            return SingleChildScrollView(
                              child: DataTable(
                                columns: const [
                                  DataColumn(
                                    label: Text(
                                      'Top',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Nota',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Fecha',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Tema',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                                rows:
                                    snapshot.data!.asMap().entries.map((entry) {
                                  int rank = entry.key + 1;
                                  Score score = entry.value;

                                  return DataRow(cells: [
                                    DataCell(
                                      Text(
                                        '$rank',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        '${score.score}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        score.date,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        score.topic,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<QuestionsProvider>(context, listen: false)
              .resetCorrectAnswersCount();

          Navigator.pushNamedAndRemoveUntil(context, 'Home', (route) => false);
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
