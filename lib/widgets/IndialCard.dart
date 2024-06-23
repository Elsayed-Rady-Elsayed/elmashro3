import 'package:elmashro3/main.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/links.dart';
import '../controller/crud.dart';

class IndialCard extends StatefulWidget {
  String image;
  String title;
  String quantity;
  String price;
  var id;
  IndialCard(
   {required this.id,required this.image,
      required this.price,
      required this.quantity,
      required this.title});

  @override
  State<IndialCard> createState() => _IndialCardState();
}

class _IndialCardState extends State<IndialCard> {
  crud c = crud();

  addToCart()async{
    var response = await c.postRequest(addProductToCart, {
      "product_id":widget.id,
      "user_id":sharedPreferences.getString("id"),
      "quantity":"1",
    });
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        shadows: [
          BoxShadow(color: kShadowColor, spreadRadius: .5, blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 90,
            width: double.infinity,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              color: Colors.grey,
            ),
            child: Image.network(
              widget.image,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.quantity}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.price} EGP",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: kPrimaryGreen,
                            content: const Text(
                              'item added successfully',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: (){
                          addToCart();
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: kPrimaryGreen,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
