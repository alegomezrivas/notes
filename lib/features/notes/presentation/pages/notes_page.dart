import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas/core/theme/app_theme.dart';
import 'package:notas/features/notes/presentation/pages/note_details_page.dart';
import 'package:notas/features/notes/presentation/provider/note_provider.dart';
import 'package:notas/features/notes/presentation/widgets/empty_list.dart';
import 'package:notas/features/notes/presentation/widgets/note_build_list_view.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<NoteProvider>(context, listen: false).getAllNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoteProvider>(context);
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.canvas,
      appBar: AppBar(
        title: Text(
          'Notas',
          style: TextStyle(color: colors.accent),
        ),
        centerTitle: true,
      ),
      body: provider.notes.isNotEmpty
          ? NoteBuildListView(provider: provider)
          : EmptyNoteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NoteDetailsPage(isNotEmpty: false),
            ),
          );
        },
        elevation: 16.0,
        tooltip: 'New note',
        backgroundColor: colors.accentStrong,
        child: Icon(Icons.add, color: colors.onAccent, size: 32),
      ),
    );
  }
}
