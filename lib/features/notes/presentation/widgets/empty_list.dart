import 'package:flutter/material.dart';

class EmptyNoteList extends StatelessWidget {
  const EmptyNoteList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Opacity(
          opacity: 0.2,
          child: Image.asset('assets/ic_empty.png'),
        ),
      ),
    );
  }
}
