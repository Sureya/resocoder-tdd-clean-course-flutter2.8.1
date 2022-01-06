import 'dart:convert';
import 'dart:ffi';

import 'package:bloc_course/core/errors/exceptions.dart';
import 'package:bloc_course/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:bloc_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}


main() {
  late NumberTriviaLocalDataSourceImpl dataSource ;
  late MockSharedPreferences mockSharedPreferences ;

  setUp((){
    mockSharedPreferences = MockSharedPreferences() ;
    dataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences) ;
  });

  group('getLatestNumberTrivia', (){
    final NumberTriviaModel tNumberTriviaModel = NumberTriviaModel.fromJson(json: jsonDecode(fixture("triviaCached.json")));
    test(
    'should return NumberTrivia from SharedPreferences when there is one in the cache', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(fixture("triviaCached.json"));
      // act
      final result = await dataSource.getLastNumberTrivia() ;

      // assert
      verify(() => mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw CacheException from SharedPreferences when there is no cached value', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenThrow(CacheException());

      // act
      final call = dataSource.getLastNumberTrivia ;

      // assert
      expect( () => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    final NumberTriviaModel tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'trivia test');

    test(
    'should call SharedPreferences to cache the data', () async {
      // arrange
      when(() => mockSharedPreferences.setString(any(), any())).thenAnswer((_) async => true);
      // act
      await dataSource.cacheNumberTrivia(tNumberTriviaModel);
      // assert
      final expectedJsonString = jsonEncode(tNumberTriviaModel.toJson());
      verify(() => mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA, expectedJsonString
      ));
    });
  });
}