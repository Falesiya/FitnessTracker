import 'package:hive/hive.dart';
import 'package:workout_app/datetime/datetime.dart';
import 'package:workout_app/model/excersicemodel.dart';
import 'package:workout_app/model/workoutmodel.dart';

class ExerciseDatabase {
  // reference hivebox
  final _myBox = Hive.box("Workout_database");

  // check if there is already data stored
  bool previousDataExists() {
    if (_myBox.isEmpty) {
      print("Previous data does not exist");
      _myBox.put("Start_Date", todaysDateYYMMDD());
      return false;
    } else {
      print("Previous data exists");
      return true;
    }
  }

  // return start date
  String getStartDate() {
    return _myBox.get("Start_Date");
  }

  void saveToDatabase(List<Workout> workouts) {
    final workoutList = convertObjectToWorkoutList(workouts);
    final exerciseList = convertObjectExerciseList(workouts);

    if (exerciseisCompleted(workouts)) {
      _myBox.put("Completion_Status_${todaysDateYYMMDD()}", 1);
    } else {
      _myBox.put("Completion_Status_${todaysDateYYMMDD()}", 0);
    }

    // Save into hive
    _myBox.put("Workouts", workoutList);
    _myBox.put("Exercises", exerciseList);
  }

  // read data and return a list of workouts
  List<Workout> readFromDatabase() {
    List<Workout> mySavedWorkouts = [];
    List<String> workoutNames = _myBox.get("Workouts");
    final exerciseDetails = _myBox.get("Exercises");

    for (int i = 0; i < workoutNames.length; i++) {
      List<Exercise> exerciseInEachWorkout = [];
      for (int j = 0; j < exerciseDetails[i].length; j++) {
        exerciseInEachWorkout.add(Exercise(
          name: exerciseDetails[i][j][0],
          weight: exerciseDetails[i][j][1],
          sets: exerciseDetails[i][j][2],
          reps: exerciseDetails[i][j][3],
          isCompleted: exerciseDetails[i][j][4] == "true" ? true : false,
        ));
      }
      // create individual workout
      Workout workout = Workout(name: workoutNames[i], excersice: exerciseInEachWorkout);
      // add individual workout to overall list
      mySavedWorkouts.add(workout);
    }
    return mySavedWorkouts;
  }

  // return completion status of a given date yyyy-mm-dd
  bool exerciseisCompleted(List<Workout> workouts) {
    // go through the workouts
    for (var workout in workouts) {
      for (var excersice in workout.excersice) {
        if (excersice.isCompleted) {
          return true;
        }
      }
    }
    return false;
  }

  int getCompletedStatus(String yyyymmdd) {
    int completionStatus = _myBox.get("Completion_Status_$yyyymmdd") ?? 0;
    return completionStatus;
  }

  // converts workout objects into a list
  List<String> convertObjectToWorkoutList(List<Workout> workouts) {
    List<String> workoutList = [];
    for (int i = 0; i < workouts.length; i++) {
      workoutList.add(workouts[i].name);
    }
    return workoutList;
  }

  // converts the exercise in a workout object into a List of strings
  List<List<List<String>>> convertObjectExerciseList(List<Workout> workouts) {
    List<List<List<String>>> exerciseList = [];

    // go through each workout
    for (int i = 0; i < workouts.length; i++) {
      // get exercise from each workout
      List<Exercise> exerciseInWorkout = workouts[i].excersice;
      List<List<String>> individualWorkout = [];

      // go through each exercise in exercise list
      for (int j = 0; j < exerciseInWorkout.length; j++) {
        List<String> individualExercise = [
          exerciseInWorkout[j].name,
          exerciseInWorkout[j].sets.toString(),
          exerciseInWorkout[j].reps.toString(),
          exerciseInWorkout[j].weight.toString(),
          exerciseInWorkout[j].isCompleted.toString(),
        ];
        individualWorkout.add(individualExercise);
      }
      exerciseList.add(individualWorkout);
    }
    return exerciseList;
  }
}
