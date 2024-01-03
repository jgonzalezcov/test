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

class QuestionsProvider with ChangeNotifier {
  int _correctAnswersCount = 0;
  List<Question> _questions = []; // Mueve la declaración aquí

  QuestionsProvider() {
    _questions = [
      Question(
        topic: 'Geografía',
        questionText: "¿Cuál es la capital de Francia?",
        alternatives: ["Madrid", "Londres", "París", "Berlín"],
        correctAlternativeIndex: 2,
        playerResponse: '',
      ),
      Question(
        topic: 'Geografía',
        questionText: "¿En qué continente se encuentra Brasil?",
        alternatives: ["África", "Asia", "Europa", "América del Sur"],
        correctAlternativeIndex: 3,
        playerResponse: '',
      ),
      Question(
        topic: 'Geografía',
        questionText: "¿Cuál es el río más largo del mundo?",
        alternatives: ["Nilo", "Amazonas", "Yangtsé", "Misisipi"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Geografía',
        questionText: "¿En qué país se encuentra la Gran Muralla China?",
        alternatives: ["India", "China", "Japón", "Corea del Sur"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Geografía',
        questionText:
            "¿Cuál es el país más grande del mundo en términos de superficie?",
        alternatives: ["Canadá", "Estados Unidos", "Rusia", "China"],
        correctAlternativeIndex: 2,
        playerResponse: '',
      ),
      Question(
        topic: 'Geografía',
        questionText: "¿En qué océano se encuentra la isla de Madagascar?",
        alternatives: [
          "Océano Pacífico",
          "Océano Atlántico",
          "Océano Índico",
          "Mar Mediterráneo"
        ],
        correctAlternativeIndex: 2,
        playerResponse: '',
      ),
      Question(
        topic: 'Geografía',
        questionText: "¿Cuál es la montaña más alta del mundo?",
        alternatives: [
          "Monte Everest",
          "Monte Kilimanjaro",
          "Monte McKinley",
          "Monte Aconcagua"
        ],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Geografía',
        questionText: "¿En qué país se encuentra el desierto del Sahara?",
        alternatives: ["Egipto", "Sudán", "Marruecos", "Níger"],
        correctAlternativeIndex: 2,
        playerResponse: '',
      ),
      Question(
        topic: 'Geografía',
        questionText: "¿Cuál es la capital de Australia?",
        alternatives: ["Sídney", "Melbourne", "Brisbane", "Canberra"],
        correctAlternativeIndex: 3,
        playerResponse: '',
      ),
      Question(
        topic: 'Geografía',
        questionText: "¿En qué país se encuentra la ciudad de Cuzco?",
        alternatives: ["Perú", "México", "Colombia", "Argentina"],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),

// Matematicas

      Question(
        topic: 'Matemáticas',
        questionText: "¿Cuánto es 15 x 7?",
        alternatives: ["92", "105", "112", "120"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Matemáticas',
        questionText: "Si a = 8 y b = 3, ¿cuánto es a + b?",
        alternatives: ["10", "11", "12", "13"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Matemáticas',
        questionText: "¿Cuál es el resultado de 24 ÷ 4?",
        alternatives: ["4", "8", "6", "10"],
        correctAlternativeIndex: 2,
        playerResponse: '',
      ),
      Question(
        topic: 'Matemáticas',
        questionText: "Si x = 5, ¿cuál es el valor de 3x - 2?",
        alternatives: ["13", "11", "15", "17"],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Matemáticas',
        questionText: "¿Cuánto es la raíz cuadrada de 81?",
        alternatives: ["7", "8", "10", "9"],
        correctAlternativeIndex: 3,
        playerResponse: '',
      ),
      Question(
        topic: 'Matemáticas',
        questionText: "Si a = 4 y b = 2, ¿cuánto es a² - b²?",
        alternatives: ["12", "8", "14", "16"],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Matemáticas',
        questionText: "¿Cuánto es 3.5 + 2.7?",
        alternatives: ["5.2", "6.2", "7.2", "8.2"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Matemáticas',
        questionText: "Si a = 10 y b = 3, ¿cuánto es a / b?",
        alternatives: ["2", "3", "3.33", "3.5"],
        correctAlternativeIndex: 2,
        playerResponse: '',
      ),
      Question(
        topic: 'Matemáticas',
        questionText: "¿Cuál es el resultado de 5³?",
        alternatives: ["125", "150", "175", "200"],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Matemáticas',
        questionText: "Si x = 2, ¿cuál es el valor de 2x + 3?",
        alternatives: ["5", "9", "11", "7"],
        correctAlternativeIndex: 3,
        playerResponse: '',
      ),
//Ciencias naturales

      Question(
        topic: 'Ciencias Naturales',
        questionText:
            "¿Cuál es el proceso mediante el cual las plantas producen su propio alimento?",
        alternatives: [
          "Fotosíntesis",
          "Respiración",
          "Digestión",
          "Circulación"
        ],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Ciencias Naturales',
        questionText: "¿Cuál es el hueso más largo del cuerpo humano?",
        alternatives: ["Fémur", "Tibia", "Húmero", "Radio"],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Ciencias Naturales',
        questionText:
            "¿Qué gas es esencial para la respiración de los seres humanos?",
        alternatives: [
          "Nitrógeno",
          "Oxígeno",
          "Dióxido de carbono",
          "Hidrógeno"
        ],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Ciencias Naturales',
        questionText: "¿Cuál es el órgano principal del sistema circulatorio?",
        alternatives: ["Pulmón", "Corazón", "Hígado", "Riñón"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Ciencias Naturales',
        questionText: "¿Cuál es el planeta más grande del sistema solar?",
        alternatives: ["Tierra", "Marte", "Júpiter", "Saturno"],
        correctAlternativeIndex: 2,
        playerResponse: '',
      ),
      Question(
        topic: 'Ciencias Naturales',
        questionText:
            "¿Cuál es la función principal de las mitocondrias en una célula?",
        alternatives: [
          "Digestión celular",
          "Almacenamiento de agua",
          "Producción de energía",
          "Síntesis de proteínas"
        ],
        correctAlternativeIndex: 2,
        playerResponse: '',
      ),
      Question(
        topic: 'Ciencias Naturales',
        questionText: "¿Qué es un ecosistema?",
        alternatives: [
          "Un órgano del cuerpo humano",
          "Una especie de planta",
          "Una unidad de medida de temperatura",
          "Un conjunto de seres vivos y su entorno"
        ],
        correctAlternativeIndex: 3,
        playerResponse: '',
      ),
      Question(
        topic: 'Ciencias Naturales',
        questionText:
            "¿Cuál es el nombre del proceso mediante el cual el agua se convierte en vapor?",
        alternatives: [
          "Evaporación",
          "Condensación",
          "Precipitación",
          "Infiltración"
        ],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Ciencias Naturales',
        questionText:
            "¿Cuál es el componente principal del aire que respiramos?",
        alternatives: ["Nitrógeno", "Oxígeno", "Dióxido de carbono", "Argón"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Ciencias Naturales',
        questionText:
            "¿Cuál es el proceso mediante el cual las plantas obtienen nutrientes del suelo?",
        alternatives: [
          "Fotosíntesis",
          "Respiración",
          "Transpiración",
          "Asimilación"
        ],
        correctAlternativeIndex: 3,
        playerResponse: '',
      ),
//Historia

      Question(
        topic: 'Historia',
        questionText:
            "¿En qué año se firmó la Declaración de Independencia de los Estados Unidos?",
        alternatives: ["1776", "1789", "1804", "1820"],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Historia',
        questionText: "¿Quién fue el primer presidente de los Estados Unidos?",
        alternatives: [
          "Thomas Jefferson",
          "George Washington",
          "John Adams",
          "Abraham Lincoln"
        ],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Historia',
        questionText: "¿En qué año comenzó la Primera Guerra Mundial?",
        alternatives: ["1914", "1918", "1939", "1945"],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Historia',
        questionText: "¿Cuál fue la antigua capital del Imperio Romano?",
        alternatives: ["Atenas", "Roma", "Cartago", "Constantinopla"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Historia',
        questionText: "¿Quién fue el líder de la Revolución Rusa de 1917?",
        alternatives: [
          "Vladimir Lenin",
          "Joseph Stalin",
          "Leon Trotsky",
          "Mikhail Gorbachev"
        ],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Historia',
        questionText:
            "¿En qué año se firmó el Tratado de Versalles, poniendo fin a la Primera Guerra Mundial?",
        alternatives: ["1919", "1921", "1923", "1931"],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Historia',
        questionText:
            "¿Quién fue la reina de Egipto conocida por su relación con Julio César y Marco Antonio?",
        alternatives: ["Cleopatra", "Nefertiti", "Hatshepsut", "Isis"],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Historia',
        questionText:
            "¿En qué año llegaron Cristóbal Colón y sus tripulantes al continente americano?",
        alternatives: ["1492", "1500", "1512", "1525"],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Historia',
        questionText: "¿Cuál fue la capital del Imperio Inca?",
        alternatives: ["Machu Picchu", "Cuzco", "Lima", "Quito"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Historia',
        questionText: "¿En qué año se proclamó la independencia de México?",
        alternatives: ["1810", "1821", "1836", "1848"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
// Dragon Ball
      Question(
        topic: 'Dragon Ball',
        questionText:
            "¿Cuál es el nombre del protagonista principal en Dragon Ball?",
        alternatives: ["Vegeta", "Goku", "Gohan", "Trunks"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Dragon Ball',
        questionText:
            "¿En qué saga Goku se transforma por primera vez en Super Saiyan?",
        alternatives: [
          "Saga de la Red Ribbon",
          "Saga de Freezer",
          "Saga de Cell",
          "Saga de Majin Buu"
        ],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Dragon Ball',
        questionText:
            "¿Cuál es el nombre del maestro de Goku en la Escuela Tortuga?",
        alternatives: ["Kame Sennin", "Korin", "Mr. Popo", "Muten Roshi"],
        correctAlternativeIndex: 3,
        playerResponse: '',
      ),
      Question(
        topic: 'Dragon Ball',
        questionText: "¿Cuál es el nombre del planeta natal de Goku?",
        alternatives: [
          "Tierra",
          "Planeta Namekusei",
          "Planeta Vegeta",
          "Planeta Monstruo"
        ],
        correctAlternativeIndex: 2,
        playerResponse: '',
      ),
      Question(
        topic: 'Dragon Ball',
        questionText: "¿Quién es el príncipe de los Saiyans?",
        alternatives: ["Goku", "Vegeta", "Gohan", "Trunks"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      ),
      Question(
        topic: 'Dragon Ball',
        questionText: "¿Cuál es la técnica de ataque más famosa de Goku?",
        alternatives: [
          "Kamehameha",
          "Final Flash",
          "Spirit Bomb",
          "Solar Flare"
        ],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Dragon Ball',
        questionText: "¿Quién es el creador de los androides 17 y 18?",
        alternatives: ["Dr. Gero", "Dr. Brief", "Dr. Wheelo", "Dr. Slump"],
        correctAlternativeIndex: 0,
        playerResponse: '',
      ),
      Question(
        topic: 'Dragon Ball',
        questionText: "¿Cuál es el nombre de la nave espacial de Vegeta?",
        alternatives: [
          "Capsule Corp",
          "Namekian Ship",
          "Saiyan Pod",
          "Frieza Ship"
        ],
        correctAlternativeIndex: 2,
        playerResponse: '',
      ),
      Question(
        topic: 'Dragon Ball',
        questionText:
            "¿En qué saga se presenta por primera vez el personaje de Cell?",
        alternatives: [
          "Saga de la Red Ribbon",
          "Saga de Freezer",
          "Saga de Cell",
          "Saga de Majin Buu"
        ],
        correctAlternativeIndex: 2,
        playerResponse: '',
      ),
      Question(
        topic: 'Dragon Ball',
        questionText: "¿Cuál es el nombre del padre de Goku?",
        alternatives: ["King Cold", "Bardock", "King Vegeta", "Raditz"],
        correctAlternativeIndex: 1,
        playerResponse: '',
      )
    ];
  }

  List<Question> get questions => _questions;

  int get correctAnswersCount => _correctAnswersCount;

  void updatePlayerResponse(int questionIndex, String value) {
    _questions[questionIndex].playerResponse = value;
    if (value == 'correcta') {
      _correctAnswersCount++;
    }
    notifyListeners();
  }

  void resetCorrectAnswersCount() {
    _correctAnswersCount = 0;
    for (var question in questions) {
      question.playerResponse = '';
    }
    notifyListeners();
  }

//Tema seleccionado
  String _topicSelect = '';

  void setSelectedTopic(String topic) {
    _topicSelect = topic;
    notifyListeners();
    print(_topicSelect);
  }

  String get topicSelect => _topicSelect;
}
