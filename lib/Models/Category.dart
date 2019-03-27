import 'dart:convert';

import 'package:http/http.dart' as http;

class Category {
  int id;
  String title;
  int clues_count;

  Category({this.id, this.title, this.clues_count});

  static List<Category> categories = [];

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      clues_count: json['clues_count'],
    );
  }

  //todo fetch many clues at once..
  static Future<List<Category>> fetch(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      categories.clear();
      for (var category in json.decode(response.body)) {
        categories.add(Category.fromJson(category));
      }
      return categories;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load categories');
    }
  }
}
