import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
class crud{
  getRequest(String url)async{
    try{
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var resbonsebody = jsonDecode(response.body);
        return resbonsebody;
      }else{
        print(response.statusCode);
      }
    }catch(e){
      print(e);
    }
  }
  postRequest(String url,Map data)async{
    try{
      var response = await http.post(Uri.parse(url),body: data);
      if(response.statusCode == 200){
        // var resbonsebody = jsonDecode(response.body);
        return response.body;
      }else{
        print(response.statusCode);
      }
    }catch(e){
      print("rer");
      print(e);
      print("rer");

    }
  }
  postRequstWithFile(String url,Map data,File file)async{
    var req = http.MultipartRequest("POST",Uri.parse(url));
    var length =await file.length();
    var stream = http.ByteStream(file.openRead());
    var multiPartFile = http.MultipartFile("image",stream,length,filename: basename(file.path));
    req.files.add(multiPartFile);
    data.forEach((key, value) {
      req.fields[key] = value;
    });
    var myreq =await req.send();
    var response = await http.Response.fromStream(myreq);
    if(myreq.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return "fail here";
    }
  }
}