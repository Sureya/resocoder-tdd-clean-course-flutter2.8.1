import 'package:bloc_course/core/errors/exceptions.dart';
import 'package:bloc_course/core/errors/failure.dart';
import 'package:bloc_course/core/platform/network_info.dart';
import 'package:bloc_course/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:bloc_course/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  NetworkInfo networkInfo;

  NumberTriviaRemoteDataSource numberTriviaRemoteDataSource;

  NumberTriviaLocalDataSource numberTriviaLocalDataSource;

  NumberTriviaRepositoryImpl({
    required this.networkInfo,
    required this.numberTriviaLocalDataSource,
    required this.numberTriviaRemoteDataSource,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(
        () => numberTriviaRemoteDataSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(
        () => numberTriviaRemoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      Future<NumberTrivia> Function() getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final NumberTrivia remoteTrivia = await getConcreteOrRandom();
        numberTriviaLocalDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final NumberTrivia localNumberTrivia =
            await numberTriviaLocalDataSource.getLastNumberTrivia();
        return Right(localNumberTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
