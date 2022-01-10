import 'package:bloc_course/features/number_trivia/presentation/logic/number_trivia_provider.dart';
import 'package:bloc_course/features/number_trivia/presentation/logic/number_trivia_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class TriviaControls extends ConsumerStatefulWidget {
  const TriviaControls({
    required Key key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TriviaControlsState();
  }


}

class _TriviaControlsState extends ConsumerState<TriviaControls> {
  String inputStr = "" ;
  final TextEditingController controller  = TextEditingController();


  void getTrivia(){

  }

  @override
  Widget build(BuildContext mainContext) {
    final state = ref.watch(numberTriviaProvider);

    return Column(
      children: [
        TextField(
          controller: controller,
          onChanged:(value){
            inputStr = value ;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Input a number"
          ),
          onSubmitted: (_) => ref.read(numberTriviaProvider.notifier).fetchConcreteTriviaNumber(numberString: inputStr),
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                  child: Text("Search"),
                  onPressed: () {
                    controller.clear();
                    ref.read(numberTriviaProvider.notifier).fetchConcreteTriviaNumber(numberString: inputStr);
                  },
                )
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(numberTriviaProvider.notifier).fetchRandomTriviaNumber();
                },
                child: Text("Get Random Trivia"),
              ),
            ),
          ],
        )
      ],
    );
  }
}

