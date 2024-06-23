import 'package:elmashro3/admin/screens/viewproductdetails.dart';
import 'package:flutter/material.dart';

import '../../constants/links.dart';
import '../../controller/crud.dart';
class productsScreen extends StatefulWidget {
  static const route = "/productsScreen";

  @override
  State<productsScreen> createState() => _productsScreenState();
}

class _productsScreenState extends State<productsScreen> {
  crud c = crud();
  var products = [];
  getProducts()async{
    var response = await c.getRequest(ViewallProducts);
    // response = jsonDecode(response);
    products = response["data"];
    setState(() {

    });
    print(products);
  }
  @override
  Widget build(BuildContext context) {
    getProducts();
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(viewProductDetails.route,arguments: {
                "data":products[index]
              });
            },
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${products[index]["name"]}"),
                  Text("${products[index]["id"]}"),
                  Text("${products[index]["description"]}"),
                ],
              ),
              leading: Image.network("${imgRoute}/${products[index]["image"]}",width: 100,fit: BoxFit.fill,),
              subtitle: Row(
                children: [
                  // Text("${users[index]["active_points"]}"),
                  // SizedBox(width: 10,),
                  // Text("${users[index]["pending_points"]}"),
                  // SizedBox(width: 10,),
                  // Text("${users[index]["is_points_verified"]}"),
                ],
              ),
            ),
          );
        });
  }
}
