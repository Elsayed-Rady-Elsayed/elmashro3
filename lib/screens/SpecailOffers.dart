import 'package:elmashro3/screens/productDetails.dart';
import 'package:elmashro3/widgets/CustomeAppBar.dart';
import 'package:elmashro3/widgets/offerWidget.dart';
import 'package:flutter/material.dart';

import '../constants/links.dart';
import '../controller/crud.dart';
import '../widgets/IndialCard.dart';
import 'SpecialDealChild.dart';

class SpecialOffers extends StatefulWidget {
  static final routeName = "/SpecialOffer";

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  crud c = crud();
  var products = [];
  getProducts()async{
    var response = await c.getRequest(selectProductsWithSale);
    products = response["data"];
    setState(() {
    });
    print(products);
  }
  @override
  Widget build(BuildContext context) {
    getProducts();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            featuredHeader("special offers", Icons.favorite_border_outlined),
            Expanded(
              child:     Container(
                child: GridView.builder(
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
                            "image":"${imgRoute}/${products[i]["image"]!}",
                            "title":products[i]["name"],
                            "price":products[i]["price"],
                            "quantity":products[i]["quantity"],
                            "description":products[i]["description"],
                            "sale":products[i]["is_sale"],
                            "id":products[i]["id"],
                          });
                        },
                        child: AspectRatio(
                          aspectRatio: .85,
                          child: IndialCard(
                              id: products[i]["id"]!,
                              image: "${imgRoute}/${products[i]["image"]!}",
                              price: products[i]["price"]!,
                              quantity: products[i]["quantity"]!,
                              title: products[i]["name"]!),
                        ));
                  },
                  itemCount: products.length,
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
