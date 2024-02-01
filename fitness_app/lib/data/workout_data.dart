import 'package:flutter/material.dart';
import 'package:workout_app/data/hive_database.dart';
import 'package:workout_app/model/excersicemodel.dart';
import 'package:workout_app/model/workoutmodel.dart';

class WorkoutData extends ChangeNotifier {
  final db = ExerciseDatabase(); // Corrected initialization

  List<Workout> workoutList = [
    // Default workouts
    Workout(name: "Upper Body", excersice: [
      Exercise(
        name: 'Bicep Curls',
        sets: "4",
        reps: "10",
        weight: "100",
      )
    ]),
    Workout(
      name: "Lower Body",
      excersice: [
        Exercise(
          name: 'Squats',
          sets: "5",
          reps: "15",
          weight: "100",
        )
      ],
    ),
  ];

  // Initialize workout list from database if available
  void initializedWorkoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDatabase();
      notifyListeners();
    } else {
      db.saveToDatabase(workoutList);
    }
  }

  // Get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // Get the number of exercises in a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.excersice.length;
  }

  // Add a workout
  void addWorkOut(String name) {
    // Add a new workout with a blank list of exercises
    workoutList.add(Workout(name: name, excersice: []));
    notifyListeners();
  }

  // Add an exercise to a workout
  void addExercises(String workoutName, String exerciseName, String weight, String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.excersice.add(Exercise(
      name: exerciseName,
      sets: sets,
      reps: reps,
      weight: weight,
    ));
    notifyListeners();
  }

  // Check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    // Find the relevant workout and relevant exercise in that workout
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

  // Return relevant workout object given a workout name
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout = workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  // Return relevant exercise object given a workout name and exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    // Find relevant workout first
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise = relevantWorkout.excersice.firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }
}
