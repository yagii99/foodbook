import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:foodbook/services/database.dart';
import 'package:foodbook/models/foods.dart';

class UpdateFood extends StatefulWidget {
  @override
  _UpdateFoodState createState() => _UpdateFoodState();
}

class _UpdateFoodState extends State<UpdateFood> {
  final _formkey = GlobalKey<FormState>();
  String _currentingredients = '';
  String _currentrecipe = '';
  String _currentcalories = 'Not Specified';
  File _image;
  String imagemsg = '';
  final picker = ImagePicker();
  bool loading = false;
  void _imageFromGallery() async {
    PickedFile pickedimage = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    File image = File(pickedimage.path);
    setState(() {
      _image = image;
      imagemsg = image.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map _currentdata = ModalRoute.of(context).settings.arguments;
    final String _currentname = _currentdata['name'];
    final _oldingredients = _currentdata['ingredients'];
    final _oldcalories = _currentdata['calories'];
    final _oldrecipe = _currentdata['recipe'];
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit $_currentname',
            style: TextStyle(fontFamily: 'mvboli', color: Colors.black),
          ),
        ),
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background.jpg'),
                      fit: BoxFit.cover)),
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      initialValue: _oldingredients,
                      validator: (val) =>
                          val.isEmpty ? 'please enter Ingredients' : null,
                      decoration: InputDecoration(hintText: 'Ingredients'),
                      onChanged: (val) {
                        setState(() {
                          _currentingredients = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      initialValue: _oldcalories,
                      decoration: InputDecoration(hintText: 'Calories'),
                      onChanged: (val) {
                        setState(() {
                          _currentcalories = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      initialValue: _oldrecipe,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      validator: (val) =>
                          val.isEmpty ? 'please enter Recipe' : null,
                      decoration: InputDecoration(hintText: 'Recipe'),
                      onChanged: (val) {
                        setState(() {
                          _currentrecipe = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    RaisedButton(
                        color: Colors.grey[400],
                        child: Text('Add photo'),
                        onPressed: () {
                          _imageFromGallery();
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(imagemsg),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    RaisedButton(
                      child: Text('Edit food'),
                      color: Colors.pink[400],
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          DatabaseService().updateUserfoods(Food(
                              name: _currentname,
                              ingredients: _currentingredients.isEmpty
                                  ? _oldingredients
                                  : _currentingredients,
                              recipe: _currentrecipe.isEmpty
                                  ? _oldrecipe
                                  : _currentrecipe,
                              calories: _currentcalories.isEmpty
                                  ? _oldcalories
                                  : _currentcalories,
                              image: null));
                          Navigator.popAndPushNamed(context, '/wrapper');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
