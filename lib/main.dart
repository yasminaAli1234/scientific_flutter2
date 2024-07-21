
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Scientific/ScientificCommitted.dart';
import 'model/material_provider.dart';
import 'model/member_provider.dart';
import 'model/provider.dart';
import 'tasks/task_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => provider()), // Change this to your actual provider class
        ChangeNotifierProvider(create: (_) => MemberProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => MaterialProvider()),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '',

            supportedLocales: const [
              Locale('en'), // English
              Locale('es'), // Spanish
              Locale('ar'), //arbic
            ],
            theme: ThemeData(primarySwatch: Colors.amber),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home:  ScientificCommitted(), // Replace with your desired home screen widget
          );
        },
      ),
    );
  }
}

