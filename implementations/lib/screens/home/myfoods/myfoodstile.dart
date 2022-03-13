import 'package:flutter/material.dart';
import 'package:foodbook/models/foods.dart';
import 'package:foodbook/services/database.dart';

class MyFoodTile extends StatelessWidget {
  final Food food;
  MyFoodTile({this.food});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/foodpage', arguments: {
                'name': food.name,
                'ingredients': food.ingredients,
                'recipe': food.recipe,
                'calories': food.calories,
                'URL': food.urlname,
              });
            },
            leading: CircleAvatar(
              child: Container(
                height: 100,
                width: 100,
                child: Image.network(
                  food.urlname ??
                      'https://firebasestorage.googleapis.com/v0/b/food-project-7fbaa.appspot.com/o/images%2Fdefault_im.jpg?alt=media&token=e67a4270-5fd1-4ede-b37d-618cf037ab9d',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
                'Name: ${food.name.length > 10 ? food.name.substring(0, 10) + '...' : food.name}'),
            subtitle: Text(
                'Ing: ${food.ingredients.length > 10 ? food.ingredients.substring(0, 10) + '...' : food.ingredients}'),
            trailing: Text(
                'Cal: ${food.calories.length > 10 ? food.calories.substring(0, 10) + '...' : food.calories}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                  color: Colors.pink[400],
                  onPressed: () {
                    DatabaseService().deletefood(food.name);
                  },
                  child: Text('delete')),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              RaisedButton(
                  child: Text('Edit'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/updatefood', arguments: {
                      'name': food.name,
                      'ingredients': food.ingredients,
                      'recipe': food.recipe,
                      'calories': food.calories,
                      'URL': food.urlname,
                    });
                  })
            ],
          ),
        ],
      ),
    );
  }
}
