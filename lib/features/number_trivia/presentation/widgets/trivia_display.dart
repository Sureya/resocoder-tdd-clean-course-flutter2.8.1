
import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/material.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({ required this.numberTrivia}) : super();

  final NumberTrivia numberTrivia ;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height/6,
        child: Column(
          children: [
            Text(
              numberTrivia.number.toString(),
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Text(
                    numberTrivia.text,
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}