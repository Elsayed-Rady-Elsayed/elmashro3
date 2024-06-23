import 'package:elmashro3/admin/screens/addProductScreen.dart';
import 'package:elmashro3/admin/screens/productsScreen.dart';
import 'package:elmashro3/admin/screens/recyclingScreen.dart';
import 'package:elmashro3/admin/screens/usersView.dart';
import 'package:elmashro3/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addCategory.dart';
class homeScreen extends StatefulWidget {
  static const rout = "/adminHomePage";

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int current = 0;
  List<Widget> screens = [
    usersViewScreen(),
    productsScreen(),
    recyclingScreen(),
    addCategory(),
  ];
  var title=[
    "users",
    "products",
    "recycling",
    "category"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title[current]),),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryGreen,
        unselectedItemColor: kAccentGreen,
        currentIndex: current,
        onTap: (v){
          setState(() {
            current = v;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.production_quantity_limits),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.recycling),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.category),label: "")
        ],
      ),
      body: screens[current],
      floatingActionButton: current==1?FloatingActionButton(onPressed: (){
        Navigator.of(context).pushNamed(addProductScreen.route);
      },child: Icon(Icons.add),):null,
    );
  }
}
