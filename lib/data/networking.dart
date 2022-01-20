import 'dart:convert';
import 'package:http/http.dart';
class NetworkHelper{
  String _url;

  NetworkHelper(this._url);

  Future getData() async {
    Response response  = await get(Uri.parse(_url));
    if(response.statusCode == 200){
      String data = response.body;
      return jsonDecode(data);
    }else{
      print(response.statusCode);
    }
  }
}