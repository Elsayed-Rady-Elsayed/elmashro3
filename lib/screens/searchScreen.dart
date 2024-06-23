import 'package:elmashro3/screens/fruitScreen.dart';
import 'package:elmashro3/screens/homeScreen.dart';
import 'package:elmashro3/screens/productDetails.dart';
import 'package:elmashro3/screens/vegetableScreen.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/CustomeAppBar.dart';
import 'package:elmashro3/widgets/offerWidget.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/links.dart';
import '../controller/crud.dart';
import '../widgets/IndialCard.dart';
import '../widgets/searchWidget.dart';

class searchScreen extends StatefulWidget {
  static final routeName = "/searchScreen";

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  TextEditingController controller =TextEditingController();
  crud c = crud();
  var products = [];
  var SearchedList = [];
  getProducts()async{
    var response = await c.getRequest(ViewallProducts);
    // response = jsonDecode(response);
    products = response["data"];
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    getProducts();
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              featuredHeader("search", Icons.search),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        onChanged: (v){
                          SearchedList = [];
                          products.forEach((element) {
                            if(element["name"].contains(v)){
                              setState(() {
                                SearchedList.add(element);
                              });
                            }
                          });
                        },
                        controller: controller,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: kFillColorThird,
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenWidth(12)),borderSide: BorderSide(color: Colors.transparent) ),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenWidth(12)),borderSide: BorderSide(color: Colors.transparent) ),
                            hintText: "search",
                            hintStyle: TextStyle(color: kGreyShade2,fontSize: getProportionateScreenWidth(17))
                        ),
                      )),
                  SizedBox(
                    width: getProportionateScreenWidth(16),
                  ),
                  Image.asset("assets/bell.png"),
                ],
              ),
            ),
              SizedBox(
                height: getProportionateScreenHeight(12),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .9,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(productDetails.routeName,arguments: {
                          "image":"${imgRoute}/${SearchedList[i]["image"]!}",
                          "title":SearchedList[i]["name"],
                          "price":SearchedList[i]["price"],
                          "quantity":SearchedList[i]["quantity"],
                          "description":SearchedList[i]["description"]
                        });
                      },
                      child: AspectRatio(
                        aspectRatio: .85,
                        child: IndialCard(
                            id: SearchedList[i]["id"]!,
                            image: "${imgRoute}/${SearchedList[i]["image"]!}",
                            price: SearchedList[i]["price"]!,
                            quantity: SearchedList[i]["quantity"]!,
                            title: SearchedList[i]["name"]!),
                      ));
                },
                itemCount: SearchedList.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

