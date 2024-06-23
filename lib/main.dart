import 'dart:ui';

import 'package:elmashro3/admin/auth/login.dart';
import 'package:elmashro3/admin/screens/addProductScreen.dart';
import 'package:elmashro3/admin/screens/home.dart';
import 'package:elmashro3/admin/screens/productsScreen.dart';
import 'package:elmashro3/admin/screens/recyclingScreen.dart';
import 'package:elmashro3/admin/screens/userinfo.dart';
import 'package:elmashro3/admin/screens/usersView.dart';
import 'package:elmashro3/admin/screens/viewproductdetails.dart';
import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/screens/MainPage.dart';
import 'package:elmashro3/screens/SpecailOffers.dart';
import 'package:elmashro3/screens/add_address.dart';
import 'package:elmashro3/screens/cart_screen.dart';
import 'package:elmashro3/screens/categoryScreen.dart';
import 'package:elmashro3/screens/changeAddress.dart';
import 'package:elmashro3/screens/changePassword.dart';
import 'package:elmashro3/screens/checkOutScreen.dart';
import 'package:elmashro3/screens/forgotPassword.dart';
import 'package:elmashro3/screens/fruitScreen.dart';
import 'package:elmashro3/screens/homeScreen.dart';
import 'package:elmashro3/screens/introScreen.dart';
import 'package:elmashro3/screens/login.dart';
import 'package:elmashro3/screens/mapScreen.dart';
import 'package:elmashro3/screens/myProfileScreen.dart';
import 'package:elmashro3/screens/orderSummary.dart';
import 'package:elmashro3/screens/popularDealScreen.dart';
import 'package:elmashro3/screens/productDetails.dart';
import 'package:elmashro3/screens/recycling.dart';
import 'package:elmashro3/screens/recyclingHelper.dart';
import 'package:elmashro3/screens/recyclingRecipe.dart';
import 'package:elmashro3/screens/searchScreen.dart';
import 'package:elmashro3/screens/signUpScreen.dart';
import 'package:elmashro3/screens/successPayment.dart';
import 'package:elmashro3/screens/uplodeOrTakePictureScreen.dart';
import 'package:elmashro3/screens/vegetableScreen.dart';
import 'package:elmashro3/utils/customTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/SpecialDealChild.dart';
import 'screens/landingScreen.dart';
import 'screens/profileServices.dart';
late SharedPreferences sharedPreferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints.maxWidth);
        final customTheme = CustomTheme(constraints);
        return MaterialApp(
          builder: FToastBuilder(),
          debugShowCheckedModeBanner: false,
          title: 'Green Market',
          theme: ThemeData(
            primarySwatch: Colors.green,
            textTheme: customTheme.nunito(),
            elevatedButtonTheme: customTheme.elevatedButtonTheme(),
            outlinedButtonTheme: customTheme.outlinedButtonTheme(),
            dividerTheme: DividerThemeData(color: kGreyShade3,thickness: 2),
          ),
         // home: loginScreenAdmin(),
            initialRoute: sharedPreferences.getString("id")==null?LandingScreen.routeName:MainPage.routeName,
          // home: LandingScreen(),
          routes: {
            LandingScreen.routeName:(ctx)=>LandingScreen(),
            IntroScreen.routeName: (ctx) => IntroScreen(),
            loginScreen.routName: (ctx) => loginScreen(),
            registerScreen.routeName: (ctx) => registerScreen(),
            addAddressScreen.routeName: (ctx) => addAddressScreen(),
            mapScreen.routeName: (ctx) => mapScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            searchScreen.routeName: (ctx) => searchScreen(),
            vegetableScreen.routeName: (ctx) => vegetableScreen(),
            fruitScreen.routeName: (ctx) => fruitScreen(),
            CategoryScreen.routeName: (ctx) => CategoryScreen(),
            PopularDealScreen.routeName:(ctx)=>PopularDealScreen(),
            SpecialOffers.routeName:(ctx)=>SpecialOffers(),
            SpecialDealChildScreen.routeName :(ctx)=>SpecialDealChildScreen(),
            productDetails.routeName:(ctx)=>productDetails(),
            orderSummary.routeName:(ctx)=>orderSummary(),
            CheckOutScreen.routeName:(ctx)=>CheckOutScreen(),
            SuccessPaymentScreen.routeName:(ctx)=>SuccessPaymentScreen(),
            myProfileScreen.routeName:(ctx)=>myProfileScreen(),
            CartScreen.routeName:(ctx)=>CartScreen(),
            MainPage.routeName:(ctx)=>MainPage(),
            LandingScreen.routeName :(ctx)=>LandingScreen(),
            uplodeOrTakePictrureScreen.routeName :(ctx)=>uplodeOrTakePictrureScreen(),
            RecipeRecycleScreen.routeName:(ctx)=>RecipeRecycleScreen(),
            RecyclingHelper.routeName :(ctx)=>RecyclingHelper(),
            recyclingMainPage.routeName : (ctx)=>recyclingMainPage(),
            ForgotPassword.routName:(ctx)=>ForgotPassword(),
            changePassword.routeName:(ctx)=>changePassword(),
            editAddressScreen.routeName :(ctx)=>editAddressScreen(),
            homeScreen.rout:(ctx)=>homeScreen(),
            usersViewScreen.route:(ctx)=>usersViewScreen(),
            productsScreen.route:(ctx)=>productsScreen(),
            recyclingScreen.route:(ctx)=>recyclingScreen(),
            userinfo.route : (ctx)=>userinfo(),
            viewProductDetails.route:(ctx)=>viewProductDetails(),
            addProductScreen.route:(ctx)=>addProductScreen(),
          },
        );
      },
    );
  }
}
