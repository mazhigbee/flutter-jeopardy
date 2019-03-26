import 'package:scoped_model/scoped_model.dart';
import 'Category.dart';
class SettingsModel extends Model {
  Category _chosenCategory = Category(id:11497,title:"drink",clues_count:5); //drinks
  static const _apiURL = "http://jservice.io/api/";
  //http://jservice.io/api/category?id=11497

  static const categoriesUrl = _apiURL + "categories?count=100";

  String get url =>
      _apiURL + "category?id=" + _chosenCategory.id.toString();

  Category get getChosenCategory => _chosenCategory;

  void setCategory(Category chosenCategory){
    _chosenCategory = chosenCategory;
    notifyListeners();
  }
}