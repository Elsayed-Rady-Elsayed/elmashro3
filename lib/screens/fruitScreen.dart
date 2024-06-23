import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/CustomeAppBar.dart';
import 'package:flutter/material.dart';

import '../constants/links.dart';
import '../widgets/imagePlaceHolderWidget.dart';
class fruitScreen extends StatefulWidget {
  static final routeName = "/fruitScreen";

  @override
  State<fruitScreen> createState() => _fruitScreenState();
}

class _fruitScreenState extends State<fruitScreen> {
  final TextController = TextEditingController(text: '1');
  var products = [];
  crud c = crud();
  bool isLoadingProdu = true;
  viewAllProduct()async{
    var res = await c.getRequest(ViewallProducts);
    products = res["data"];
    isLoadingProdu = false;
    setState(() {

    });
  }
  List<String>ingredients = [
    "Grapes (200gr)",
    "Apples (300gr)",
    "Mango (100gr)",
    "jackFruit (20gr)",
    "oranges (1000gr)",
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            featuredHeader("Fruit Bundle",Icons.shopping_cart_outlined),
            SizedBox(height: 16,),
            ImagePlaceHolder(),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleWidget(),
                    SizedBox(height: 8,),
                    Text("Total 10kg",style: Theme.of(context).textTheme.headline4!.copyWith(color: kTextColorAccent),),
                    SizedBox(height: 8,),
                    quantityAndPriceWidget(TextController: TextController),
                    Row(
                      children: [
                        Text("Detail items",style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w700),),
                        Spacer(),
                        Image.asset("assets/edit.png"),
                      ],
                    ),
                    ...List.generate(ingredients.length, (index) => Text(ingredients[index],style: Theme.of(context).textTheme.headline4!.copyWith(color: kTextColorAccent),)
                    )
                  ],
                ),
              ),
            )
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(16)),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                      child: OutlinedButton(
                        child: Image.asset(("assets/cart_nav_fill.png"),),
                        onPressed: (){},)
                  ),
                  SizedBox(width: getProportionateScreenWidth(16),),
                  Expanded(
                    flex: 3,
                      child: ElevatedButton(onPressed: (){}, child: Text("Buy Now")))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class quantityAndPriceWidget extends StatelessWidget {
  const quantityAndPriceWidget({
    super.key,
    required this.TextController,
  });

  final TextEditingController TextController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: kAccentGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
            ),
          ),
            padding: EdgeInsets.all(8),
            child: Text("\$56",style: Theme.of(context).textTheme.headline3!.copyWith(color: kPrimaryGreen),)),
        Spacer(),
        CustomIconBtn(Icons.remove,(){}),
        SizedBox(width: getProportionateScreenWidth(2),),
        SizedBox(
          width: 50,
          height: 50,
          child: TextField(
            textAlign: TextAlign.center,
            controller: TextController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
                borderSide: BorderSide(color: kGreyShade5),
              ),
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(2),),
        CustomIconBtn(Icons.add,(){}),
      ],
    );
  }
}

class CustomIconBtn extends StatelessWidget {
 final IconData icon;
 final Function() onPress;
 CustomIconBtn(this.icon,this.onPress);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(onPressed: onPress,
    fillColor: kGreyShade5,
      elevation: 0,
      constraints: BoxConstraints.tightFor(
        width: getProportionateScreenWidth(35),
        height: getProportionateScreenHeight(50)
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11)
      ),
      child: Icon(
        icon,
        color: kGreyShade1,
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text("Fruit's Bundle",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w700),)),
        Icon(Icons.favorite_border_outlined,color: kPrimaryGreen,size: getProportionateScreenWidth(25),)
      ],
    );
  }
}

