import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget() : super();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height/6,
        child: CircularProgressIndicator()
    );
  }
}
