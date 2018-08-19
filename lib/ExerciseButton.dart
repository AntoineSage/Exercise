import 'package:flutter/material.dart';
import 'Exercise.dart';
import 'ExerciseSheet.dart';

class ExerciseButton extends StatelessWidget{
  final Exercise exercise;
  final BuildContext context;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  ExerciseButton(this.context, this.exercise, this._scaffoldKey);

  @override
  Widget build (BuildContext context) {
    return new Column(
      children: <Widget>[
        new IconButton(
          icon: exercise.icon,
          onPressed: _exerciseSheet,
          iconSize: 40.0,
          splashColor: exercise.color,),
        new Text(exercise.title),
      ],
    );
  }

  void _exerciseSheet() {
    _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
      return new ExerciseSheet(exercise);
    });
  }
}

/*
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return new ExerciseSheet(exercise);
      },
    );
*/