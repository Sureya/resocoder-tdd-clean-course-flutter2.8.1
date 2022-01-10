import 'package:bloc_course/features/number_trivia/presentation/logic/number_trivia_provider.dart';
import 'package:bloc_course/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:bloc_course/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:bloc_course/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:bloc_course/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberTriviaPage extends ConsumerWidget {
  NumberTriviaPage({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Number Trivia'),
        ),
        body: buildBody(
            context:context,
            ref: ref
        )
    );
  }

  Widget mapStateToWidget({
    required BuildContext context,
    required WidgetRef ref
  }){
    return Consumer(
        builder: (context, watch, child) {
          final state = ref.watch(numberTriviaProvider);
          return state.when(
            initial: () => MessageDisplay(message: 'Start searching dudes!'),
            loading: () => LoadingWidget(),
            data: (trivia) => TriviaDisplay(numberTrivia: trivia),
            error: (error) => Text('Error Occured!'),
          );
        }
    ) ;
  }
  Widget buildBody({
    required BuildContext context,
    required WidgetRef ref
  }){

    return Center(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                mapStateToWidget(context:context, ref: ref),
                SizedBox(height: 30.0,),
                TriviaControls(key: Key("trivia_control"))
              ],
            )
        )
    );
  }
}
