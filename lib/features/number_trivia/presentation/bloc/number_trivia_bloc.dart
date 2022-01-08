import 'package:bloc/bloc.dart';
import 'package:bloc_course/core/errors/exceptions.dart';
import 'package:bloc_course/core/errors/failure.dart';
import 'package:bloc_course/core/usecases/usecase.dart';
import 'package:bloc_course/core/util/input_conversion.dart';
import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:bloc_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure' ;
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - '
    'The number must be > 0' ;

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia ;
  final GetRandomNumberTrivia getRandomNumberTrivia ;
  final InputConverter inputConverter ;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) => fetchConcreteTriviaNumber(event:event, emit:emit));
    on<GetTriviaForRandomNumber>((event, emit) => fetchRandomTriviaNumber(event:event, emit:emit));
  }

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

  void fetchConcreteTriviaNumber({required event, required emit}){
    final inputEither = inputConverter.stringToUnsignedInt(
        str: event.numberString
    );
    inputEither.fold(
        (failure) {
          emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)) ;
        },
        (integer) async {
          emit(Loading());
          final Params params = Params(number: integer) ;
          final triviaResult = await getConcreteNumberTrivia(params: params);
          triviaResult.fold(
                  (failure) {
                    emit(Error(message: _mapFailureToMessage(failure))) ;
                  },
                  (trivia) => emit(Loaded(trivia: trivia))
          );
        }
    );
  }

  void fetchRandomTriviaNumber({required event, required emit}) async {
    emit(Loading());
    final triviaResult = await getRandomNumberTrivia.call();
    triviaResult.fold(
            (failure) {
          emit(Error(message: _mapFailureToMessage(failure))) ;
        },
            (trivia) => emit(Loaded(trivia: trivia))
    );
  }
}
