class Meal {
  late String strMeal;
  late String strMealThumb;
  late String idMeal;

  Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });


  Meal.fromMap( Map<String, dynamic> map){
    strMeal = map['strMeal'];
    strMealThumb = map['strMealThumb'];
    idMeal = map['idMeal'];
  }
}