import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/links.dart';
import '../../controller/crud.dart';
import '../../widgets/backBtn.dart';
import '../../widgets/textFieldWidget.dart';
class viewProductDetails extends StatefulWidget {
  static const route = "/adminViewProductDetails";
  const viewProductDetails({super.key});

  @override
  State<viewProductDetails> createState() => _viewProductDetailsState();
}

class _viewProductDetailsState extends State<viewProductDetails> {
  var rcvdData;
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController serialN = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController createdat = TextEditingController();
  TextEditingController updatedat = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController img = TextEditingController();
  TextEditingController isSale = TextEditingController();
  @override
  void setData(){
    print(rcvdData["data"]["category_id"]);
    name.text = rcvdData["data"]["name"];
    id.text = rcvdData["data"]["id"];
    price.text = rcvdData["data"]["price"];
    desc.text = rcvdData["data"]["description"];
    img.text = rcvdData["data"]["image"];
    quantity.text = rcvdData["data"]["quantity"].toString();
    serialN.text = rcvdData["data"]["serial_number"];
    category.text = rcvdData["data"]["category_id"];
    status.text = rcvdData["data"]["status"];
    createdat.text = rcvdData["data"]["created_at"];
    updatedat.text = rcvdData["data"]["updated_at"];
    isSale.text = rcvdData["data"]["is_sale"];
    setState(() {

    });
  }
  crud c = crud();
  late var mfile;

  editUser()async{
    var res = await c.postRequstWithFile(adminEditproduct, {
      "name":name.text,
      "category_id":category.text,
      "price":price.text,
      "description":desc.text,
      "quantity":quantity.text,
      "serial_number":serialN.text,
      "status":status.text,
      "created_at":createdat.text,
      "updated_at":updatedat.text,
      "product_id":rcvdData["data"]["id"],
      "is_sale":isSale.text,
    },mfile);
    print(res);
  }

  GetFile(s){
    return File(s);
  }
  @override
  Widget build(BuildContext context) {
    rcvdData = ModalRoute.of(context)!.settings.arguments;
    setData();
    return Scaffold(
      appBar: AppBar(
        leading: backBtn(),
        title: Text("product information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text("name"),
            TextFieldWidget("name", Icons.shopping_cart, name),
            SizedBox(height: 14,),
            Text("id"),
            TextFieldWidget("id", Icons.shopping_cart, id),
            SizedBox(height: 14,),
            Text("price (on EGP)"),
            TextFieldWidget("price(on EGP)", Icons.shopping_cart, price),
            SizedBox(height: 14,),
            Text("description"),
            TextFieldWidget("description", Icons.shopping_cart, desc),
            SizedBox(height: 14,),
            Text("image"),
            TextFieldWidget("image", Icons.shopping_cart, img),
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
            TextFieldWidget("is sale", Icons.shopping_cart, isSale),
            SizedBox(height: 14,),
            MaterialButton(onPressed: ()async{
              XFile? xfile = await ImagePicker().pickImage(source:ImageSource.gallery);
              mfile =GetFile(xfile!.path);
            },child: Text("uplode image"),color: Colors.blue,),
            SizedBox(height: 14,),
            MaterialButton(onPressed: (){
              editUser();
            },child: Text("Edit product"),minWidth: double.infinity,color: Colors.green,),

          ],
        ),
      ),
    );
  }
}
