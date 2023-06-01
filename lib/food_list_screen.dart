import 'dart:convert';
import 'package:flutter/material.dart';
import 'food.dart';
import 'package:http/http.dart' as http;
import 'food_detail_screen.dart';


class FoodListScreen extends StatefulWidget {
  final String food;

  const FoodListScreen({required this.food});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  TextEditingController searchController = TextEditingController();
  List<Food> allFoods = [];
  List<Food> filteredFoods = [];


  Future<List<Food>> getFoods() async {
    String url = 'https://www.themealdb.com/api/json/v1/1/categories.php';

    var response = await http.get(Uri.parse(url));

    List<Food> foods = [];
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      var foodsJsonList = jsonResponse['categories'];

      for (var jsonFood in foodsJsonList) {
        Food food = Food.fromMap(jsonFood);
        foods.add(food);
      }
    }

    return foods;
  }

  void filterFoods(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredFoods = allFoods;
      } else {
        filteredFoods = allFoods
            .where((food) =>
            food.strCategory.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getFoods().then((foods) {
      setState(() {
        allFoods = foods;
        filteredFoods = foods;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: FutureBuilder<List<Food>>(
          future: getFoods(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Food> foods = snapshot.data as List<Food>;

              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 140,
                            width: double.infinity,
                            color: Colors.black,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage("https://wallpapers.com/images/hd/cute-profile-picture-jeik5d6qizh6dxxr.jpg")),
                                            borderRadius: BorderRadius.circular(25),
                                            border: Border.all(
                                              color: Colors.white,
                                              style: BorderStyle.solid,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Hi, welcome to our application ", style: TextStyle(color: Colors.white, fontSize: 16),)
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.topRight,
                                      child:Icon(Icons.notifications_active,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: TextField(
                                    controller: searchController,
                                    onChanged: filterFoods,

                                    cursorHeight: 20,
                                    autofocus: false,
                                    decoration:
                                    InputDecoration(
                                        hintText: 'Cari Negara Favoritemu',
                                        prefixIcon: Icon(Icons.search),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey, width: 2),
                                            borderRadius: BorderRadius.circular(30)


                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 550,
                                color: Colors.white,
                                child:
                                ListView.builder(
                                    itemCount: filteredFoods.length,
                                    itemBuilder: (context, index) {
                                      Food food = filteredFoods[index];


                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                            return FoodDetailScreen(food: food);
                                          }));
                                        },
                                        child: Card(

                                          child: Row(
                                            children: [
                                              SizedBox(
                                                  width: 100,
                                                  height: 90,
                                                  child: Hero(
                                                    tag: food.strCategoryDescription,
                                                    child: Image.network(
                                                      food.strCategoryThumb,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                              SizedBox(width: 15),
                                              Text(food.strCategory, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),


                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
