import 'SettingsModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Clue {
  final int id;
  final String answer;
  final String question;
  final int value;
  final String airdate;
  final int category_id;
  final int game_id;
  final int invalid_count;

  static List<Clue> clues = [];

  Clue(
      {this.id,
      this.answer,
      this.question,
      this.value,
      this.airdate,
      this.category_id,
      this.game_id,
      this.invalid_count});

  factory Clue.fromJson(Map<String, dynamic> json) {
    return Clue(
        id: json['id'],
        answer: json['answer'],
        question: json['question'],
        value: json['value'],
        airdate: json['airdate'],
        category_id: json['category_id'],
        game_id: json['game_id'],
        invalid_count: json['invalid_count']);
  }

  static Future<List<Clue>> fetch(SettingsModel settings) async {
    final response = await http.get(settings.url);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      clues.clear();
      for (var clue in json.decode(response.body)['clues']) {
        clues.add(Clue.fromJson(clue));
      }
      return clues;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load clues');
    }
  }
}
