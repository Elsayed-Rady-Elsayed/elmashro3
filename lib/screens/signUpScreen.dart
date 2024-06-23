import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/screens/add_address.dart';
import 'package:elmashro3/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:elmashro3/constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../constants/links.dart';
import '../utils/screenUtils.dart';
import '../widgets/backBtn.dart';
import '../widgets/elevatedWidget.dart';
import '../widgets/orWidget.dart';
import '../widgets/textFieldWidget.dart';
import 'MainPage.dart';
class registerScreen extends StatefulWidget {
  static const routeName = "/registerScreen";

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  TextEditingController dateInput = TextEditingController();
  bool selectedItem = false;
  GlobalKey<FormState>formState = GlobalKey();
  bool isLoading = false;
  crud c = crud();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    // dateInput.text = "";
    ScreenUtils().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backBtn(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth((16))),
                child: Form(
                  key: formState,
                  child: Column(
                    children: [
                      Align(
                          alignment:Alignment.centerLeft,
                          child: Text("Register Continue",style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold),)),
                      SizedBox(height: getProportionateScreenHeight(12),),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(
                              flex:2,
                              child: TextFieldWidget("First Name",Icons.person,firstname)),
                          SizedBox(width: getProportionateScreenWidth(10),),
                          Expanded(
                              flex: 2,
                              child: TextFieldWidget("Last Name",Icons.person,lastname)),
                        ],
                      ),
                      Spacer(),
                      TextFieldWidget("phone number",Icons.phone,phone),
                      Spacer(),
                      TextFieldWidget("email", Icons.email,email),
                      Spacer(),
                      TextFieldWidget("password", Icons.visibility_sharp,password),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
                              borderSide: BorderSide(color: kGreyShade3),
                            ),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
                              borderSide: BorderSide(color: kGreyShade3),
                            ),
                            suffixIcon: Icon(Icons.date_range),
                            hintText: dateInput.text.isEmpty?"birth date":dateInput.text,
                            hintStyle: Theme.of(context).textTheme.headline4!.copyWith(color: kGreyShade3)
                        ),
                        readOnly: true,
                        controller: dateInput,
                        onTap: () async {
                           pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            print(
                                pickedDate);
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate!);
                            print(
                                formattedDate);
                            setState(() {
                              dateInput.text =
                                  formattedDate.toString();
                            });
                          } else {}
                        },
                      ),
                      Spacer(),
                      DropdownButton(
                        icon: Icon(Icons.person),
                          isExpanded: true,
                          value: selectedItem==false?false:selectedItem,
                          items: [
                        DropdownMenuItem(child: Text("male"),value: true,),
                        DropdownMenuItem(child: Text("female"),value:false),
                      ], onChanged: (selected){
                        setState(() {
                          selectedItem = selected==false?false:true;
                        });
                      }),
                      Spacer(),
                      ElevatedButton(onPressed: (){
                        if(firstname.text.isNotEmpty && lastname.text.isNotEmpty && email.text.isNotEmpty && email.text.toLowerCase().contains("@gmail.com")&&password.text.isNotEmpty&&password.text.length>6&&pickedDate.toString().isNotEmpty&&selectedItem.toString().isNotEmpty){
                          Navigator.of(context).pushNamed(addAddressScreen.routeName,arguments: {
                            "firstname":firstname.text,
                            "lastname":lastname.text,
                            "email":email.text,
                            "password":password.text,
                            "phone":phone.text,
                            "gender":selectedItem,
                            "birthdate":pickedDate,
                          });
                        }else{
                          Fluttertoast.showToast(
                            msg: "please enter valid data",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,

                          );
                        }

                      }, child: Text("Register")),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(loginScreen.routName,arguments: {
                            "firstname":"sa",
                            // "lastname":lastname.text,
                            // "email":email.text,
                            // "password":password.text,
                            // "phone":phone.text,
                            // "gender":selectedItem,
                            // "birthdate":pickedDate,
                          });
                        },
                        child: RichText(
                            text: TextSpan(text: "have an account?",style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kPrimaryGreen,fontWeight: FontWeight.bold)
                            )
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

