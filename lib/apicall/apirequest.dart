

import 'package:http/http.dart' as http;

Future<http.Response> fetchWeather() async {
  var res =
      await http.get(Uri.parse('https://modelhosting.onrender.com/predict')
          // ('127.0.0.1:8000/predict')
          );
  // res = jsonDecode(res.body);
  return res;
}
