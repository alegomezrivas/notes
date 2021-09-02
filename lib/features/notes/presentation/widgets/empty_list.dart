import 'package:flutter/material.dart';

class EmptyNoteList extends StatelessWidget {
  const EmptyNoteList({Key? key}) : super(key: key);

  final double size = 200;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 0.2,
        child: Image.asset(
          'assets/ic_empty.png',
          width: size,
          height: size,
        ),
      ),
    );
  }
}
