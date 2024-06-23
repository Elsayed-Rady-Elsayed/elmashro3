import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/screens/cart_screen.dart';
import 'package:elmashro3/screens/homeScreen.dart';
import 'package:elmashro3/screens/profileServices.dart';
import 'package:elmashro3/screens/recycling.dart';
import 'package:elmashro3/screens/recyclingHelper.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/links.dart';
class MainPage extends StatefulWidget {
  static const routeName = "/MainPage";
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var Screens = [
    HomeScreen(),
    CartScreen(),
    // recyclingMainPage(),
    RecyclingHelper(),
    ProfileServices(),
  ];
  var TabIndx = 0;
  @override
  var oId = 0;
crud c = crud();

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        unselectedItemColor: kGreyShade3,
        selectedItemColor: kPrimaryGreen,
        currentIndex: TabIndx,
        onTap: (v){
          setState(() {
            TabIndx = v;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "cart"),
          BottomNavigationBarItem(icon: Icon(Icons.recycling),label: "recycling"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "profile"),
        ],
      ),
      body: Screens[TabIndx],
    );
  }
}
