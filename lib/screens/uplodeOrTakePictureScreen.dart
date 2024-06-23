// import 'dart:convert';
// import 'dart:io';
//
// import 'package:elmashro3/constants/colors.dart';
// import 'package:elmashro3/screens/recyclingRecipe.dart';
// import 'package:elmashro3/utils/screenUtils.dart';
// import 'package:elmashro3/widgets/CustomeAppBar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_vision/flutter_vision.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'dart:async';
// import 'package:flutter_vision/flutter_vision.dart';
// import 'package:image_picker/image_picker.dart';
// import '../widgets/textFieldWidget.dart';
// enum Options { none, imagev5, imagev8, imagev8seg, frame, tesseract, vision }
// class uplodeOrTakePictrureScreen extends StatefulWidget {
//   const uplodeOrTakePictrureScreen({super.key});
//   static const routeName = "/uplodeOrTakePictrureScreen";
//   @override
//   State<uplodeOrTakePictrureScreen> createState() => _uplodeOrTakePictrureScreenState();
// }
//
// class _uplodeOrTakePictrureScreenState extends State<uplodeOrTakePictrureScreen> {
//   // FlutterVision vision = FlutterVision();
//   // loadModel()async{
//   //   await vision.loadYoloModel(
//   //       labels: 'assets/labels.txt',
//   //       modelPath: 'assets/model_float32.tflite',
//   //       modelVersion: "yolov8",
//   //       quantization: false,
//   //       numThreads: 1,
//   //       useGpu: false
//   //   );
//   // }
//   // var s = "";
//   // Future<List<dynamic>> getResult({required var bytesList, required int imageHeight, required int imageWidth,}) async {
//   //   // Initialize the vision module
//   //
//   //   try {
//   //     // Perform object detection using YOLO model
//   //     final result = await vision.yoloOnImage(
//   //       bytesList: bytesList,
//   //       imageHeight: imageHeight,
//   //       imageWidth: imageWidth,
//   //       iouThreshold: 0.8,
//   //       confThreshold: 0.4,
//   //       classThreshold: 0.7,
//   //     );
//   //     s = result.toString();
//   //     print("result ${result}");
//   //     return result;
//   //   } catch (e) {
//   //     print('Error during object detection: $e');
//   //     return [];
//   //   }
//   // }
//   // XFile? image;
//   //
//   // final ImagePicker picker = ImagePicker();
//   // String selectedItem = "";
//   // var controller = TextEditingController();
//   // //we can upload image from camera or from gallery based on parameter
//   // var f;
//   // Future getImage(ImageSource media) async {
//   //   var img = await picker.pickImage(source: media);
//   //   setState(() {
//   //     image = img;
//   //     loadImageBytes(image!.path);
//   //   });
//   //
//   // }
//   // Future<List<int>> loadImageBytes(String imagePath) async {
//   //   // Load image bytes from file
//   //   final file = File(imagePath);
//   //   // print(file.readAsBytes());
//   //
//   //   return await file.readAsBytes();
//   // }
//   TextEditingController controller = TextEditingController();
//   final FlutterVision vision = FlutterVision();
//   XFile? image;
//   final ImagePicker picker = ImagePicker();
//   String _result = '';
//   bool _isModelLoaded = false;
//   String tag = "tag : ";
//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }
//
//   Future<void> loadModel() async {
//     try {
//       await vision.loadYoloModel(
//         labels: 'assets/labels.txt',
//         modelPath: 'assets/model_float32.tflite',
//         modelVersion: "yolov8",
//         quantization: false,
//         numThreads: 1,
//         useGpu: false,
//       );
//       setState(() {
//         _isModelLoaded = true;
//       });
//     } catch (e) {
//       print('Error loading model: $e');
//     }
//   }
//
//   Future<void> getResult({required Uint8List bytesList, required int imageHeight, required int imageWidth}) async {
//     try {
//       final result = await vision.yoloOnImage(
//         bytesList: bytesList,
//         imageHeight: imageHeight,
//         imageWidth: imageWidth,
//         iouThreshold: 0.8,
//         confThreshold: 0.4,
//         classThreshold: 0.7,
//       );
//       setState(() {
//         _result = result.toString();
//         // print(_result);
//         //l = jsonDecode(_result);
//         //print(l.length);
//         // tag += l[0]["tag"].toString();
//        //  print("tag is : ${tag}");
//       });
//     } catch (e) {
//       print('Error during object detection: $e');
//     }
//   }
//
//   Future<void> getImage(ImageSource media) async {
//     try {
//       var img = await picker.pickImage(source: media);
//       if (img != null) {
//         setState(() {
//           image = img;
//         });
//         Uint8List imageBytes = await loadImageBytes(image!.path);
//         int imageHeight = await getImageHeight(imageBytes);
//         int imageWidth = await getImageWidth(imageBytes);
//
//         await getResult(bytesList: imageBytes, imageHeight: imageHeight, imageWidth: imageWidth);
//       }
//     } catch (e) {
//       print('Error getting image: $e');
//     }
//   }
//
//   Future<Uint8List> loadImageBytes(String imagePath) async {
//     final file = File(imagePath);
//     return await file.readAsBytes();
//   }
//
//   Future<int> getImageHeight(Uint8List imageBytes) async {
//     final decodedImage = await decodeImageFromList(imageBytes);
//     return decodedImage.height;
//   }
//
//   Future<int> getImageWidth(Uint8List imageBytes) async {
//     final decodedImage = await decodeImageFromList(imageBytes);
//     return decodedImage.width;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body:SafeArea(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 BackButton(color: kPrimaryGreen,),
//                 Spacer(),
//                 Text("uplode picture ${tag}",style: Theme.of(context).textTheme.headline6,),
//                 Spacer(),
//                 IconButton(onPressed: (){
//                   getImage(ImageSource.gallery);
//                 }, icon: Icon(Icons.image,color: kPrimaryGreen,))
//               ],
//             ),
//             Expanded(
//               child: Column(
//                 children: [
//                   image != null
//                       ? Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.file(
//                         //to show image, you type like this.
//                         File(image!.path),
//                         fit: BoxFit.contain,
//                         width: MediaQuery.of(context).size.width,
//                         height: 300,
//                       ),
//                     ),
//                   )
//                       : Text(
//                     "No Image",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: getProportionateScreenHeight(15),),
//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(style: ButtonStyle(
//                             backgroundColor:image == null ? MaterialStateProperty.all(kGreyShade5): MaterialStateProperty.all(kPrimaryRed),
//                           ),onPressed: (){
//                             setState(() {
//                               image = null;
//                             });
//                           }, child: Text("remove Picture")),
//                         ),
//                         SizedBox(width: getProportionateScreenHeight(15),),
//                         Expanded(
//                           child: ElevatedButton(style: ButtonStyle(
//                             backgroundColor:image == null ? MaterialStateProperty.all(kGreyShade5): MaterialStateProperty.all(kPrimaryGreen),
//                           ),onPressed: (){
//                             if(image != null){
//                               Navigator.of(context).pushNamed(RecipeRecycleScreen.routeName,arguments: {
//                                 "image": image,
//                                 "quantity":controller.text,
//                                 "data":_result
//                               });
//                             }
//                           }, child: GestureDetector(onTap: ()async{
//                             // getImage(ImageSource.gallery);
//                             // var l = jsonDecode(_result);
//                           },child: Text("Uplode Picture"))),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//           ],
//         ),
//       ) ,
//     );
//   }
// }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_vision/flutter_vision.dart';
//
// class uplodeOrTakePictrureScreen extends StatefulWidget {
//     static const routeName = "/uplodeOrTakePictrureScreen";
//
//   @override
//   _UploadPictureScreenState createState() => _UploadPictureScreenState();
// }
//
// class _UploadPictureScreenState extends State<uplodeOrTakePictrureScreen> {
//   File? image;
//   final TextEditingController controller = TextEditingController();
//   String _result = ""; // Assuming you have some result data to pass
//   final String tag = "exampleTag"; // Example tag, replace with actual tag
//   FlutterVision vision = FlutterVision();
//   List<Map<String, dynamic>> detections = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVision();
//   }
//
//   Future<void> _initializeVision() async {
//     await vision.loadYoloModel(
//         labels: 'assets/labels.txt',
//         modelPath: 'assets/model_float32.tflite',
//         modelVersion: "yolov8",
//         quantization: false,
//         numThreads: 1,
//         useGpu: false
//       );
//   }
//
//   Future<void> getImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//
//     if (pickedFile != null) {
//       setState(() {
//         image = File(pickedFile.path);
//       });
//       await _detectObjects(File(pickedFile.path));
//     } else {
//       print('No image selected.');
//     }
//   }
//
//   Future<void> _detectObjects(File imageFile) async {
//     final bytes = await imageFile.readAsBytes();
//     final result = await vision.yoloOnImage(
//       bytesList: bytes,
//       imageHeight: imageFile.lengthSync(), // Approximate height
//       imageWidth: imageFile.lengthSync(),  // Approximate width
//       iouThreshold: 0.8,
//       confThreshold: 0.4,
//       classThreshold: 0.7,
//     );
//
//     setState(() {
//       detections = List<Map<String, dynamic>>.from(result);
//     });
//   }
//
//   @override
//   void dispose() {
//     vision.closeYoloModel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 BackButton(color: Colors.green), // Replace kPrimaryGreen with Colors.green or your custom color
//                 Spacer(),
//                 Text(
//                   "Upload picture ${detections.isNotEmpty?detections.length:""} ${detections.isNotEmpty?detections[0]["tag"]:""}",
//                   style: Theme.of(context).textTheme.headline6,
//                 ),
//                 Spacer(),
//                 IconButton(
//                   onPressed: () {
//                     getImage(ImageSource.gallery);
//                   },
//                   icon: Icon(Icons.image, color: Colors.green), // Replace kPrimaryGreen with Colors.green or your custom color
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Column(
//                 children: [
//                   image != null
//                       ? Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Stack(
//                         children: [
//                           Image.file(
//                             File(image!.path),
//                             fit: BoxFit.contain,
//                             width: MediaQuery.of(context).size.width,
//                             height: 300,
//                           ),
//                           ...detections.map((det) {
//                             final box = det['box'];
//                             return Positioned(
//                               left: box[0],
//                               top: box[1],
//                               width: box[2] - box[0],
//                               height: box[3] - box[1],
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.red, width: 2),
//                                 ),
//                                 child: Text(
//                                   det['tag'],
//                                   style: TextStyle(
//                                     backgroundColor: Colors.red,
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ],
//                       ),
//                     ),
//                   )
//                       : Text(
//                     "No Image",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 15), // Use a static value instead of getProportionateScreenHeight
//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all(image == null ? Colors.grey : Colors.red), // Replace kGreyShade5 and kPrimaryRed with Colors.grey and Colors.red or your custom colors
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 image = null;
//                                 detections.clear();
//                               });
//                             },
//                             child: Text("Remove Picture"),
//                           ),
//                         ),
//                         SizedBox(width: 15), // Use a static value instead of getProportionateScreenHeight
//                         Expanded(
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all(image == null ? Colors.grey : Colors.green), // Replace kGreyShade5 and kPrimaryGreen with Colors.grey and Colors.green or your custom colors
//                             ),
//                             onPressed: () {
//                               if (image != null) {
//                                 print(detections[0]["tag"]);
//                                 // Navigator.of(context).pushNamed(
//                                 //   '/RecipeRecycleScreen', // Replace with your actual route
//                                 //   arguments: {
//                                 //     "image": image,
//                                 //     "quantity": controller.text,
//                                 //     "data": _result,
//                                 //   },
//                                 // );
//                               }
//                             },
//                             child: Text("Upload Picture"),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:typed_data';
import 'package:elmashro3/controller/crud.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_vision/flutter_vision.dart';

import '../constants/links.dart';
import '../main.dart';

class uplodeOrTakePictrureScreen extends StatefulWidget {
    static const routeName = "/uplodeOrTakePictrureScreen";

  @override
  _UploadPictureScreenState createState() => _UploadPictureScreenState();
}

class _UploadPictureScreenState extends State<uplodeOrTakePictrureScreen> {
  File? image;
  final TextEditingController controller = TextEditingController();
  String _result = ""; // Assuming you have some result data to pass
  final String tag = "exampleTag"; // Example tag, replace with actual tag
  FlutterVision vision = FlutterVision();
  List<Map<String, dynamic>> detections = [];
  var showErr = false;
  @override
  void initState() {
    super.initState();
    _initializeVision();
  }

  Future<void> _initializeVision() async {
    await vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/modelLast.tflite',
        modelVersion: "yolov8",
        quantization: false,
        numThreads: 1,
        useGpu: false
    );
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      await _detectObjects(File(pickedFile.path));
    } else {
      print('No image selected.');
    }
  }

  Future<void> _detectObjects(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final decodedImage = await decodeImageFromList(bytes);

    final result = await vision.yoloOnImage(
      bytesList: bytes,
      imageHeight: decodedImage.height,
      imageWidth: decodedImage.width,
      iouThreshold: 0.8,
      confThreshold: 0.4,
      classThreshold: 0.7,
    );

    setState(() {
      detections = List<Map<String, dynamic>>.from(result);
    });
  }

  @override
  void dispose() {
    vision.closeYoloModel();
    super.dispose();
  }
  crud c=crud();
  GetFile(s){
    return File(s);
  }
  addImgToRecyclingImg()async{
    var response = await c.postRequstWithFile(addImageToRecycling, {
      "user_id":sharedPreferences.getString("id"),
      "created_at":DateTime.now().toString(),
      "updated_at":DateTime.now().toString(),
    },File(image!.path));
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                BackButton(color: Colors.green), // Replace kPrimaryGreen with Colors.green or your custom color
                Spacer(),
                Text(
                  "Upload picture",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image, color: Colors.green), // Replace kPrimaryGreen with Colors.green or your custom color
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  image != null
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        children: [
                          Image.file(
                            File(image!.path),
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width,
                            height: 400,
                          ),
                        ],
                      ),
                    ),
                  )
                      : Text(
                    "No Image",
                    style: TextStyle(fontSize: 20),
                  ),
                  showErr ? Text("unknown object",style: TextStyle(color: Colors.red,fontSize: 30),) : Container(),
                  SizedBox(height: 15), // Use a static value instead of getProportionateScreenHeight
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(image == null ? Colors.grey : Colors.red), // Replace kGreyShade5 and kPrimaryRed with Colors.grey and Colors.red or your custom colors
                            ),
                            onPressed: () {
                              setState(() {
                                image = null;
                                detections.clear();
                              });
                            },
                            child: Text("Remove Picture"),
                          ),
                        ),
                        SizedBox(width: 15), // Use a static value instead of getProportionateScreenHeight
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(image == null ? Colors.grey : Colors.green), // Replace kGreyShade5 and kPrimaryGreen with Colors.grey and Colors.green or your custom colors
                            ),
                            onPressed: () {
                              if (image != null && detections.isNotEmpty) {
                                print(detections);
                                addImgToRecyclingImg();
                                Navigator.of(context).pushNamed(
                                  '/RecipeRecycleScreen', // Replace with your actual route
                                  arguments: {
                                    "image": image,
                                    "quantity": controller.text,
                                    "data": detections,
                                  },
                                );
                                setState(() {
                                  showErr = false;
                                });
                              }else{
                                setState(() {
                                  showErr = true;
                                });
                              }
                            },
                            child: Text("Upload Picture"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


