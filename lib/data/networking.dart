import 'dart:convert';
import 'package:http/http.dart';
class NetworkHelper{
  final String _url;

  NetworkHelper(this._url);

  Future getData() async {
    final Response response  = await get(Uri.parse(_url));
    if(response.statusCode == 200){
      final String data = response.body;
      return jsonDecode(data);
    }else{
      print(response.statusCode);
    }
  }
}
