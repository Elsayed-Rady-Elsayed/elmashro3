import 'package:elmashro3/screens/login.dart';
import 'package:elmashro3/screens/recycling.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:elmashro3/constants/colors.dart';

class RecyclingHelper extends StatefulWidget {
  static const routeName = "/RecyclingHelper";

  @override
  State<RecyclingHelper> createState() => _RecyclingHelperScreenState();
}

class _RecyclingHelperScreenState extends State<RecyclingHelper> {
  final PageController _scrollController = PageController();

  int pageCnt = 0;

  void setPageCnt(int cnt) {
    setState(() {
      pageCnt = cnt;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              illustrationPageView(_scrollController, setPageCnt),
              TextView(pageCnt)
            ],
          ),
        ),
      ),
    );
  }
}

class illustrationPageView extends StatelessWidget {
  final _controller;
  final Function(int) callback;
  illustrationPageView(this._controller, this.callback);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
          width: double.infinity,
          color: kAccentGreen,
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(18),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: getProportionateScreenHeight(350)),
                child: PageView(
                  onPageChanged: (v) {
                    callback(v);
                  },
                  controller: _controller,
                  children: [
                    Image.asset(
                      "assets/water.png",
                    ),
                    Image.asset("assets/can.png"),
                    Image.asset("assets/carton.png"),
                    Image.asset("assets/plastic-cup.png"),
                    Image.asset("assets/gallery.png"),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(18),
              ),
            ],
          )),
    );
  }
}

class TextView extends StatelessWidget {
  final pagecnt;
  TextView(this.pagecnt);
  List<Map<String, String>> data = [
    {
      "title": " plastic bottles",
      "price": "2.5 points",
      "desc": "any plastic objects that may be recycable"
    },
    {
      "title": "cans",
      "desc": "any type of cans",
      "price": "10 points",
    },
    {
      "title": "carton",
      "desc": "carton with its all shapes",
      "price": "7 points",
    },
    {
      "title": "carton bottles",
      "desc": "any carton cups",
      "price": "1 points",
    },
    {
      "title": "instructions of use",
      "desc":
          "take clear photo and try to isolate it from any noises around you \n take photo for only one object",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            Spacer(),
            Text(
              data[pagecnt]["title"].toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: kTextColor, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Text(
              data[pagecnt]["desc"].toString(),
              style: TextStyle(color: kTextColorAccent),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Text(
               data[pagecnt]["price"].toString() == "null" ? "":data[pagecnt]["price"].toString(),
              style: TextStyle(color: kPrimaryGreen),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                indicator(pagecnt, 0),
                SizedBox(
                  width: getProportionateScreenWidth(6),
                ),
                indicator(pagecnt, 1),
                SizedBox(
                  width: getProportionateScreenWidth(6),
                ),
                indicator(pagecnt, 2),
                SizedBox(
                  width: getProportionateScreenWidth(6),
                ),
                indicator(pagecnt, 3),
                SizedBox(
                  width: getProportionateScreenWidth(6),
                ),
                indicator(pagecnt, 4)
              ],
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(recyclingMainPage.routeName);
                },
                child: Text("start recycling"))
          ],
        ),
      ),
    );
  }
}

class indicator extends StatelessWidget {
  final pagecnt;
  final cnt;
  indicator(this.pagecnt, this.cnt);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: pagecnt == cnt
          ? getProportionateScreenWidth(32)
          : getProportionateScreenWidth(8),
      height: getProportionateScreenHeight(8),
      decoration: BoxDecoration(
          color: pagecnt == cnt ? kPrimaryGreen : kFillColorPrimary,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
