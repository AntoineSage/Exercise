import 'package:flutter/material.dart';
import 'Exercise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ExerciseSheet extends StatefulWidget{
  final Exercise exercise;
  ExerciseSheet(this.exercise);

  @override
  _ExerciseSheetState createState() => _ExerciseSheetState(exercise);
}

class _ExerciseSheetState extends State<ExerciseSheet> {
  Exercise exercise;

  double height = 330.0;
  IconData arrowIcon = Icons.keyboard_arrow_up;

  _ExerciseSheetState(this.exercise);

  @override
  Widget build (BuildContext context) {
    DocumentReference firestore = Firestore.instance.collection('Utilisateurs').document('Xyphos');

    return new Container(
      height: 330.0,
      child: new Hero(
        tag: "test",
        child : GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails details) {
            if (details.primaryDelta < -15.0) {
              switchHeight();
            } else if (details.primaryDelta > 15.0) {
              Navigator.of(context).pop();
            }
          },
          child: new Scaffold(
            appBar: new AppBar(
              title: new Text(exercise.title),
              leading: exercise.icon,
              actions: <Widget>[
                new IconButton(icon: new Icon(Icons.info_outline), onPressed: null),
                new IconButton(icon: new Icon(Icons.settings), onPressed: null),
                new IconButton(icon: new Icon(arrowIcon), onPressed: switchHeight),
              ],
            ),
            backgroundColor: exercise.color,
            body: new ListView( //TODO : partager le body avec l'ExerciceSheetExpanded et un maximum d'autres parties !
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    Expanded(
                      child : new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 20.0),
                        child: new Slider(
                            value: exercise.repNumber.toDouble(),
                            min:0.0,
                            max: 15.0,
                            divisions: 16,
                            onChanged: repSliderUpdate),
                      ),
                    ),
                    new Text("X ${exercise.repNumber}"),
                    new Icon(Icons.repeat),
                  ],
                ), // repRow
                new Row(
                  children: <Widget>[
                    Expanded(
                      child : new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 20.0),
                        child: new Slider(
                            value: exercise.pauseTime.toDouble(),
                            min:5.0,
                            max: 30.0,
                            divisions: 25,
                            onChanged: timeSliderUpdate),
                      ),
                    ),
                    new Text("${exercise.pauseTime}'"),
                    new Icon(Icons.timer),
                  ],
                ), // timeRow
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(child: IconButton(icon: new Icon(Icons.add_circle), iconSize: 96.0, onPressed: addLog)),
                    new Expanded(child: IconButton(icon: new Icon(Icons.pause_circle_filled), iconSize: 96.0,onPressed: null)),
                  ],
                ), // buttonsRow
                new StreamBuilder<QuerySnapshot>(
                  stream : firestore.collection('UserLog').where('Exercice', isEqualTo: 'Pompes').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return const Text('Loading...');
                    return new Text(snapshot.data.documents.length.toString());
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addLog() {
    Firestore.instance.collection('Utilisateurs').document('Xyphos').collection('UserLog')
        .document(DateTime.now().toString()).setData({'Exercice': exercise.title, 'Rep' : exercise.repNumber, 'Date' : DateTime.now()});
  }

  void switchHeight(){
    Navigator.of(context).push(MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new ExerciseSheetExpanded(exercise);
          },
        ),
    );
  }

  void repSliderUpdate(double value){
    setState(() {
      exercise.repNumber = value.toInt();
    });
  }

  void timeSliderUpdate(double value){
    setState(() {
      exercise.pauseTime = value.toInt();
    });
  }
}

class ExerciseSheetExpanded extends StatefulWidget{
  final Exercise exercise;
  ExerciseSheetExpanded(this.exercise);

  @override
  _ExerciseSheetExpandedState createState() => _ExerciseSheetExpandedState(exercise);
}

class _ExerciseSheetExpandedState extends State<ExerciseSheetExpanded> {
  Exercise exercise;

  double height = 330.0;
  IconData arrowIcon = Icons.keyboard_arrow_up;

  _ExerciseSheetExpandedState(this.exercise);

  @override
  Widget build(BuildContext context) {
    return new Hero(
      tag: "test",
      child: GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails details) {
          if (details.primaryDelta > 5.0) {
            pop();
          }
        },
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text(exercise.title),
            leading: exercise.icon,
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.info_outline), onPressed: null),
              new IconButton(icon: new Icon(Icons.settings), onPressed: null),
              new IconButton(icon: new Icon(Icons.keyboard_arrow_down), onPressed: pop),
            ],
          ),
          backgroundColor: exercise.color,
          body: new ListView(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Expanded(
                    child : new Padding(
                      padding: new EdgeInsets.symmetric(vertical: 20.0),
                      child: new Slider(
                          value: exercise.repNumber.toDouble(),
                          min:0.0,
                          max: 15.0,
                          divisions: 16,
                          onChanged: repSliderUpdate),
                    ),
                  ),
                  new Text("X ${exercise.repNumber}"),
                  new Icon(Icons.repeat),
                ],
              ), // repRow
              new Row(
                children: <Widget>[
                  Expanded(
                    child : new Padding(
                      padding: new EdgeInsets.symmetric(vertical: 20.0),
                      child: new Slider(
                          value: exercise.pauseTime.toDouble(),
                          min:5.0,
                          max: 30.0,
                          divisions: 25,
                          onChanged: timeSliderUpdate),
                    ),
                  ),
                  new Text("${exercise.pauseTime}'"),
                  new Icon(Icons.timer),
                ],
              ), // timeRow
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(child: IconButton(icon: new Icon(Icons.add_circle), iconSize: 96.0, onPressed: null)),
                  new Expanded(child: IconButton(icon: new Icon(Icons.pause_circle_filled), iconSize: 96.0,onPressed: null)),
                ],
              ), // buttonsRow

            ],
          ),
        ),
      ),
    );
  }

  void pop(){
    Navigator.of(context).pop();
  }

  void repSliderUpdate(double value){
    setState(() {
      exercise.repNumber = value.toInt();
    });
  }

  void timeSliderUpdate(double value){
    setState(() {
      exercise.pauseTime = value.toInt();
    });
  }
}