import 'package:elmashro3/screens/login.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:elmashro3/constants/colors.dart';

import '../admin/auth/login.dart';
class IntroScreen extends StatefulWidget {
  static const routeName = "/introScreen";

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _scrollController = PageController();

  int pageCnt = 0;

  void setPageCnt(int cnt){
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
          padding: EdgeInsets.only(bottom:getProportionateScreenWidth(20)),
          child: Column(
            children: [
              illustrationPageView(_scrollController,setPageCnt),
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
  illustrationPageView(this._controller,this.callback);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){return loginScreenAdmin();}));
                  }, child: Text("login as crew",style: TextStyle(color: kTextColor),)),
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: getProportionateScreenHeight(350)),
                child: PageView(
                  onPageChanged: (v){
                    callback(v);
                  },
                  controller: _controller,
                  children: [
                  Image.asset("assets/illu1.png"),
                  Image.asset("assets/recycable .png"),
                  Image.asset("assets/illu3.png"),
                ],),
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
  List<Map<String,String>>data = [
    {
      "title":"Easy Shopping",
      "desc":"you can order anything you want and get it as fast as possible from your home"
    },
    {
      "title":"Daily Recycling ",
      "desc":"you can daily recycle the garpage that you dont"
    },
    {
      "title":"Fast Delvery",
      "desc":"shipping order will be as fast as possiple to bring you the order fresh and healthy"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            Spacer(),
            Text(data[pagecnt]["title"].toString(),style: Theme.of(context).textTheme.headline3!.copyWith(color: kTextColor,fontWeight: FontWeight.w600),),
            Spacer(),
            Text(data[pagecnt]["desc"].toString(),style: TextStyle(color: kTextColorAccent),textAlign: TextAlign.center,),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              indicator(pagecnt,0),
              SizedBox(width: getProportionateScreenWidth(6),),
                indicator(pagecnt,1),
                SizedBox(width: getProportionateScreenWidth(6),),
                indicator(pagecnt,2),
              ],),
            Spacer(),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed(loginScreen.routName);
            }, child: Text("Get Started"))
          ],
        ),
      ),
    );
  }
}

class indicator extends StatelessWidget {
  final pagecnt;
  final cnt;
  indicator(this.pagecnt,this.cnt);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width:pagecnt==cnt?getProportionateScreenWidth(32):getProportionateScreenWidth(8),
      height: getProportionateScreenHeight(8),
      decoration: BoxDecoration(
          color:pagecnt==cnt? kPrimaryGreen:kFillColorPrimary,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}

