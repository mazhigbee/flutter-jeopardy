// BEFORE -- Not working, pre-state pushup
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:triva/Models/SettingsModel.dart';
import 'Models/Clue.dart';
import 'package:triva/Views/MyCluesView.dart';
import 'package:triva/Views/MyAppDrawer.dart';

const String appTitle = "Quick Trivia!";

void main() {
  final settings = new SettingsModel();

  return runApp(ScopedModel<SettingsModel>(
      child: MyApp(title: settings.getChosenCategory.title), model: settings));
}

class MyApp extends StatelessWidget {
  final String title;

  MyApp({this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: this.title,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: new MainScreen());
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SettingsModel>(
        builder: (context, child, settings) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Category: ${settings.getChosenCategory.title}"),
          ),
          drawer: new MyAppDrawer(),
          body: Center(child: MyCluesView()));
    });
  }
}
