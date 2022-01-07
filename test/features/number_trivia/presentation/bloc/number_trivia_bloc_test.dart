import 'package:bloc_course/core/util/input_conversion.dart';
import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:bloc_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:bloc_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock
    implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock
    implements InputConverter {}


void main() {
  late NumberTriviaBloc bloc ;
  late MockGetConcreteNumberTrivia mockConcreteNumberTrivia ;
  late MockGetRandomNumberTrivia mockRandomNumberTrivia ;
  late MockInputConverter mockInputConverter ;

  setUp((){
    mockInputConverter = MockInputConverter() ;
    mockRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockConcreteNumberTrivia = MockGetConcreteNumberTrivia() ;
    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockConcreteNumberTrivia,
        getRandomNumberTrivia: mockRandomNumberTrivia,
        inputConverter: mockInputConverter
    );
  });
  test(
  'Initial state should be empty', () async {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1' ;
    final tNumberParsed = 1 ;
    final tNumberTrivia = NumberTrivia(text: 'trivia test', number: 1);

    test(
    'should call InputConverter to validate and convert the string to an unsigned int', () async {
      // arrange
      when(
          ()=> mockInputConverter.stringToUnsignedInt(str: any(named: 'str'))
      ).thenReturn(Right(tNumberParsed)) ;
      // act
      bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      await untilCalled(
        () => mockInputConverter.stringToUnsignedInt(str: any(named: 'str'))
      ) ;
      // assert
      verify(()=>mockInputConverter.stringToUnsignedInt(str: tNumberString));
    });

    test(
    'should emit [Error] when the input invalid', () async {
      // arrange
      when(
              ()=> mockInputConverter.stringToUnsignedInt(str: any(named: 'str'))
      ).thenReturn(Left(InvalidInputFailure())) ;

      // act
      bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      await untilCalled(
              () => mockInputConverter.stringToUnsignedInt(str: any(named: 'str'))
      ) ;

      // assert later
      final Error expected = Error(message: INVALID_INPUT_FAILURE_MESSAGE) ;
      expect(bloc.state, equals(expected));


    });
  });
}

