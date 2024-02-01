import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/pages/homepage.dart';

void main() async {
  //initialize hive
  await Hive.initFlutter();
  //open a hive box
  await Hive.openBox("Workout_database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WorkoutData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
            backgroundColor: Colors.deepPurple, // Adjust as needed
           // Adjust as needed
          ),
          // Other theme configurations...
        ),
        home: const HomePage(),
      ),
    );
  }
}
