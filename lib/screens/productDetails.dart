import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/screens/orderSummary.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/CustomeAppBar.dart';
import 'package:elmashro3/widgets/imagePlaceHolderWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/links.dart';
import '../controller/crud.dart';
import '../main.dart';

class productDetails extends StatefulWidget {

  static final routeName = "\productDetails";

  @override
  State<productDetails> createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {
  @override
  var quantity = 1;
  crud c = crud();

  addToCart(var id)async{
    var response = await c.postRequest(addProductToCart, {
      "product_id":id,
      "user_id":sharedPreferences.getString("id"),
      "quantity":"1",
    });
    setState(() {

    });
  }
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    ScreenUtils().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryGreen,
        onPressed: () {
          Navigator.of(context).pushNamed(orderSummary.routeName,arguments: {
            "item":arguments,
            "quantity":quantity.toString(),
            "singleItem":"1"
          });
        },
        label: Text("buy",style: TextStyle(color: Colors.white),),
        icon: Icon(Icons.shopping_cart,color: Colors.white,),
      ),
      body: ListView(
        children: [
          featuredHeader("product details", Icons.shopping_cart),
          SizedBox(
            height: getProportionateScreenWidth(20),
          ),
          Container(
            height: 350,
            child: Stack(
              children: [
                Container(
                  height: 340,
                  width: double.infinity,
                  color: kGreyShade5,
                  child: Image.network(arguments["image"],fit: BoxFit.fill,),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: kGreyShade1,
                          radius: getProportionateScreenWidth(4),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CircleAvatar(
                          backgroundColor: kGreyShade1,
                          radius: getProportionateScreenWidth(4),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CircleAvatar(
                          backgroundColor: kGreyShade1,
                          radius: getProportionateScreenWidth(4),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CircleAvatar(
                          backgroundColor: kGreyShade1,
                          radius: getProportionateScreenWidth(4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenWidth(0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                arguments["sale"] =="0"? Container() :Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(30)),
                      color: Colors.red),
                  child: Text(
                     "on sale",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
                Row(
                  children: [
                    Text(
                      arguments['title'],
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "quantity : ${arguments['quantity']}",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: kTextColorAccent),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: kAccentRed),
                          child: Text("${arguments["price"]} EGP"
                            ,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: kPrimaryRed,
                                fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: kAccentGreen),
                          child: Text(
                            "${(int.parse(arguments["price"]) * quantity)} EGP",
                            style: TextStyle(
                                color: kPrimaryGreen,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              if(quantity >0) {
                                quantity--;
                              }
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: kPrimaryGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              // :Border.all(color: kAccentGreen),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        SizedBox(
                            width: 40,
                            height: 40,
                            child: Container(
                              decoration: ShapeDecoration(
                                color: kGreyShade5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                // :Border.all(color: kAccentGreen),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                quantity.toString(),
                              ),
                            )),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              quantity++;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: kPrimaryGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              // :Border.all(color: kAccentGreen),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: Container(
                    decoration: ShapeDecoration(
                        color: kGreyShade5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11))),
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(2),
                            height: 50,
                            decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11)),
                                shadows: [BoxShadow(color: kGreyShade2)]),
                            alignment: Alignment.center,
                            child: Text("Detail Items"),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(2),
                        ),
                        Container(
                          width: 1,
                          color: kGreyShade3,
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(2),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.all(2),
                            decoration: ShapeDecoration(
                              color: kPrimaryGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11)),
                              shadows: [BoxShadow(color: kGreyShade2)]),
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: (){
                                addToCart(arguments["id"]);
                              },
                              child: Text("add to cart",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Text(
                    arguments["description"],
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: kTextColorAccent, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
