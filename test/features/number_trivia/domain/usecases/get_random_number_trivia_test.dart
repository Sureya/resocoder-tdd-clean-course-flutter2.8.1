import 'package:bloc_course/core/usecases/usecase.dart';
import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:bloc_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}


void main() {
  late GetRandomNumberTrivia usecase ;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp((){
    TestWidgetsFlutterBinding.ensureInitialized();
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final testNumberTrivia = NumberTrivia(text: 'one is fun', number: 1) ;

  test(
      'should get trivia for random number from the repository',
          () async {
        // arrange
        when(
                () => mockNumberTriviaRepository.getRandomNumberTrivia()
        ).thenAnswer((_) async => Right(testNumberTrivia)
        ) ;

        // act
        final result = await usecase(noParam: NoParams()) ;

        // assert
        expect(result, Right(testNumberTrivia)) ;
        verify(() => mockNumberTriviaRepository. getRandomNumberTrivia()) ;
        verifyNoMoreInteractions(mockNumberTriviaRepository) ;
      }
  ) ;
}