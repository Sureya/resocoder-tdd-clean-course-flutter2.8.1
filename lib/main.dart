import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/number_trivia/presentation/pages/number_trivia_page.dart';

void main() async {
  runApp(
      ProviderScope(
          child: MyApp()
      )
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


