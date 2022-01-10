import 'package:bloc_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:bloc_course/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:bloc_course/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:bloc_course/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:bloc_course/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:bloc_course/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  NumberTriviaPage({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Number Trivia'),
          ),
          body: buildBody(context:context)
      ),
    );
  }

  Widget buildBody({required BuildContext context}){
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    bloc: sl<NumberTriviaBloc>(),
                    builder: (context, state) {
                      print("********** ${state.runtimeType}");
                      if (state is Empty) {
                        return MessageDisplay(
                          message: 'Start searching!',
                        );
                      } else if (state is Loading) {
                        return LoadingWidget();
                      } else if (state is Loaded) {
                        return TriviaDisplay(numberTrivia: state.trivia);
                      } else if (state is Error) {
                        return MessageDisplay(
                          message: state.message,
                        );
                      }
                      else{
                        return MessageDisplay(message:"Unknown error");
                      }


                    }
                ),
                SizedBox(height: 30.0,),
                TriviaControls(
                    key: Key("trivia_control")
                )
              ],
            )
        )
    );
  }
}
