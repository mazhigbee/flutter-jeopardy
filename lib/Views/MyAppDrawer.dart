import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:triva/Models/SettingsModel.dart';
import '../Models/Category.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SettingsModel>(
        builder: (context, child, settings) {
          return Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the Drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Jeporady Settings\n\nCurrent Category: ${settings.getChosenCategory.title}',
                      style: TextStyle(color: Colors.white)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      // Where the linear gradient begins and ends
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      stops: [0.1, 0.5, 0.7, 0.9],
                      colors: [
                        Colors.blue[800],
                        Colors.blue[600],
                        Colors.yellow[400],
                        Colors.yellow[200],
                      ],
                    ),
                    color: Colors.black87,
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.category),
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
                                child: Text("Choose a category"));
                          } else if (snapshot.hasError) {
                            return Text("Error fetching data");
                          } else {
                            return CircularProgressIndicator();
                          }
                        })),
                ListTile(
                  title: Text('Close'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}

class ChooseCategoryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SettingsModel>(
        builder: (context, child, settings) {
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Choose a category.'),
            ),
            body: ListView.builder(
                itemCount: Category.categories.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                      onTap: () {
                        settings.setCategory(Category.categories[i]);
                        Navigator.pop(context);
                      },
                      title: Text(Category.categories[i].title));
                }),
          );
        });
  }
}
