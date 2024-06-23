import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/screens/productDetails.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/CustomeAppBar.dart';
import 'package:flutter/material.dart';

import '../constants/links.dart';
import '../controller/crud.dart';
import '../widgets/IndialCard.dart';

class SpecialDealChildScreen extends StatefulWidget {
  static final routeName = "/specialDealchild";

  @override
  State<SpecialDealChildScreen> createState() => _SpecialDealChildScreenState();
}

class _SpecialDealChildScreenState extends State<SpecialDealChildScreen> {
  var products = [];
  crud c = crud();
  bool isLoadingProdu = true;
  var listObj = [

  ];
  viewAllProduct()async{
    var res = await c.getRequest(ViewallProducts);
    listObj = res["data"];
    isLoadingProdu = false;
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    viewAllProduct();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            featuredHeader("fruits", Icons.favorite_border_outlined),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            horizontalScroll(),
            Expanded(
                child: Container(
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
                        Navigator.of(context)
                            .pushNamed(productDetails.routeName,arguments: {
                          "image": "${imgRoute}/${listObj[i]["image"]!}",
                          "price": listObj[i]["price"]!,
                          "quantity": listObj[i]["quantity"],
                          "title": listObj[i]["title"],
                          "description":listObj[i]["description"],
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
    );
  }
}

class horizontalScroll extends StatefulWidget {
  const horizontalScroll({
    super.key,
  });

  @override
  State<horizontalScroll> createState() => _horizontalScrollState();
}

class _horizontalScrollState extends State<horizontalScroll> {
  final List<Map<String, Object>> fruitvarinat = [
    {
      "name": "all",
      "index": 0,
    },
    {
      "name": "apple",
      "index": 1,
    },
    {
      "name": "strawpary",
      "index": 2,
    },
    {
      "name": "banana",
      "index": 3,
    },
    {
      "name": "mango",
      "index": 4,
    }
  ];
  int curSel = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
                fruitvarinat.length,
                (index) =>
                    navbarFruit(fruitvarinat[index]["name"].toString(), () {
                      setState(() {
                        curSel = index;
                      });
                    }, curSel == index))),
      ),
    );
  }
}

class navbarFruit extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function() onTap;
  navbarFruit(this.text, this.onTap, this.isSelected);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: getProportionateScreenWidth(80),
        height: getProportionateScreenHeight(40),
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border:
                isSelected ? Border.all(color: kPrimaryGreen, width: 1) : null),
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }
}
