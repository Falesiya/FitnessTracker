// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/pages/workoutpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newWorkoutController = TextEditingController();
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("New Workout"),
        content: TextField(
          controller: newWorkoutController,
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text("Create"),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void save() {
    //get workout from textcontroller
    String newWorkoutname = newWorkoutController.text;
    //add workout to workout data list
    Provider.of<WorkoutData>(context, listen: false).addWorkOut(newWorkoutname);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

//to cleat dialogbox\
  void clear() {
    newWorkoutController.clear();
  }

//detail of Each Workout
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkOutPage(
                  workoutName: workoutName,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: ((context, value, child) => Scaffold(
            appBar: AppBar(
              title: const Text("Workout Tracker"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: createNewWorkout,
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
                itemCount: value.getWorkoutList().length,
                itemBuilder: (context, index) => ListTile(
                    title: Text(value.getWorkoutList()[index].name),
                    trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () => goToWorkoutPage(value.getWorkoutList()[index].name)
                        )
                        )
                        ),
          )),
    );
  }
}
