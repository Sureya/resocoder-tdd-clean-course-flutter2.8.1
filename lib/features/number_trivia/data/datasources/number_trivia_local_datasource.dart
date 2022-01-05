import 'package:bloc_course/core/errors/exceptions.dart';
import 'package:bloc_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Caches latest [NumberTriviaModel] from the internet
  ///
  /// Throws [CacheException] if data cannot be cached
  Future<void> cacheNumberTrivia(NumberTrivia triviaToCache);
}