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
  void  onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.workoutName),
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

                  onCheckBoxChanged:(val)=> onCheckBoxChanged(
                  widget.workoutName,
                  value.getRelevantWorkout(widget.workoutName).excersice[index].name,
                  ),),
        ),
      ),
    );
  }
}
