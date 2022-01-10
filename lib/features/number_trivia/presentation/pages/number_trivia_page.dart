import 'package:bloc_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:bloc_course/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  NumberTriviaPage({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Number Trivia'),
        ),
        body: buildBody(context:context)
    );
  }

  BlocProvider buildBody({required BuildContext context}){
    return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    print(MediaQuery.of(context).size.height/2.5);
                    print("*********** $state") ;
                    if (state is Empty) {
                      return Text("1");
                    }else{
                      return Text("2");
                    }
                  }
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height/2.5,
                  child: Placeholder()
              ),
              SizedBox(height: 20.0,),
              Column(
                children: [
                  Placeholder(fallbackHeight: 50),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(child: Placeholder(fallbackHeight: 30)),
                      SizedBox(width: 10),
                      Expanded(child: Placeholder(fallbackHeight: 30),),
                    ],
                  )
                ],
              )

            ],
          ),
        ),
      ),
    ) ;
  }
}
