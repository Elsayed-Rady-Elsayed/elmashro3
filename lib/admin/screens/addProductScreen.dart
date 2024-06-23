import 'dart:io';

import 'package:elmashro3/controller/crud.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/links.dart';
import '../../widgets/textFieldWidget.dart';
class addProductScreen extends StatefulWidget {
  const addProductScreen({super.key});
  static const route = "/addProductScreen";

  @override
  State<addProductScreen> createState() => _addProductScreenState();
}

class _addProductScreenState extends State<addProductScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController serialN = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController createdat = TextEditingController();
  TextEditingController updatedat = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController isSale = TextEditingController();
  crud c = crud();
  late var mfile;
  addProduct()async{
    if(mfile == null){
      return "error";
    }
    var res = await c.postRequstWithFile(adminaddproduct, {
      "name":name.text,
      "category_id":category.text,
      "price":price.text,
      "description":desc.text,
      "quantity":quantity.text,
      "serial_number":serialN.text,
      "status":status.text,
      "created_at":createdat.text,
      "updated_at":updatedat.text,
      "is_sale":isSale.text,
    },mfile!);
    //print(res);
  }


  GetFile(s){
    return File(s);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add product"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Text("name"),
          TextFieldWidget("name", Icons.shopping_cart, name),
          SizedBox(height: 14,),
          Text("price (on EGP)"),
          TextFieldWidget("price(on EGP)", Icons.shopping_cart, price),
          SizedBox(height: 14,),
          Text("description"),
          TextFieldWidget("description", Icons.shopping_cart, desc),
          SizedBox(height: 14,),
          Text("quantity"),
          TextFieldWidget("quantity", Icons.shopping_cart, quantity),
          SizedBox(height: 14,),
          Text("serial number"),
          TextFieldWidget("serial number", Icons.shopping_cart, serialN),
          SizedBox(height: 14,),
          Text("category"),
          TextFieldWidget("category", Icons.shopping_cart, category),
          SizedBox(height: 14,),
          Text("status"),
          TextFieldWidget("status", Icons.shopping_cart, status),
          SizedBox(height: 14,),
          Text("created at"),
          TextFieldWidget("created at", Icons.shopping_cart, createdat),
          SizedBox(height: 14,),
          Text("updated at"),
          TextFieldWidget("updated at", Icons.shopping_cart, updatedat),
          SizedBox(height: 14,),
          Text("is sale"),
          TextFieldWidget("is sale", Icons.local_offer, isSale),
          SizedBox(height: 14,),
          MaterialButton(onPressed: ()async{
            XFile? xfile = await ImagePicker().pickImage(source:ImageSource.gallery);
            mfile =GetFile(xfile!.path);
          },child: Text("uplode image"),color: Colors.blue,),
          MaterialButton(onPressed: (){
            // editUser();
            print(mfile);
             addProduct();
          },child: Text("Add product"),minWidth: double.infinity,color: Colors.green,),

        ],
      ),
    );
  }
}
