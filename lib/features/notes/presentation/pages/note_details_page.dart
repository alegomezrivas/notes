import 'package:flutter/material.dart';
import 'package:notas/core/theme/app_theme.dart';
import 'package:notas/features/notes/domain/entities/note.dart';
import 'package:notas/features/notes/presentation/provider/note_provider.dart';
import 'package:provider/provider.dart';

class NoteDetailsPage extends StatefulWidget {
  final Note? note;
  final int? index;
  final bool isNotEmpty;

  const NoteDetailsPage({
    Key? key,
    required this.isNotEmpty,
    this.note,
    this.index,
  }) : super(key: key);
  @override
  _NoteDetailsPageState createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isNotEmpty) {
      _title.text = widget.note?.title ?? '';
      _content.text = widget.note?.content ?? '';
    }
  }

  @override
  void dispose() {
    _title.clear();
    _content.clear();
    super.dispose();
  }

  void validate(NoteProvider provider) {
    _formKey.currentState!.save();
    FocusScope.of(context).unfocus();
    final note = Note(title: _title.text, content: _content.text);
    if (widget.isNotEmpty) {
      provider.editNotes(widget.index, note);
    } else {
      provider.addNotes(note);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoteProvider>(context);
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.canvas,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            validate(provider);
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: colors.text,
            size: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                TextFormField(
                  enableInteractiveSelection: false,
                  controller: _title,
                  cursorColor: colors.accent,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                    color: colors.text,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Título',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      letterSpacing: 0.2,
                      color: colors.textHint,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => _title.text = value!,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  autofocus: true,
                  controller: _content,
                  cursorColor: colors.accent,
                  enableInteractiveSelection: false,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                    color: colors.textEditor,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration.collapsed(hintText: ''),
                  maxLines: 50,
                  onSaved: (value) => _content.text = value!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
