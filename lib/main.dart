import 'package:bloc_course/injection_container.dart' as di;
import 'package:flutter/material.dart';

import 'features/number_trivia/presentation/pages/number_trivia_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      home: NumberTriviaPage(key: Key("trivia_page")),
      theme: ThemeData(
        primaryColor: Colors.green.shade800
      ),
    );
  }
}


