import 'package:flutter/material.dart';
import 'package:foodbook/models/foods.dart';
import 'package:foodbook/screens/home/myfoods/myfoodstile.dart';
import 'package:provider/provider.dart';

class MyFoodsList extends StatefulWidget {
  @override
  _MyFoodsListState createState() => _MyFoodsListState();
}

class _MyFoodsListState extends State<MyFoodsList> {
  @override
  Widget build(BuildContext context) {
    final foods = Provider.of<List<Food>>(context) ?? [];
    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) {
        return MyFoodTile(food: foods[index]);
      },
    );
  }
}
