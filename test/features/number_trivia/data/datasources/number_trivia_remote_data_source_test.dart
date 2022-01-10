import 'dart:convert';

import 'package:bloc_course/core/errors/exceptions.dart';
import 'package:bloc_course/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:bloc_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDioClient extends Mock implements Dio {}


void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource ;
  late MockDioClient mockDioClient ;

  setUp((){
    mockDioClient = MockDioClient() ;
    dataSource = NumberTriviaRemoteDataSourceImpl(dioClient: mockDioClient);
  });

  void setUpMockHttpClientSuccess200() {
    final responsePayload = jsonDecode(fixture("trivia.json")) ;
    final httpResponse = Response(
        data: responsePayload,
        requestOptions: RequestOptions(path: '/any'),
        statusCode: 200
    );

    when(() => mockDioClient.get(any())).thenAnswer((_) async => httpResponse);
  }
  void setUpMockHttpClientFailure() {
    when(() => mockDioClient.get(any())).thenThrow(ServerException());
  }

  group('getConcreteNumberTrivia', (){
    final tNumber = 1 ;
    final NumberTriviaModel tNumberTriviaModel = NumberTriviaModel.fromJson(json: jsonDecode(fixture("trivia.json")));

     test('''should perform a GET request on a URL with number being on the 
            endpoint and with application/json header''',
     () async {
      // arrange
       setUpMockHttpClientSuccess200() ;

      // act
       await dataSource.getConcreteNumberTrivia(tNumber);

      // assert
       verify(
       () => mockDioClient.get(
           "$NUMBERS_DOMAIN/$tNumber?json",
       )).called(1);
    });

    test('''should perform a GET request and return number trivia''',
    () async {
          // arrange
          setUpMockHttpClientSuccess200() ;

          // act
          final result = await dataSource.getConcreteNumberTrivia(tNumber);

          // assert
          verify(
                  () => mockDioClient.get("$NUMBERS_DOMAIN/$tNumber?json")
          ).called(1);

          expect(result, equals(tNumberTriviaModel));

        });

    test('''should perform a GET request and return ServerException on failure''',

    () async {
          // arrange
          setUpMockHttpClientFailure();

          // act
          final call = dataSource.getConcreteNumberTrivia;

          // assert
          expect( () => call(tNumber), throwsA(TypeMatcher<ServerException>()));

        });


  });

  group('getRandomNumberTrivia', (){
    final NumberTriviaModel tNumberTriviaModel = NumberTriviaModel.fromJson(json: jsonDecode(fixture("trivia.json")));

    test('''should perform a GET request on a URL with number being on the 
            endpoint and with application/json header''',
            () async {
          // arrange
          setUpMockHttpClientSuccess200() ;

          // act
          await dataSource.getRandomNumberTrivia();

          // assert
          verify(
                  () => mockDioClient.get("$NUMBERS_DOMAIN/random?json")
          ).called(1);
        });

    test('''should perform a GET request and return number trivia''',
            () async {
          // arrange
          setUpMockHttpClientSuccess200() ;

          // act
          final result = await dataSource.getRandomNumberTrivia();

          // assert
          verify(
                  () => mockDioClient.get("$NUMBERS_DOMAIN/random?json")
          ).called(1);

          expect(result, equals(tNumberTriviaModel));

        });

    test('''should perform a GET request and return ServerException on failure''',

            () async {
          // arrange
          setUpMockHttpClientFailure();

          // act
          final call = dataSource.getRandomNumberTrivia;

          // assert
          expect( () => call(), throwsA(TypeMatcher<ServerException>()));

        });


  });
}