import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:notas/features/notes/data/datasources/note_local_data_source.dart';
import 'package:notas/features/notes/data/repositories/note_repository_impl.dart';
import 'package:notas/features/notes/domain/entities/note.dart';
import 'package:notas/features/notes/domain/repositories/note_repository_abstract.dart';
import 'package:notas/features/notes/domain/usecases/add_note.dart';
import 'package:notas/features/notes/domain/usecases/delete_note.dart';
import 'package:notas/features/notes/domain/usecases/edit_note.dart';
import 'package:notas/features/notes/domain/usecases/get_all_notes.dart';
import 'package:notas/features/notes/presentation/provider/note_provider.dart';

final sl = GetIt.instance;

final Color accentColor = Colors.amber.shade600;

Future<void> init() async {
  //! Hive
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(NoteAdapter());
  final box = await Hive.openBox<Note>('note');

  //! Notifications
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: accentColor,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        playSound: true,
        enableLights: true,
        enableVibration: true,
        onlyAlertOnce: true,
        soundSource: 'resource://raw/res_custom_notification',
      ),
    ],
  );

  // Providers
  sl.registerFactory(
    () => NoteProvider(
      repository: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => AddNote(sl()));
  sl.registerLazySingleton(() => EditNote(sl()));
  sl.registerLazySingleton(() => DeleteNote(sl()));
  sl.registerLazySingleton(() => GetAllNotes(sl()));

  // Repository
  sl.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<NoteLocalDataSource>(
    () => NoteLocalDataSourceImpl(hive: box),
  );

  sl.registerLazySingleton<Box<Note>>(() => box);
}
