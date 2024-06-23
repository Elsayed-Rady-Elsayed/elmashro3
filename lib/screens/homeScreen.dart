import 'package:carousel_slider/carousel_slider.dart';
import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/constants/links.dart';
import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/model/categories.dart';
import 'package:elmashro3/screens/SpecailOffers.dart';
import 'package:elmashro3/screens/cart_screen.dart';
import 'package:elmashro3/screens/categoryScreen.dart';
import 'package:elmashro3/screens/fruitScreen.dart';
import 'package:elmashro3/screens/popularDealScreen.dart';
import 'package:elmashro3/screens/productDetails.dart';
import 'package:elmashro3/screens/searchScreen.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:flutter/material.dart';

import '../widgets/IndialCard.dart';
import '../widgets/categoryCard.dart';
import '../widgets/offerWidget.dart';
import 'profileServices.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        CategoryModel(kAccentRed, categoriesList[1]["name"], "${imgRoute}/${categoriesList[1]["image"]}",int.parse(categoriesList[0]["id"])),
        CategoryModel(kAccentGreen, categoriesList[2]["name"], "${imgRoute}/${categoriesList[2]["image"]}",int.parse(categoriesList[0]["id"])),
        CategoryModel(kAccentGreen, categoriesList[3]["name"], "${imgRoute}/${categoriesList[3]["image"]}",int.parse(categoriesList[0]["id"])),
        CategoryModel(kAccentYellow, categoriesList[4]["name"], "${imgRoute}/${categoriesList[4]["image"]}",int.parse(categoriesList[0]["id"])),
      ];
    });
  }

  var products = [];
  bool isLoadingProdu = true;
  viewAllProduct()async{
    var res = await c.getRequest(ViewallProducts);
    products = res["data"];
    isLoadingProdu = false;
    setState(() {

    });
  }
  Widget build(BuildContext context) {
    setCategories();
    viewAllProduct();

    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoadCate || isLoadingProdu?Center(child: CircularProgressIndicator()):Column(
            children: [
              headerWidget(),
              categoriesAndSeeAll(cat_list : categoriesList),
              isLoadCate? CircularProgressIndicator(): CategoryScroller(categories: categories,cat_list:categoriesList),
              specialOffer(),
              isLoadingProdu?CircularProgressIndicator(): popularDeals(listObj: products,),
            ],
          ),
        ),
      ),
    );
  }
}

class popularDeals extends StatelessWidget {
  popularDeals({required this.listObj});
  var listObj = [
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(0)),
            child: Row(
              children: [
                Expanded(child: Text("Popular Drals",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(PopularDealScreen.routeName);
                    },
                    child: Text("See ALL"))
              ],
            ),
          ),
          Container(
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
                        "image":"${imgRoute}/${listObj[i]["image"]!}",
                        "title":listObj[i]["name"],
                        "price":listObj[i]["price"],
                        "quantity":listObj[i]["quantity"],
                        "description":listObj[i]["description"],
                        "sale":listObj[i]["is_sale"],
                        "id":listObj[i]["id"],
                      });
                    },
                    child: AspectRatio(
                      aspectRatio: .85,
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
          )
        ],
      ),
    );
  }
}

class specialOffer extends StatefulWidget {
  @override
  State<specialOffer> createState() => _specialOfferState();
}

class _specialOfferState extends State<specialOffer> {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(3)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                "Special Deals For You",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(16)),
              )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SpecialOffers.routeName);
                  },
                  child: Text("See All"))
            ],
          ),
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 19/8,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
            items: products.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                      ),
                      child: GestureDetector(
                          onTap: (){
                              Navigator.of(context).pushNamed(productDetails.routeName,arguments: {
                                "image":"${imgRoute}/${i["image"]!}",
                                "title":i["name"],
                                "price":i["price"],
                                "quantity":i["quantity"],
                                "description":i["description"],
                                "sale":i["is_sale"],
                                "id":i["id"],

                              });
                          },
                          child: OfferWidget(i["name"],i["price"],"${imgRoute}/${i["image"]}")),
                  );
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class CategoryScroller extends StatelessWidget {
  const CategoryScroller({
    super.key,
    required this.categories,
    required this.cat_list,
  });

  final List<CategoryModel> categories;
  final cat_list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(
          categories.length,
          (index) => GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(PopularDealScreen.routeName,arguments: {
                  "category":cat_list[index]["id"]
                });
              },
              child: CategoryCard(categories[index])),
        )),
      ),
    );
  }
}

class categoriesAndSeeAll extends StatelessWidget {
  var cat_list;
  categoriesAndSeeAll({required this.cat_list});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(12)),
      child: Row(
        children: [
          Expanded(
              child: Text(
            "Categories",
            style: Theme.of(context).textTheme.headline5!.copyWith(
                fontSize: getProportionateScreenWidth(19),
                fontWeight: FontWeight.w700),
          )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CategoryScreen.routeName,arguments: {
                  "cate_list":cat_list
                });
              },
              child: Text(
                "See All",
                style: TextStyle(decoration: TextDecoration.underline),
              ))
        ],
      ),
    );
  }
}

class headerWidget extends StatelessWidget {
  const headerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Green Market",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w700,color: kPrimaryGreen),
              ),
            ],
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(searchScreen.routeName);
              },
              child: Icon(
                Icons.search,
                color: kPrimaryGreen,
              )),
        ],
      ),
    );
  }
}
