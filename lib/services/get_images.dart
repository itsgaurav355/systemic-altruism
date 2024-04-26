import 'dart:convert';

import 'package:http/http.dart' as http;

class GetImages {
  Future<List<String>> getImage() async {
    List<String> res = [];
    try {
      var response =
          await http.get(Uri.parse("https://fakestoreapi.com/products"));
      if (response.statusCode == 200) {
        // Parse the response body as JSON
        List<dynamic> data = json.decode(response.body);
        // Iterate through the data and extract image URLs
        for (int i = 0; i < data.length; i++) {
          //since the image URLs are stored in a field called 'image'
          res.add(data[i]['image']);
        }
      } else {
        throw Exception('Failed to fetch images');
      }
    } catch (e) {
      rethrow;
    }
    return res;
  }
}
