// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exercisename;
  final String weight;
  final String sets;
  final String reps;
  final bool isCompleted;
  void Function(bool?)? onCheckBoxChanged;
 ExerciseTile(
      {super.key,
      required this.exercisename,
      required this.weight,
      required this.sets,
      required this.reps,
      required this.isCompleted,
      required this.onCheckBoxChanged
     
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 236, 207, 207),
      child: ListTile(
        title: Text(exercisename),
        subtitle: Row(
          children: [
            Chip(
              label: Text(
                "${weight}kg",
              ),
            ),
            const SizedBox(width: 10),
            Chip(
              label: Text(
                "${reps}reps",
              ),
            ),
            const SizedBox(width: 10),
            Chip(
              label: Text(
                "${sets}sets",
              ),
            ),
          ],
        ),
        trailing: Checkbox(value: isCompleted, 
        onChanged: (value)=> onCheckBoxChanged),
      ),
    );
  }
}
