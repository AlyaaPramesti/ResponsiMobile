import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'food.dart';

class FoodDetailScreen extends StatelessWidget {

  final Food food;


  const FoodDetailScreen({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text('Country Details', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),

      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Hero(
                tag: food.strCategoryDescription,
                child: SvgPicture.network(food.strCategoryThumb, width: 100,)),
          ),

          Text(food.strCategory, style: TextStyle(fontSize: 30),),

        ],
      ),
    );
  }
}



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'food_subdetail_screen.dart';
// import 'food.dart';
//
// class ListMakananPage extends StatefulWidget {
//   final String category;
//
//   const ListMakananPage({required this.category});
//
//   @override
//   _ListMakananPageState createState() => _ListMakananPageState();
// }
//
// class _ListMakananPageState extends State<ListMakananPage> {
//   List makanan = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchMakananByCategory();
//   }
//
//   Future<void> fetchMakananByCategory() async {
//     final response = await http.get(
//       Uri.parse(
//           'https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.category}'),
//     );
//
//     if (response.statusCode == 200) {
//       setState(() {
//         makanan = json.decode(response.body)['meals'];
//       });
//     }
//   }
//
//   void navigateToDetailPage(String id) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DetailMakananPage(id: id),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('List Makanan'),
//         ),
//         body: ListView.builder(
//             itemCount: makanan.length,
//             itemBuilder: (context, index) {
//               final makananItem = makanan[index];
//               return ListTile(
//                 title: Text(makananItem['strMeal']),
//                 onTap: () {
//                   navigateToDetailPage(makananItem['idMeal']);
//                 },
//               );
//             },
//             ),
//         );
//     }
// }