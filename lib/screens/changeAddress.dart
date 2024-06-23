import 'dart:convert';

import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/main.dart';

import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/backBtn.dart';
import 'package:elmashro3/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import '../constants/links.dart';
import '../widgets/searchWidget.dart';
import 'homeScreen.dart';
class editAddressScreen extends StatefulWidget {
  static const routeName="/editAddressScreen";

  @override
  State<editAddressScreen> createState() => _editAddressScreenState();
}

class _editAddressScreenState extends State<editAddressScreen> {
  TextEditingController city= TextEditingController();

  TextEditingController region= TextEditingController();

  TextEditingController street= TextEditingController();

  TextEditingController bnum= TextEditingController();

  TextEditingController notes= TextEditingController();

  GlobalKey<FormState>formState = GlobalKey();

  bool isLoading = false;

  crud c = crud();

  var rcvdData;

  int? uid;

  getAddress()async{
    var res1 = await c.postRequest(getregionLink, {
      "userId":sharedPreferences.getString("id"),
    });
    res1 = jsonDecode(res1);
    region.text = res1["data"][0]["name"];
    var res2 = await c.postRequest(getcityLink, {
      "userId":sharedPreferences.getString("id"),
    });
    res2 = jsonDecode(res2);
    city.text = res2["data"][0]["name"];
    var res3 = await c.postRequest(getaddressLink, {
      "userId":sharedPreferences.getString("id"),
    });
    res3 = jsonDecode(res3);
    street.text = res3["data"][0]["street"];
    bnum.text = res3["data"][0]["building"];
    notes.text = res3["data"][0]["notes"];
  }

  editAddress()async{
    region.text.isEmpty?"":region.text;
    city.text.isEmpty?"":city.text;
    street.text.isEmpty?"":street.text;
    bnum.text.isEmpty?"":bnum.text;
    notes.text.isEmpty?"":notes.text;
    var res = await c.postRequest(editAddressLink, {
      "city":city.text,
      "region":region.text,
      "street":street.text,
      "bnum":bnum.text,
      "notes":notes.text,
      "user_id":sharedPreferences.getString("id"),
    });
    print(res);
    print("address changes");
  }
@override
  void initState() {
    // TODO: implement initState
  getAddress();
  setState(() {

  });
    super.initState();
  }
  @override

  Widget build(BuildContext context) {

    ScreenUtils().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backBtn(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Align(
                            alignment:Alignment.centerLeft,
                            child: Text("change Address",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold),)
                        ),
                        Spacer(),
                        Image.asset("assets/map.png"),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(15),),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("we will find you whereever you are living ",
                          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 16,color: kTextColorAccent),)
                    ),
                    SizedBox(height: getProportionateScreenHeight(15),),
                    SearchField(),
                    SizedBox(height: getProportionateScreenHeight(15),),
                    Divider(),
                    SizedBox(height: getProportionateScreenHeight(15),),
                    SizedBox(height: getProportionateScreenHeight(15),),
                    Form(
                      key: formState,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("city",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w600),),
                              SizedBox(height: getProportionateScreenHeight(15),),
                              TextFieldWidget("city name", Icons.location_city,city),
                              SizedBox(height: getProportionateScreenHeight(15),),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: getProportionateScreenHeight(15),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("region",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w600),),
                              SizedBox(height: getProportionateScreenHeight(15),),
                              TextFieldWidget("region name", Icons.cabin_sharp,region),
                              SizedBox(height: getProportionateScreenHeight(15),),
                            ],
                          ),
                          Divider(),
                          Text("details",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w600),),
                          SizedBox(height: getProportionateScreenHeight(15),),
                          TextFieldWidget("street", Icons.house_siding_rounded,street),
                          SizedBox(height: getProportionateScreenHeight(15),),
                          TextFieldWidget("building number", Icons.home_work_outlined,bnum),
                          SizedBox(height: getProportionateScreenHeight(15),),
                          TextFieldWidget("notes(optional)", Icons.note,notes),
                          Divider(height: getProportionateScreenHeight(15),),
                          ElevatedButton(onPressed: () {
                            editAddress();

                          }, child: Text("change address")),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        // Navigator.of(context).pushNamed(mapScreen.routeName);
                      },
                      child: ListTile(
                        leading: Container(
                          decoration: ShapeDecoration(
                              color: kPrimaryGreen,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getProportionateScreenWidth(12)))),
                          child: Padding(
                            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                            child: Icon(Icons.location_on_outlined,size: getProportionateScreenWidth(28),color: Colors.white,),
                          ),
                        ),
                        title: Text("Current location",style: TextStyle(fontSize: getProportionateScreenWidth(20),fontWeight: FontWeight.w600),),
                        subtitle: Text("planet Toukh Benha"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


