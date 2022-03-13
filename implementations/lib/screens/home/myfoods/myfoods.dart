import 'package:flutter/material.dart';
import 'package:foodbook/models/foods.dart';
import 'package:foodbook/screens/home/myfoods/myfoodslist.dart';
import 'package:foodbook/services/database.dart';
import 'package:provider/provider.dart';

class MyFoods extends StatefulWidget {
  @override
  _MyFoodsState createState() => _MyFoodsState();
}

class _MyFoodsState extends State<MyFoods> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Food>>.value(
      value: DatabaseService().userFood,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
        child: MyFoodsList(),
      ),
    );
  }
}
