import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:triva/Models/Clue.dart';
import 'package:triva/Models/SettingsModel.dart';

//https://proandroiddev.com/flutter-thursday-02-beautiful-list-ui-and-detail-page-a9245f5ceaf0 used for making nice looking tiles
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
                    return makeCard(context, Clue.clues[i]);
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

  Widget makeCard(BuildContext context, Clue clue) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.blue[800]),
        child: makeListTile(context, clue),
      ),
    );
  }

  Widget makeListTile(BuildContext context, Clue clue) {
    return ListTile(
        onTap: () {
          _showAnswer(context, clue);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(
          clue.question,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Icon(Icons.monetization_on, color: Colors.yellowAccent),
            Text(" ${clue.value}", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
          size: 30.0,
        ));
  }

  Future<void> _showAnswer(BuildContext context, Clue clue) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('What is....?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "${clue.answer}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
