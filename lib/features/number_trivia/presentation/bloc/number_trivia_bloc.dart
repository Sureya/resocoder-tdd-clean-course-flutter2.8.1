import 'package:bloc/bloc.dart';
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
    on<NumberTriviaEvent>((event, emit) => concreteLogic(event:event, emit:emit));
  }
  void concreteLogic({required event, required emit}){
    final inputEither = inputConverter.stringToUnsignedInt(
        str: event.numberString
    );

    inputEither.fold(
            (failure) {
          emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)) ;
        },
            (integer) {
          throw UnimplementedError() ;
        }
    );
  }
}
