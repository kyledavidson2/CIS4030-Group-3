import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'global_widgets.dart';
import 'add_room.dart';
import 'home.dart';
import 'classes/all_state.dart';
void main() {
  runApp(
      ChangeNotifierProvider(
          create: (context) =>  AllStates(),
          child: const MaterialApp(
            home: HomePage(),
          )
      ) );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage()
    );
  }
}


