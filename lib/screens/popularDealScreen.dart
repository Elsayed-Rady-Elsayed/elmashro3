import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/screens/productDetails.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../constants/links.dart';
import '../widgets/CustomeAppBar.dart';
import '../widgets/IndialCard.dart';
import 'SpecialDealChild.dart';

class PopularDealScreen extends StatefulWidget {
  static final routeName = "/popularDeadl";

  @override
  State<PopularDealScreen> createState() => _PopularDealScreenState();
}

class _PopularDealScreenState extends State<PopularDealScreen> {
  var listObj = [
  ];

  var products = [];

  bool isLoadingProdu = true;
  crud c = crud();
  viewAllProduct()async{
    var res = await c.getRequest(ViewallProducts);
    listObj = res["data"];
    isLoadingProdu = false;
    setState(() {

    });
  }
  var arguments;
  var categoryList = [];
  void checkPath(){
    categoryList=[];
    if(arguments != null&&arguments["category"]!= null){
       listObj.forEach((element) {
        if(int.parse(element["category_id"]) == int.parse(arguments["category"])){
          categoryList.add(element);
        }
      });
       print(categoryList);
       setState(() {
         listObj = categoryList;
       });
    }

  }
  @override
  Widget build(BuildContext context) {
      arguments = (ModalRoute.of(context)?.settings.arguments);
    viewAllProduct();
    checkPath();
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              featuredHeader("popular deals", Icons.star),
              SizedBox(height: 14,),
              Expanded(
                  child: Container(
                child: GridView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(productDetails.routeName,arguments: {
                            "image":"${imgRoute}/${listObj[i]["image"]!}",
                            "title":listObj[i]["name"],
                            "price":listObj[i]["price"],
                            "quantity":listObj[i]["quantity"],
                            "description":listObj[i]["description"]
                          });
                        },
                        child: AspectRatio(
                          aspectRatio: .8,
                          child: IndialCard(
                              id: listObj[i]["id"]!,
                              image: "${imgRoute}/${listObj[i]["image"]!}",
                              price: listObj[i]["price"]!,
                              quantity: listObj[i]["quantity"]!,
                              title: listObj[i]["name"]!),
                        ));
                  },
                  itemCount: listObj.length,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
