import 'dart:convert';

import 'package:bloc_course/core/errors/exceptions.dart';
import 'package:bloc_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:dio/dio.dart';


abstract class NumberTriviaRemoteDataSource {
  /// Calls the number endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the random endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}


const NUMBERS_DOMAIN = "http://numbersapi.com" ;

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Dio dioClient;

  NumberTriviaRemoteDataSourceImpl({required this.dioClient});

  Future<NumberTriviaModel> _getNumberTriviaFromApi(String url) async {
    final response = await dioClient.get(url);
    if (response.statusCode == 200) {
      print(response.data);
      return NumberTriviaModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return _getNumberTriviaFromApi("$NUMBERS_DOMAIN/$number?json");
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return _getNumberTriviaFromApi("$NUMBERS_DOMAIN/random?json");
  }
}
