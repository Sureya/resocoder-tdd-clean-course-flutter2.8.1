import 'package:bloc_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class TriviaControls extends StatefulWidget {
  const TriviaControls({
    required Key key,
  }) : super(key: key);

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  String inputStr = "" ;
  final TextEditingController controller  = TextEditingController();

  void dispatchConcrete() {
    BlocProvider.of<NumberTriviaBloc>(context).add(
        GetTriviaForConcreteNumber(numberString: inputStr.toString()
        )
    );


  }
  void dispatchRandom() {
    BlocProvider.of<NumberTriviaBloc>(context).add(
        GetTriviaForRandomNumber()
    );


  }

  @override
  Widget build(BuildContext mainContext) {
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
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                  child: Text("Search"),
                  onPressed: () {
                    controller.clear();
                    dispatchConcrete() ;
                  },
                )
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                child: Text("Get Random Trivia"),
                onPressed: () => dispatchRandom(),
              ),
            ),
          ],
        )
      ],
    );
  }
}

