import 'dart:convert';

import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/screens/MainPage.dart';
import 'package:elmashro3/screens/mapScreen.dart';
import 'package:elmashro3/utils/screenUtils.dart';
import 'package:elmashro3/widgets/backBtn.dart';
import 'package:elmashro3/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/links.dart';
import '../widgets/searchWidget.dart';
import 'homeScreen.dart';
class addAddressScreen extends StatefulWidget {
  static const routeName="/addAddressScreen";
  @override
  State<addAddressScreen> createState() => _addAddressScreenState();
}

class _addAddressScreenState extends State<addAddressScreen> {
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
  signUp()async{
    var res =await c.getRequest(getAllUsersLink);
      var l = int.parse(res["data"][res["data"].length - 1]["id"]) + 1;
      uid = l;

    if(formState.currentState!.validate() && city.text.isNotEmpty&&region.text.isNotEmpty&&street.text.isNotEmpty&&bnum.text.isNotEmpty){
      setState(() {
        isLoading = true;
      });
      var res = await c.postRequest(signUpLink, {
        "firstname":rcvdData["firstname"].toString(),
        "lastname":rcvdData["lastname"].toString(),
        "email":rcvdData["email"].toString(),
        "password":rcvdData["password"].toString(),
        "phone":rcvdData["phone"].toString(),
        "gender":rcvdData["gender"].toString(),
        "birthdate":rcvdData["birthdate"].toString(),
        "city":city.text.toString(),
        "region":region.text.toString(),
        "street":street.text.toString(),
        "bnum":street.text.toString(),
        "notes":notes.text.toString().isEmpty?"no notes":notes.text.toString(),
        "image":"not selected",
        "creditCard":"not seted",
        "cpp":"not selected1",
        "exp_data":"not selected",
        "activePoints":'0',
        "pedndingPoints":'0',
        "isPointVreified":'false',
        "status":'true',
        "created_at":DateTime.now().toString(),
        "updated_at":DateTime.now().toString(),
        "userId":uid.toString()
      });
      res = await jsonDecode(res);
      //print("${res} res");
      if(res["status"] == "success"){
        //print("added");
        Navigator.of(context).pushNamedAndRemoveUntil("/loginScreen", (route) => false);
      }else{
        //print("failed");
      }
    }else{
      Fluttertoast.showToast(
        msg: "please enter your address information",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,

      );
    }
  }
  @override
  Widget build(BuildContext context) {
    rcvdData = ModalRoute.of(context)!.settings.arguments;
    ScreenUtils().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                            child: Text("Add Address",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold),)
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(onPressed: () {
                               signUp();
                            }, child: Text("select address")),
                          ),
                        ],
                      ),
                    ),

                    // GestureDetector(
                    //   onTap: (){
                    //     Navigator.of(context).pushNamed(mapScreen.routeName);
                    //   },
                    //   child: ListTile(
                    //     leading: Container(
                    //       decoration: ShapeDecoration(
                    //           color: kPrimaryGreen,
                    //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getProportionateScreenWidth(12)))),
                    //       child: Padding(
                    //         padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                    //         child: Icon(Icons.location_on_outlined,size: getProportionateScreenWidth(28),color: Colors.white,),
                    //       ),
                    //     ),
                    //     title: Text("Current location",style: TextStyle(fontSize: getProportionateScreenWidth(20),fontWeight: FontWeight.w600),),
                    //     subtitle: Text("planet Toukh Benha"),
                    //   ),
                    // ),
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


