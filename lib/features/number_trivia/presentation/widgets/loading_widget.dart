import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingWidget extends ConsumerWidget {
  const LoadingWidget() : super();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height/6,
        child: CircularProgressIndicator()
    );
  }
}
