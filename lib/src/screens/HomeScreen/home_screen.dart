import 'package:flutter/material.dart';
import 'package:test/src/screens/HomeScreen/widgets/buttons_subject/button_subject_data.dart';
import 'package:test/src/screens/HomeScreen/widgets/buttons_subject/button_subject_widget.dart';
import 'package:test/src/screens/HomeScreen/widgets/title_text/title_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 63, 113),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20.0),
                child: const TitleTextWidget()),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: subjectsData.length,
                itemBuilder: (context, index) {
                  final subject = subjectsData[index];
                  return ButtonSubjectWidget(
                    textButton: subject.textButton,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
