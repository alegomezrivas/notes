import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas/features/notes/presentation/pages/note_details_page.dart';
import 'package:notas/features/notes/presentation/provider/note_provider.dart';
import 'package:notas/features/notes/presentation/widgets/empty_list.dart';
import 'package:notas/features/notes/presentation/widgets/note_build_list_view.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Notas',
          style: TextStyle(color: Colors.amber.shade600),
        ),
        centerTitle: true,
      ),
      body: provider.notes.isNotEmpty
          ? NoteBuildListView(provider: provider, scaffoldKey: _scaffoldKey)
          : EmptyNoteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NoteDetailsPage(isNotEmpty: false),
            ),
          );
        },
        elevation: 16.0,
        tooltip: 'New note',
        child: Icon(Icons.add, color: Colors.white, size: 32),
        backgroundColor: Colors.amber.shade700,
      ),
    );
  }
}
