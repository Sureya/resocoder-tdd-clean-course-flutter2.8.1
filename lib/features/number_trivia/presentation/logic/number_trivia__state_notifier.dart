part of 'number_trivia_provider.dart';




const String SERVER_FAILURE_MESSAGE = 'Server Failure' ;
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - '
    'The number must be > 0' ;


class NumberTriviaNotifier extends StateNotifier<NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia ;
  final GetRandomNumberTrivia getRandomNumberTrivia ;
  final InputConverter inputConverter ;

  NumberTriviaNotifier({
      required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter
  }) : super(const NumberTriviaState.initial());

  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType) {

      case ServerFailure:
        return SERVER_FAILURE_MESSAGE ;

      case CacheFailure:
        return CACHE_FAILURE_MESSAGE ;

      default:
        return "Unexpected error" ;
    }
  }

  void fetchConcreteTriviaNumber({required String numberString}) async {

    state = const NumberTriviaState.loading();

    final inputEither = inputConverter.stringToUnsignedInt(str: numberString);

    inputEither.fold(
            (failure) {
              state = NumberTriviaState.error(_mapFailureToMessage(failure));
        },
            (integer) async {
          final Params params = Params(number: integer) ;
          final triviaResult = await getConcreteNumberTrivia(params: params);
          triviaResult.fold(
                  (failure) {
                    state = NumberTriviaState.error(_mapFailureToMessage(failure));
              },
              (trivia) {
                state = NumberTriviaState.data(trivia: trivia);
              }
          );
        }
    );
  }

  void fetchRandomTriviaNumber() async {

    state = const NumberTriviaState.loading();

    final triviaResult = await getRandomNumberTrivia.call();

    triviaResult.fold(
        (failure) {
          state = NumberTriviaState.error(_mapFailureToMessage(failure));
        },
        (trivia) {
          state = NumberTriviaState.data(trivia: trivia);
        }
    );
  }


}