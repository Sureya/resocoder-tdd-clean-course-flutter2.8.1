import 'package:bloc_course/core/util/input_conversion.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter ;

  setUp((){
    inputConverter = InputConverter() ;
  });

  group('StringToUnsignedInt', () {
    test(
    'should return an integer when the string is an unsigned integer', () async {
      // arrange
      final tStr = '123';

      // act
      final result = inputConverter.stringToUnsignedInt(str: tStr) ;

      // assert
      expect(result, Right(123));
    });

    test(
    'should return Failure when the string is not an integer', () async {
      // arrange
      final tStr = 'abc' ;
      // act
      final result = inputConverter.stringToUnsignedInt(str: tStr);

      // assert
      expect(result, Left(InvalidInputFailure()));
    });

    test(
        'should return Failure when the string is a negative integer', () async {
      // arrange
      final tStr = '-123' ;
      // act
      final result = inputConverter.stringToUnsignedInt(str: tStr);

      // assert
      expect(result, Left(InvalidInputFailure()));
    });


  });
}