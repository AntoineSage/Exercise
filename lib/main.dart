import 'package:flutter/material.dart';
import 'Exercise.dart';
import 'ExerciseButton.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Exercise',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: new MyHomePage(title: 'Exercise Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Exercise pompes = new Exercise(
      "Toto",
      new Icon(Icons.directions_run),
      Colors.white);

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        leading: new Icon(Icons.directions_run),
        title: new Text(widget.title),
      ),
      body: new GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 10.0,
        crossAxisCount: 4,
        children: <Widget>[
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
          new ExerciseButton(context, pompes, _scaffoldKey),
        ],
      )
    );
  }
}