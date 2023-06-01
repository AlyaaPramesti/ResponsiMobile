class Food {
  late String strCategory;
  late String strCategoryThumb;
  late String strCategoryDescription;
  late String strMeal;
  late String strMealThumb;
  late String idMeal;

  Food({
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  // convert map to Country object
  Food.fromMap( Map<String, dynamic> map){
    strCategory = map['strCategory'];
    strCategoryThumb = map['strCategoryThumb'];
    strCategoryDescription = map['strCategoryThumb'];
    strMeal = map['strMeal'];
    strMealThumb = map['strMealThumb'];
    idMeal = map['idMeal'];
  }
}