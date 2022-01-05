import 'dart:convert';

import 'package:bloc_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'trivia test');

  test('should be a subclass of NumberTrivia entity', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test(
        'should return a valid model when the JSON number is integer',
        () async {
        // arrange
          final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json')) ;

        // act
          final result = NumberTriviaModel.fromJson(json:jsonMap);

        // assert
          expect(result, tNumberTriviaModel) ;
    });

    test(
        'should return a valid model when the JSON number is double', () async {

        // arrange
          final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json')) ;

        // act
          final result = NumberTriviaModel.fromJson(json:jsonMap);

        // assert
          expect(result, tNumberTriviaModel) ;
    }
    );
  });

  group('toJson', () {
    test(
        'should return a valid model when the JSON number is integer',
            () async {
          // arrange
          final Map<String, dynamic> expectedMap = {"text": "trivia test",  "number": 1} ;
          // act
          final result = tNumberTriviaModel.toJson();

          // assert
          expect(result, expectedMap) ;
        });


  });
}
