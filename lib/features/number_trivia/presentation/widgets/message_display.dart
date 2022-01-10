import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageDisplay extends ConsumerWidget {
  const MessageDisplay({required this.message}) : super();

  final String message ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          margin: EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height/3,
          child: Text(
            message,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
            ),
          )
      ),
    );
  }
}