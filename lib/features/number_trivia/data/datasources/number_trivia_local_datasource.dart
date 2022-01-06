import 'dart:convert';

import 'package:bloc_course/core/errors/exceptions.dart';
import 'package:bloc_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Caches latest [NumberTriviaModel] from the internet
  ///
  /// Throws [CacheException] if data cannot be cached
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA' ;


class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences ;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null){
      return Future.value(NumberTriviaModel.fromJson(json: jsonDecode(jsonString)));
    } else {
      throw CacheException() ;
    }

  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
    sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA,
        jsonEncode(triviaToCache.toJson())
    ) ;
  }

}