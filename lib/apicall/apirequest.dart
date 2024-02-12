import 'dart:convert';

import 'package:http/http.dart' as http;

int modelno = 1;
Future<http.Response> fetchWeather(int model) async {
  var res = await http
      .get(Uri.parse('https://modelhosting.onrender.com/predict/$model')
          // ('http://192.168.31.196:8000/predict/$model')
          );
  // res = jsonDecode(res.body);
  return res;
}

getdata() async {
  final variable = await fetchWeather(modelno);
  final res = jsonDecode(variable.body);
  return res;
  // res["prediction"];
  // print(res.runtimeType);
  // print(res['prediction']);
}
