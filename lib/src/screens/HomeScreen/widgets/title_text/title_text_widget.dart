import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 45.0,
          fontFamily: 'Fredoka',
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'S',
            style: TextStyle(color: Colors.blue), // Color para la letra 'S'
          ),
          TextSpan(
            text: 'm',
            style: TextStyle(color: Colors.orange), // Color para la letra 'm'
          ),
          TextSpan(
            text: 'a',
            style: TextStyle(color: Colors.green), // Color para la letra 'a'
          ),
          TextSpan(
            text: 'r',
            style: TextStyle(color: Colors.red), // Color para la letra 'r'
          ),
          TextSpan(
            text: 't',
            style: TextStyle(color: Colors.purple), // Color para la letra 't'
          ),
          TextSpan(
            text: ' ',
            style: TextStyle(
                color: Colors.black), // Color para el espacio entre palabras
          ),
          TextSpan(
            text: 'Q',
            style: TextStyle(color: Colors.cyan), // Color para la letra 'Q'
          ),
          TextSpan(
            text: 'u',
            style:
                TextStyle(color: Colors.deepOrange), // Color para la letra 'u'
          ),
          TextSpan(
            text: 'i',
            style: TextStyle(color: Colors.teal), // Color para la letra 'i'
          ),
          TextSpan(
            text: 'z',
            style: TextStyle(color: Colors.pink), // Color para la letra 'z'
          ),
        ],
      ),
    ));
  }
}
