import 'package:bloc_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:bloc_course/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final greetingProvider = Provider((ref) => 'Start Searching') ;

class NumberTriviaPage extends ConsumerWidget {
  NumberTriviaPage({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: buildBody(
          mainContext:context,
          widgetRef: ref
        )
    );
  }

  Widget buildBody({
    required BuildContext mainContext,
    required WidgetRef widgetRef
  }){

    final greeting = widgetRef.watch(greetingProvider);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            Container(
                margin: EdgeInsets.all(5),
                height: MediaQuery.of(mainContext).size.height/3,
                child: Text(
                    greeting,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54
                    ),
                )
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
    ) ;
  }
}
