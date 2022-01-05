import 'package:bloc_course/core/errors/failure.dart';
import 'package:bloc_course/core/usecases/usecase.dart';
import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';



class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository ;

  GetRandomNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> call({NoParams? noParam}) async {
    return await repository.getRandomNumberTrivia();
  }
}