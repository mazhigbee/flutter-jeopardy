import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:triva/Models/SettingsModel.dart';

import '../Models/Category.dart';

class MyAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SettingsModel>(
        builder: (context, child, settings) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                  'Jeporady Settings\n\nCurrent Category: ${settings.getChosenCategory.title}',
                  style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.1, 0.33, 0.6, 0.99],
                  colors: [
                    Colors.red[800],
                    Colors.red[600],
                    Colors.purple[400],
                    Colors.purple[200],
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    });
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
