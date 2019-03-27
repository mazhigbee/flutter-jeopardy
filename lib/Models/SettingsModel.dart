import 'package:scoped_model/scoped_model.dart';
import 'Category.dart';

class SettingsModel extends Model {
  Category _chosenCategory = Category(
      id: 11497, title: "drink", clues_count: 5); //drinks is the default
  static const _apiURL = "http://jservice.io/api/";
  static const categoriesUrl = _apiURL + "categories?count=100";

  String get url => _apiURL + "category?id=" + _chosenCategory.id.toString();

  Category get getChosenCategory => _chosenCategory;

  void setCategory(Category chosenCategory) {
    _chosenCategory = chosenCategory;
    notifyListeners();
  }
}
