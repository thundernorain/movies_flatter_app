import 'dart:convert';

import 'package:http/http.dart';

class Network{
  final String url;

  Network(this.url);

  // This method gets a json from url
  Future fetchData() async{
    Response response = await get(Uri.encodeFull(url));

    if(response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      print(response.statusCode);
    }
  }
}