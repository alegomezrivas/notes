import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas/features/notes/presentation/pages/note_details_page.dart';
import 'package:notas/features/notes/presentation/provider/note_provider.dart';

class NoteBuildListView extends StatelessWidget {
  final NoteProvider provider;
  const NoteBuildListView({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 12.0),
      physics: BouncingScrollPhysics(),
      itemCount: provider.notes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final note = provider.notes.elementAt(index);
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => NoteDetailsPage(
                  index: index,
                  note: note,
                  isNotEmpty: true,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              color: Colors.grey.shade900,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: note.title!.isNotEmpty,
                      child: Expanded(
                        flex: 1,
                        child: Text(
                          note.title!,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            letterSpacing: 0.8,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        note.content!,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          letterSpacing: 0.8,
                        ),
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            final snackBar = SnackBar(
                              content: const Text(
                                '¿Realmente desea eliminar esta nota?',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black54,
                              action: SnackBarAction(
                                label: 'Hecho',
                                textColor: Colors.amber.shade600,
                                onPressed: () {
                                  // Delete note.
                                  provider.deleteNotes(index);
                                },
                              ),
                            );
                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
