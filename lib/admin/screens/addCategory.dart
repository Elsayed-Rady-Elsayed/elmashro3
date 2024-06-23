import 'package:elmashro3/constants/colors.dart';
import 'package:elmashro3/controller/crud.dart';
import 'package:flutter/material.dart';

import '../../constants/links.dart';
import 'addNewCate.dart';
class addCategory extends StatefulWidget {
  const addCategory({super.key});

  @override
  State<addCategory> createState() => _addCategoryState();
}

class _addCategoryState extends State<addCategory> {
  crud c = crud();
  var category = [];
  getCategory()async{
    var res = await c.getRequest(getAllCategory);
    category = res["data"];
    setState(() {

    });
    print(res);
  }
  @override
  Widget build(BuildContext context) {
    getCategory();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryGreen,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddNewCategory();
          }));
        },
        child: Text("+"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: category.length,
            itemBuilder: (context,index){
              return GestureDetector(
                // onTap: (){
                //   Navigator.of(context).pushNamed(userinfo.route,arguments: {
                //     "data":users[index]
                //   });
                // },
                child: ListTile(
                  title: Text("${category[index]["name"]}"),
                  leading: Image.network("${imgRoute}/${category[index]["image"]}"),
                ),
              );
            }),
      ),
    );
  }
}
