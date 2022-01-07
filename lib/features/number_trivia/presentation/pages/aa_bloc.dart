import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'aa_event.dart';
part 'aa_state.dart';

class AaBloc extends Bloc<AaEvent, AaState> {
  AaBloc() : super(AaInitial()) {
    on<AaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
