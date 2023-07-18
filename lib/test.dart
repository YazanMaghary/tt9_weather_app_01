import 'dart:convert';

import 'package:http/http.dart' as http;

String url = "https://valorant-api.com/v1/agents";
void main(List<String> args) {
  print(getData());
}

Future<void> getData() async {
  http.Response response = await http.get(Uri.parse(url));
  var x = jsonDecode(response.body);
  print(x['data'][4]);
}
