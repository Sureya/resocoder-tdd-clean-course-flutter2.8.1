import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({required this.message}) : super();

  final String message ;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          margin: EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height/6,
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