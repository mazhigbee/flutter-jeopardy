import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:triva/Models/SettingsModel.dart';
import 'package:triva/Views/MyAppDrawer.dart';
import 'package:triva/Views/MyCluesView.dart';

import 'Models/Category.dart';

/**
 * Created by Mazlin Higbee
 * A flutter app to test your Jeopardy knowledge
 */

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
              title: FutureBuilder(
                  future: Category.fetch(SettingsModel.categoriesUrl),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Category>> snapshot) {
                    if (snapshot.hasData) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return ChooseCategoryDialog();
                            }));
                          },
                          child: Text(
                              "Category: ${settings.getChosenCategory.title}"));
                    } else if (snapshot.hasError) {
                      return Text("Error");
                    } else {
                      return CircularProgressIndicator();
                    }
                  })),
          drawer: new MyAppDrawer(),
          body: Center(child: MyCluesView()));
    });
  }
}
