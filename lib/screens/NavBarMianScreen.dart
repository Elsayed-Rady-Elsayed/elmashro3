// import 'package:elmashro3/screens/homeScreen.dart';
// import 'package:elmashro3/screens/popularDealScreen.dart';
// import 'package:elmashro3/screens/profileServices.dart';
// import 'package:flutter/material.dart';

// import '../constants/colors.dart';
// import '../model/categories.dart';
// import '../utils/screenUtils.dart';
// import '../widgets/IndialCard.dart';
// import 'cart_screen.dart';
// class NavBarMainScreen extends StatelessWidget {
//   final Widget child;
//   NavBarMainScreen(this.child);
//   static const routeName = "/navBarMianScreen";
//   List<Widget>screens = [
//     HomeScreen(),
//     CartScreen(),
//     ProfileServices()
//   ];
//   final List<CategoryModel>categories=[
//     CategoryModel(kAccentGreen, "vegetables", "assets/vegetable_home.png"),
//     CategoryModel(kAccentRed, "fruits", "assets/fruit_home.png"),
//     CategoryModel(kAccentGreen, "milks & egg", "assets/egg_home.png"),
//     CategoryModel(kAccentGreen, "meat", "assets/meat.png"),

//   ];
//   int curIndx = 0;
//   Widget build(BuildContext context){
//     ScreenUtils().init(context);
//     return child;
//   }
// }


// class popularDeals extends StatelessWidget {
//   const popularDeals({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             Padding(padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
//               child: Row(
//                 children: [
//                   Expanded(child: Text("Popular Drals")),
//                   TextButton(onPressed: (){
//                     Navigator.of(context).pushNamed(PopularDealScreen.routeName);
//                   }, child: Text("See ALL"))
//                 ],
//               ),
//             ),
//             Expanded(
//               child: GridView(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: .74),
//                 children: [
//                   AspectRatio(aspectRatio: .7,child:IndialCard(),)
//                 ],
//               ),)
//           ],
//         ),
//       ),
//     );
//   }
// }
// class CustomeBottomNavBar extends StatefulWidget {
//   const CustomeBottomNavBar({
//     super.key,
//   });

//   @override
//   State<CustomeBottomNavBar> createState() => _CustomeBottomNavBarState();
// }

// class _CustomeBottomNavBarState extends State<CustomeBottomNavBar> {
//   int TabIndx = 0;
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: Colors.white,
//       showUnselectedLabels: true,
//       selectedItemColor: kPrimaryGreen,
//       currentIndex: TabIndx,
//       onTap: (v){
//         setState(() {
//           TabIndx = v;
//         });
//       },
//       items: [
//         BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
//         BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "cart"),
//         BottomNavigationBarItem(icon: Icon(Icons.person),label: "profile"),
//       ],
//     );
//   }
// }

