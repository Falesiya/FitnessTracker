// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/excersicetile.dart';
import 'package:workout_app/data/workout_data.dart';

class WorkOutPage extends StatefulWidget {
  final String workoutName;
  const WorkOutPage({Key? key, required this.workoutName}) : super(key: key);

  @override
  State<WorkOutPage> createState() => _WorkOutPageState();
}

class _WorkOutPageState extends State<WorkOutPage> {
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  final excersiceController = TextEditingController();
  final weightController = TextEditingController();
   final repsController = TextEditingController();
    final setsController = TextEditingController();
// create a new excersice
  void createNewExercise(String workoutName) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text("Add New Excersice"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Excersice name
                  TextField(
                    controller: excersiceController,
                    decoration: InputDecoration(
                        hintText: "Enter the name of the excersice"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Excersice description-weight
                  TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                        hintText: "Enter the weight of the excersice"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //reps
                  TextField(
                    controller: repsController,
                    decoration: InputDecoration(
                        hintText: "Enter the reps of the excersice"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //sets
                  TextField(
                    controller: setsController,
                    decoration: InputDecoration(
                        hintText: "Enter the sets of the excersice"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              actions: [
                MaterialButton(onPressed:save,
                child:Text("save")),
                MaterialButton(onPressed: cancel,
                child: Text("cancel"))
              ],
            )));
  }
 void save() {
    //get excersice from textcontroller
    String createNewExercise = excersiceController.text;
    //add  excersiceto workout data list
    Provider.of<WorkoutData>(context, listen: false).addExercises(
     widget.workoutName,
     createNewExercise,
      weightController.text,
     repsController.text,
    setsController.text,
    );
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear(){

    excersiceController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.workoutName),
        ),
        floatingActionButton:
            FloatingActionButton(
              onPressed:() => createNewExercise(
                widget.workoutName,
              ),
            child: Icon(Icons.add),
            ),
            
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exercisename: value
                .getRelevantWorkout(widget.workoutName)
                .excersice[index]
                .name,
            weight: value
                .getRelevantWorkout(widget.workoutName)
                .excersice[index]
                .weight,
            sets: value
                .getRelevantWorkout(widget.workoutName)
                .excersice[index]
                .sets,
            reps: value
                .getRelevantWorkout(widget.workoutName)
                .excersice[index]
                .reps,
            isCompleted: value
                .getRelevantWorkout(widget.workoutName)
                .excersice[index]
                .isCompleted,
            onCheckBoxChanged: (val) => onCheckBoxChanged(
              widget.workoutName,
              value
                  .getRelevantWorkout(widget.workoutName)
                  .excersice[index]
                  .name,
            ),
          ),
        ),
      ),
    );
  }
}
