import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:elmashro3/admin/screens/home.dart';
import 'package:elmashro3/controller/crud.dart';
import 'package:elmashro3/screens/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../constants/links.dart';
import '../main.dart';
import '../widgets/CustomeAppBar.dart';
import '../widgets/infoWidget.dart';

class RecipeRecycleScreen extends StatefulWidget {
  static const routeName = "/RecipeRecycleScreen";

  @override
  State<RecipeRecycleScreen> createState() => _RecipeRecycleScreenState();
}

class _RecipeRecycleScreenState extends State<RecipeRecycleScreen> {
TextEditingController c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    List<Map<String, dynamic>> data = arguments['data'];
    File imageFile = arguments['image']!;
    var items = [5,3,7];
    int itemPoints = 0;
    int points = 0;
    if(data[0]["tag"] == "carton"){
      points =data.length * items[0];
      itemPoints = items[0];
    }else if(data[0]["tag"] == "can"){
      points =data.length * items[2];
      itemPoints = items[2];
    }else{
      points =data.length * items[1];
      itemPoints = items[1];
    }
    print("data is ${data.length}");
    crud c = crud();
    addToProcessFunc()async{
      var response = await c.postRequest(addToProcess, {
        "customer_id":sharedPreferences.getString("id"),
        "item_points":itemPoints.toString(),
        "process_points":points.toString(),
        "items":"${data.length} ${data[0]["tag"]}",
        "recived_items":false.toString(),
      });

      setState(() {

      });
    }
    editPend()async{
      var user =await c.postRequest(getSpecificUser, {
        "userId":sharedPreferences.getString("id"),
      });
      user = jsonDecode(user);
      print(user["data"][0]["pending_points"]);
      var oldPoints = user["data"][0]["pending_points"];
      var totalPoints = int.parse(oldPoints)+points;
      print(totalPoints);
      var editPoints = await c.postRequest(pendingPoints, {
        "pending_points":totalPoints.toString(),
        "user_id":sharedPreferences.getString("id")
      });
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and icon
                featuredHeader("Recipe", Icons.receipt),

                // Points information widget
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // InfoLine("Points", c, true),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Text("points",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            Spacer(),
                            Text(points.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      // Display image with detected objects
                      SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: Stack(
                          children: [
                            Image.file(
                              width: MediaQuery.of(context).size.width,
                              imageFile,
                              fit: BoxFit.cover,
                            ),

                            // CustomPaint to draw rectangles
                            CustomPaint(
                              painter: BoxPainter(data, imageFile.path),
                            ),
                          ],
                        ),
                      ),
                      // Display detected object tags
                      Text(
                        "you enterd ${data.length} ${data[0]["tag"]}",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black, // Example color, adjust as needed
                        ),
                      ),
                      Text("data of entering image:${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())}",
                        // data.map((item) => item["tag"].toString()).join(","),
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black, // Example color, adjust as needed
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                          ),
                          onPressed: () {
                            addToProcessFunc();
                            editPend();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return MainPage();
                            }));
                          },
                          child: Text("confirm process"),
                        ),
                      ),
                      SizedBox(width: 15), // Use a static value instead of getProportionateScreenHeight

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom painter to draw rectangles around detected objects
class BoxPainter extends CustomPainter {
  final List<Map<String, dynamic>> detections;
  final String imagePath;

  BoxPainter(this.detections, this.imagePath);

  @override
  void paint(Canvas canvas, Size size) {
    if (detections.isEmpty) return;

    loadImage(imagePath).then((ui.Image image) {
      if (image == null) return;

      final double scaleX = size.width / image.width.toDouble();
      final double scaleY = size.height / image.height.toDouble();

      final Paint paint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      detections.forEach((detection) {
        final List<dynamic> box = detection['box'];

        final Rect rect = Rect.fromLTRB(
          box[0] * scaleX,
          box[1] * scaleY,
          box[2] * scaleX,
          box[3] * scaleY,
        );

        canvas.drawRect(rect, paint);

        TextPainter painter = TextPainter(
          text: TextSpan(
            text: detection['tag'].toString(),
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.red,
              fontSize: 12,
            ),
          ),
          textAlign: TextAlign.left,
          // textDirection: TextDirection.ltr,
        );

        painter.layout();
        painter.paint(canvas, Offset(rect.left, rect.top));
      });
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Future<ui.Image> loadImage(String imagePath) async {
    File imageFile = File(imagePath);
    final bytes = await imageFile.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}