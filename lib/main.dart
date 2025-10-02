// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sqflite_database_project/Data/Local/db_helper.dart';
// import 'package:sqflite_database_project/Data/provider/db_provider.dart';
// import 'package:sqflite_database_project/ui/home.dart';
//
// void main() {
//   runApp(ChangeNotifierProvider(
//     create: (context) => DbProvider(dbHelper: DBHelper.getInstance),
//     child: const MyApp(),
//   ));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const Home(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_database_project/Data/Local/db_helper.dart';
import 'package:sqflite_database_project/Data/provider/db_provider.dart';
import 'package:sqflite_database_project/Data/provider/themeprovider.dart';
import 'package:sqflite_database_project/ui/home.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context) => DbProvider(dbHelper: DBHelper.getInstance)),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes Demo',
      themeMode: context.watch<ThemeProvider>().getThemeValue()
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
