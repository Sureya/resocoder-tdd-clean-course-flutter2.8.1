
import 'package:bloc_course/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class InvalidInputFailure extends Failure {}


class InputConverter {
  Either<Failure, int> stringToUnsignedInt({required String str}){
      try{
        int parsedInteger = int.parse(str) ;
        if (parsedInteger < 0){
          throw FormatException() ;
        } else {
          return Right(parsedInteger);
        }

      } on FormatException {
        return Left(InvalidInputFailure());
      }
  }
}