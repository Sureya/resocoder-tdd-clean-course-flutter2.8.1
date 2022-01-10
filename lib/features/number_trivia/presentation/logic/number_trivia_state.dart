/// jokes_state.dart

import 'package:bloc_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'number_trivia_state.freezed.dart';


///Extension Method for easy comparison
extension NumberTriviaGetter on NumberTriviaState {
  bool get isLoading => this is _NumberTriviaStateLoading;
}

@freezed
abstract class NumberTriviaState with _$NumberTriviaState {
  ///Initial
  const factory NumberTriviaState.initial() = _JokesStateInitial;

  ///Loading
  const factory NumberTriviaState.loading() = _NumberTriviaStateLoading;

  ///Data
  const factory NumberTriviaState.data({required NumberTrivia trivia}) = _NumberTriviaData;

  ///Error
  const factory NumberTriviaState.error([String? error]) = _NumberTriviaError;
}
