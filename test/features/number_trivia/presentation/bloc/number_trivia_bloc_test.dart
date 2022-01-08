import 'package:bloc_course/core/errors/failure.dart';
import 'package:bloc_course/core/util/input_conversion.dart';
import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:bloc_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:bloc_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockInputConverter = MockInputConverter();
    mockRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockConcreteNumberTrivia,
        getRandomNumberTrivia: mockRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('Initial state should be empty', () async {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(text: 'trivia test', number: 1);

    void setupSuccessCallsForCastingAndConcreteNumber() {
      when(() => mockConcreteNumberTrivia.call(params: any(named: 'params')))
          .thenAnswer((_) async => Right(tNumberTrivia));

      when(() => mockInputConverter.stringToUnsignedInt(str: any(named: 'str')))
          .thenReturn(Right(tNumberParsed));
    }

    void setupServerFailureForConcreteNumber() {
      when(() => mockInputConverter.stringToUnsignedInt(str: any(named: 'str')))
          .thenReturn(Right(tNumberParsed));

      when(() => mockConcreteNumberTrivia.call(params: any(named: 'params')))
          .thenAnswer((_) async => Left(ServerFailure()));

    }
    test(
        'should call InputConverter to validate and convert the string to an '
        'unsigned int', () async {
      // arrange
      setupSuccessCallsForCastingAndConcreteNumber() ;

      // act
      bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      await untilCalled(
          () => mockInputConverter.stringToUnsignedInt(str: any(named: 'str')));

      // assert
      verify(() => mockInputConverter.stringToUnsignedInt(str: tNumberString));
    });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Error] when the input invalid',
      setUp: () => when(() =>
              mockInputConverter.stringToUnsignedInt(str: any(named: 'str')))
          .thenReturn(Left(InvalidInputFailure())),
      build: () => bloc,
      act: (bloc) =>
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString)),
      expect: () =>
          <NumberTriviaState>[Error(message: INVALID_INPUT_FAILURE_MESSAGE)],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [ServerFailure] when the Server Exception is raised',
      setUp: () => setupServerFailureForConcreteNumber(),
      build: () => bloc,
      act: (bloc) =>
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString)),
      expect: () =>
      <NumberTriviaState>[
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [CacheFailure] when the Server Exception is raised',
      setUp: () => setupServerFailureForConcreteNumber(),
      build: () => bloc,
      act: (bloc) =>
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString)),
      expect: () =>
      <NumberTriviaState>[
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should get data from the concrete use case',
      setUp: () => setupSuccessCallsForCastingAndConcreteNumber(),
      build: () => bloc,
      act: (bloc) =>
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString)),
      expect: () =>
          <NumberTriviaState>[
            Loading(),
            Loaded(trivia: tNumberTrivia)
          ],
    );

  });
}
