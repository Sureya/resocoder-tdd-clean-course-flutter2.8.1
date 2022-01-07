import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:bloc_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}


void main() {
  late GetConcreteNumberTrivia usecase ;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp((){
    TestWidgetsFlutterBinding.ensureInitialized();
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(repository: mockNumberTriviaRepository);
  });

  final testNumber = 1 ;
  final testNumberTrivia = NumberTrivia(text: 'one is fun', number: 1) ;

  test(
      'should get trivia for the number from the repository',
      () async {
        // arrange
        when(() => mockNumberTriviaRepository.getConcreteNumberTrivia(
            any())).thenAnswer((_) async => Right(testNumberTrivia)
        ) ;

        // act
        final result = await usecase(params: Params(number: testNumber)) ;

        // assert
        expect(result, Right(testNumberTrivia)) ;
        verify(() => mockNumberTriviaRepository. getConcreteNumberTrivia(testNumber)) ;
        verifyNoMoreInteractions(mockNumberTriviaRepository) ;
      }
  ) ;
}