import 'package:flutter/material.dart';
import 'package:notas/core/theme/app_theme.dart';

class EmptyNoteList extends StatelessWidget {
  const EmptyNoteList({Key? key}) : super(key: key);

  final double size = 200;

  static const _invert = ColorFilter.matrix(<double>[
    -1, 0, 0, 0, 255, //
    0, -1, 0, 0, 255, //
    0, 0, -1, 0, 255, //
    0, 0, 0, 1, 0, //
  ]);

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      'assets/ic_empty.png',
      width: size,
      height: size,
    );
    if (context.colors.invertEmptyArt) {
      image = ColorFiltered(colorFilter: _invert, child: image);
    }
    return Center(
      child: Opacity(opacity: 0.2, child: image),
    );
  }
}
