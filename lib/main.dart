import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:notas/core/theme/app_theme.dart';
import 'package:notas/core/theme/theme_provider.dart';
import 'package:notas/features/notes/domain/repositories/note_repository_abstract.dart';
import 'package:notas/features/notes/presentation/pages/notes_page.dart';
import 'package:notas/features/notes/presentation/provider/note_provider.dart';
import 'injection_dependencies.dart' as di;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(box: di.sl<Box<String>>()),
        ),
        ChangeNotifierProvider(
          create: (_) => NoteProvider(
            repository: di.sl<NoteRepository>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Notas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: context.watch<ThemeProvider>().mode,
      builder: (context, child) {
        final colors = context.colors;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            systemNavigationBarColor: colors.canvas,
            systemNavigationBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
          ),
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.noScaling),
            child: child!,
          ),
        );
      },
      home: NotePage(),
    );
  }

  @override
  void dispose() {
    Hive.box('note').compact();
    Hive.close();
    super.dispose();
  }
}
