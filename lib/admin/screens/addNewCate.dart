import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/links.dart';
import '../../controller/crud.dart';
import '../../widgets/textFieldWidget.dart';
class AddNewCategory extends StatefulWidget {
  const AddNewCategory({super.key});

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  TextEditingController name = TextEditingController();
  crud c = crud();
  late var mfile;
  addcategory()async{
    if(mfile == null){
      return "error";
    }
    var res = await c.postRequstWithFile(addNewCategory, {
      "name":name.text,
      "status":"1",
      "created_at":DateTime.now().toString(),
      "updated_at":DateTime.now().toString()
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
          TextFieldWidget("name", Icons.category, name),
          SizedBox(height: 14,),
          MaterialButton(onPressed: ()async{
            XFile? xfile = await ImagePicker().pickImage(source:ImageSource.gallery);
            mfile =GetFile(xfile!.path);
          },child: Text("uplode image"),color: Colors.blue,),
          MaterialButton(onPressed: (){
            addcategory();
          },child: Text("Add Category"),minWidth: double.infinity,color: Colors.green,),

        ],
      ),
    );
  }
}
