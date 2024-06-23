import 'package:elmashro3/screens/popularDealScreen.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/backBtn.dart';
import 'package:elmashro3/widgets/categoryCard.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/links.dart';
import '../controller/crud.dart';
import '../model/categories.dart';
import '../widgets/CustomeAppBar.dart';
class CategoryScreen extends StatefulWidget {
  static final routeName="/categoryScreen";
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  crud c = crud();

  var categoriesList = [];

  bool isLoadCate = true;

  List<CategoryModel> categories=[];

  setCategories()async{
    var response = await c.getRequest(getCategories);
    isLoadCate = false;
    categoriesList = response['data'];
    setState(() {
      categories = [
        CategoryModel(kAccentGreen, categoriesList[0]["name"], "${imgRoute}/${categoriesList[0]["image"]}",int.parse(categoriesList[0]["id"])),
        CategoryModel(kAccentRed, categoriesList[1]["name"], "${imgRoute}/${categoriesList[1]["image"]}",int.parse(categoriesList[1]["id"])),
        CategoryModel(kAccentGreen, categoriesList[2]["name"], "${imgRoute}/${categoriesList[2]["image"]}",int.parse(categoriesList[2]["id"])),
        CategoryModel(kAccentGreen, categoriesList[3]["name"], "${imgRoute}/${categoriesList[3]["image"]}",int.parse(categoriesList[3]["id"])),
        CategoryModel(kAccentYellow, categoriesList[4]["name"], "${imgRoute}/${categoriesList[4]["image"]}",int.parse(categoriesList[4]["id"])),
      ];

    });
  }
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    setCategories();
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
            children: [
              backBtn(),
              Spacer(),
              Text("Categories",style: TextStyle(fontSize: getProportionateScreenWidth(17),fontWeight: FontWeight.w600),),
              Spacer(),
              SizedBox(width: getProportionateScreenWidth(12),)
           ],
            ),
            SizedBox(height: getProportionateScreenHeight(25),),
            Expanded(child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio: .9),
              children: List.generate(categories.length, (index) => GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(PopularDealScreen.routeName,arguments: {
                      "category":categories[index].id.toString()
                    });
                  },
                  child: CategoryCard(categories[index])))
            ))
          ],
        ),
      ),
    );
  }
}
