import 'dart:convert';

import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/main.dart';
import 'package:elmashro3/screens/orderSummary.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/CustomeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

import '../constants/links.dart';
import '../widgets/orderProductWidget.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/CartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  crud c = crud();
  var carts = [];
  bool isEmptyCart = true;
  getAllFromCart()async{
    var response = await c.postRequest(getProductfromCart, {
      "userId":sharedPreferences.getString("id")
    });
    response = jsonDecode(response);
    print(response);
    if(response["status"] == "failed"){
      carts = [];
    }else{

      carts = response["data"];
      getAllFromProducts();
    }
  }
  List<dynamic> products = [];
  getAllFromProducts()async{
    products = [];
    for(var i in carts){
      print(i);
      var response = await c.postRequest(getspecificProduct, {
        "p_id": i["product_id"],
      });
      response = jsonDecode(response);
      products.add(response["data"][0]);
    }
    setState(() {
      if(products.isNotEmpty){
        isEmptyCart = false;
      }
    });
  }

  deleteFromCart(var id)async{
    var res = await c.postRequest(DeleteItemFromCart, {
      "id":id,
    });
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllFromCart();
    ScreenUtils().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryGreen,
          onPressed: () {
            Navigator.of(context).pushNamed(orderSummary.routeName,arguments: {
              "item":products,
              "quantity":products.length.toString(),
              "pLength":products.length
            });
          },
          label: Row(
            children: [Text("buy now?",style: TextStyle(color: Colors.white),),],
          )),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  featuredHeader("my cart", Icons.search),
                  carts.isEmpty? Center(child: Text("empty cart")):ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: products.length,itemBuilder: (context,idx){
                    return Dismissible(
                      child:OrderProductWidget(
                        products[idx]["description"]!,
                        image: "${imgRoute}/${products[idx]["image"]!}",
                        title: products[idx]["name"]!,
                        price: products[idx]["price"]!,
                        quantity: products[idx]["quantity"]!,
                        id:carts[idx]["id"],
                      ),
                      onDismissed: (d){
                        setState(() {
                          deleteFromCart(carts[idx]["id"]);
                          getAllFromCart();
                        });
                      },
                        key:  Key(products[idx]["name"]),
                        background:Container(
                        color: Colors.red,
                        child: Icon(Icons.delete),
                      )
                    );
                  })

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
