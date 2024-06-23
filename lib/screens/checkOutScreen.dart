import 'dart:convert';

import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/screens/successPayment.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/CustomeAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants/links.dart';
import '../controller/crud.dart';
import '../main.dart';
import '../widgets/TapBar.dart';
import '../widgets/textFieldWidget.dart';
class CheckOutScreen extends StatefulWidget {
  static final routeName = "/checkoutScreen";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String city= "";

  String region= "";

  String street= "";

  String bnum= "";

  String notes= "";


  bool isLoading = false;

  crud c = crud();

  var rcvdData;

  int? uid;

  int selectedOptionPayment = 0;
  var visaSelected =kGreyShade5;
  var cashSeleted = kGreyShade5;
  getAddress()async{
    var res1 = await c.postRequest(getregionLink, {
      "userId":sharedPreferences.getString("id"),
    });
    res1 = jsonDecode(res1);
    region = res1["data"][0]["name"];
    var res2 = await c.postRequest(getcityLink, {
      "userId":sharedPreferences.getString("id"),
    });
    res2 = jsonDecode(res2);
    city = res2["data"][0]["name"];
    var res3 = await c.postRequest(getaddressLink, {
      "userId":sharedPreferences.getString("id"),
    });
    res3 = jsonDecode(res3);
    street = res3["data"][0]["street"];
    bnum = res3["data"][0]["building"];
    notes = res3["data"][0]["notes"];
    AddressId = res3["data"][0]["id"];
    setState(() {

    });
  }
  void initState() {
    // TODO: implement initState
    getAddress();
    setState(() {

    });
    super.initState();
  }
  String phone = "";
  String AddressId = "";
  getuser()async{
    setState(() {
      isLoading = false;
    });
    var response = await c.postRequest( getUserLink,{
      "userId":sharedPreferences.getString("id"),
    });
    response = jsonDecode(response);
    phone= response["data"][0]["phone"];
    return response;
  }
  var arguments;
  var paymentMethod = "";
  bool isVisaSelected = false;
  addOrder()async{
    var ite = [];
    var l = int.parse(arguments["orderDetails"]["quantity"]);
    for(var i = 0;i<l;i++ ){
      ite.add(arguments["orderDetails"]["item"]["price"]);
    }
    print(ite.join(","));
    var res = await c.postRequest(addOrderLink, {
      "total_price":arguments["tPrice"].toString(),
      "items_price":ite.join(","),
      "lat_long":"",
      "address_id":AddressId,
      "payment_method":paymentMethod,
      "status":"1",
      "created_at":DateTime.now().toString(),
      "updated_at":DateTime.now().toString(),
    });
    //print(res);
    Navigator.of(context).pushNamed(
        SuccessPaymentScreen.routeName, arguments: {
      "data": arguments
    });
  }
  addOrderM(var tprice,var itemsP)async{
    var res = await c.postRequest(addOrderLink, {
      "total_price":tprice.toString(),
      "items_price":itemsP.join(","),
      "lat_long":"",
      "address_id":AddressId,
      "payment_method":paymentMethod,
      "status":"1",
      "created_at":DateTime.now().toString(),
      "updated_at":DateTime.now().toString(),
    });
    Navigator.of(context).pushNamed(
        SuccessPaymentScreen.routeName, arguments: {
      "data": arguments
    });
    //print(res);
  }
  bool checkPage = false;
  var LPriceItems = [];

  @override
  Widget build(BuildContext context) {
    getAddress();
    getuser();
    arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    if(arguments["idList"].isNotEmpty){
      LPriceItems = [];
      for(var i in arguments["orderDetails"]["item"]){
        LPriceItems.add(i["price"]);

      }
    }
    TextEditingController creditCard = TextEditingController();
    TextEditingController cpp = TextEditingController();
    TextEditingController expDate = TextEditingController();
    editUser()async{
      var res = await c.postRequest(editVisa, {
        "credicard":creditCard.text,
        "cpp":cpp.text,
        "expdate":expDate.text,
        "user_id":sharedPreferences.getString("id"),
      });
      print(res);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: kPrimaryGreen,
          onPressed: (){
            editUser();
            if(arguments["orderDetails"]["singleItem"] == "1") {
              addOrder();
              print("here");
              checkPage = true;
            }else{
              addOrderM(arguments['tPrice'],LPriceItems);
              checkPage = false;
            }

      }, label: Text("pay now",style: TextStyle(color: Colors.white),)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              featuredHeader("check Out", Icons.check),
              subtitleandPrice("Destination",""),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      width: getProportionateScreenWidth(80),
                      height: getProportionateScreenHeight(80),
                      decoration: ShapeDecoration(
                        color: kGreyShade5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                      ),
                      child: Image.asset("assets/address.jpg",fit: BoxFit.fill,),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${region},${city}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),),
                          Text("${street},${bnum}",style: Theme.of(context).textTheme.headline4!.
                          copyWith(fontSize: 14,color: kTextColorAccent),),
                          Text("${phone}",),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: getProportionateScreenHeight(30),),
              Text("Choose Payment method",style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w700),),
              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        visaSelected = kPrimaryGreen;
                        cashSeleted = kGreyShade5;
                        paymentMethod = "visa";
                        isVisaSelected = true;
                      });
                    },
                    child: Row(
                      children: [
                        ChoosePaymentMethod(visaSelected),
                        SizedBox(width: 10,),
                        Text("visa card")
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  isVisaSelected? Column(
                    children: [
                      TextFieldWidget("credicard number",Icons.credit_card,creditCard),
                      SizedBox(height: 20,),
                      TextFieldWidget("cpp",Icons.password,cpp),
                      SizedBox(height: 20,),
                      TextFieldWidget("exp date",Icons.calendar_month,expDate),
                    ],
                  ):Container(),

                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isVisaSelected = false;
                        visaSelected = kGreyShade5;
                        cashSeleted = kPrimaryGreen;
                        paymentMethod = "cash";
                      });
                    },
                    child: Row(
                      children: [
                        ChoosePaymentMethod(cashSeleted),
                        SizedBox(width: 10,),
                        Text("Cash on delivery")
                      ],
                    ),
                  ),
                ],
              ),
              Divider(height: getProportionateScreenHeight(30),),
              subtitleandPrice("sub total price",checkPage?"${int.parse(arguments["orderDetails"]["item"]["price"]) * arguments["orderDetails"]["item"].length } EGP":"${arguments["tPrice"]} EGP"),
              subtitleandPrice("deliver fee","25 EGP"),
              subtitleandPrice("total price",checkPage?"${int.parse(arguments["orderDetails"]["item"]["price"]) * arguments["orderDetails"]["item"].length + 25} EGP":"${arguments["tPrice"]} EGP"),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoosePaymentMethod extends StatelessWidget {
  var c;
  ChoosePaymentMethod(
     this.c,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(33),
      height: getProportionateScreenHeight(33),
      decoration: ShapeDecoration(
          color: c,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          )
      ),
    );
  }
}
