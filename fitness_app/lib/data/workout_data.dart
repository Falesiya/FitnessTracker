import 'package:flutter/material.dart';
import 'package:workout_app/model/excersicemodel.dart';
import 'package:workout_app/model/workoutmodel.dart';

class WorkoutData extends ChangeNotifier{
  List<Workout> workoutList = [
    //default workout
    Workout(name: "Upper Body", excersice: [
      Exercise(
        name: 'Bicep Curls',
        sets: "4",
        reps: "10",
        weight: "100",
      )
    ]),
      Workout(
      name: "Lower Body", excersice: [
      Exercise(
        name: 'Squats',
        sets: "5",
        reps: "15",
        weight: "100",
      )
    ]),
  ];
  //get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

//get length of a given workout

  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.excersice.length;
  }

// add a workout
  void addWorkOut(String name) {
    //add a new workot with a blank list of exercise
    workoutList.add(Workout(name: name, excersice: []));
    notifyListeners();
  }

//add an erercise to a workout
  void addExercises(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.excersice.add(Exercise(
      name: exerciseName,
      sets: sets,
      reps: reps,
      weight: weight,
    ));

    notifyListeners();
  }
  //check off exercise

  void checkOffExercise(String workoutName, String exerciseName) {
//find out the relevant workout and relevant exercise in that workout
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    relevantExercise.isCompleted=!relevantExercise.isCompleted;
    notifyListeners();
    
  }

//return relevant workout object,given a workout name
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
        return relevantWorkout;
  }

//return relevant exercise object,given a workout name+excersice name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
//find relevant WORKOUT first
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise = relevantWorkout.excersice
        .firstWhere((excersice) => excersice.name == exerciseName);
        return relevantExercise;
  }
}
