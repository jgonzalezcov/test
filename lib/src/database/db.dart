import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test/src/models/score_model.dart';
import 'package:intl/intl.dart';

//*****************SCORE PLAYER**************//
class DB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'player.db'),
        onConfigure: (db) async {
      // Ejecutar código antes de realizar cualquier operación en la base de datos
      await db.execute(
        "CREATE TABLE IF NOT EXISTS scores_player (id INTEGER PRIMARY KEY, score INTEGER, date TEXT, topic TEXT)",
      );
    }, version: 1); // Bump the version number after schema changes
  }

  // Insertar un nuevo score
  static Future<void> insertScore(int score, String topic) async {
    Database database = await _openDB();

    // Obtén la fecha y hora actual
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    // Inserta el puntaje en la base de datos
    await database.insert(
      'scores_player',
      {'score': score, 'date': formattedDate, 'topic': topic},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obtener todos los scores
  static Future<List<Score>> getScores() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> maps =
        await database.query('scores_player');
    return List.generate(maps.length, (i) {
      return Score(
        id: maps[i]['id'],
        score: maps[i]['score'],
        date: maps[i]['date'],
        topic: maps[i]['topic'],
      );
    });
  }

  // Obtener los 10 scores con los valores más altos
  static Future<List<Score>> getTopScores() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> maps = await database.query(
      'scores_player',
      orderBy: 'score DESC, date DESC',
      limit: 10,
    );
    return List.generate(maps.length, (i) {
      return Score(
        id: maps[i]['id'],
        score: maps[i]['score'],
        date: maps[i]['date'],
        topic: maps[i]['topic'],
      );
    });
  }

// Elimina los registros que no están en los top 10
  static Future<void> deleteNonTopScores() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> allScores = await database.query(
      'scores_player',
      orderBy: 'score DESC, date DESC',
    );

    final List<int> topScoreIds = await database
        .query(
      'scores_player',
      columns: ['id'],
      orderBy: 'score DESC, date DESC',
      limit: 10,
    )
        .then((List<Map<String, dynamic>> maps) {
      return List.generate(maps.length, (i) {
        return maps[i]['id'] as int;
      });
    });

    final List<int> scoresToDelete = allScores
        .where((score) => !topScoreIds.contains(score['id']))
        .map<int>((score) => score['id'] as int)
        .toList();

    for (int id in scoresToDelete) {
      await database.delete('scores_player', where: 'id = ?', whereArgs: [id]);
    }
  }

  // Obtener un score por su ID
  static Future<Score> getScoresById(int id) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> maps =
        await database.query('scores_player', where: 'id = ?', whereArgs: [id]);

    return Score(
      id: maps[0]['id'],
      score: maps[0]['score'],
      date: maps[0]['date'],
      topic: maps[0]['topic'],
    );
  }

  // Actualizar un score existente
  static Future<void> updateScore(Score score) async {
    Database database = await _openDB();
    await database.update(
      'scores_player',
      score.toMap(),
      where: 'id = ?',
      whereArgs: [score.id],
    );
  }

  // Eliminar un score
  static Future<void> deleteScore(int id) async {
    Database database = await _openDB();
    await database.delete(
      'scores_player', // Corregido el nombre de la tabla
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Eliminar todos los registros de la tabla scores_player
  static Future<void> deleteAllScores() async {
    Database database = await _openDB();
    await database.delete('scores_player');
  }

  // Eliminar la tabla scores_player
  static Future<void> dropScoresTable() async {
    Database database = await _openDB();
    await database.execute('DROP TABLE IF EXISTS scores_player');
  }
}
