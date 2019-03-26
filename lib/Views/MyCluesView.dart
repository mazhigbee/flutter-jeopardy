import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:triva/Models/Clue.dart';
import 'package:triva/Models/SettingsModel.dart';

//https://stackoverflow.com/questions/50530152/how-to-create-expandable-listview-in-flutter exandable list tile..

class MyCluesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SettingsModel>(
        builder: (context, child, settings) {
      return new FutureBuilder(
          future: Clue.fetch(settings),
          builder: (BuildContext context, AsyncSnapshot<List<Clue>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: Clue.clues.length,
                  itemBuilder: (context, i) {
                    return ExpansionTile(
                      title: Text(Clue.clues[i].question),
                      children: <Widget>[_showAnswer(Clue.clues[i])],
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("Error fetching data");
            } else {
              return CircularProgressIndicator();
            }
          });
    } // end ScopedModelDescendant
        );
  }

  Widget _showAnswer(Clue clue) {
    return Text(clue.answer, style: TextStyle(color: Colors.red));
  }
}
