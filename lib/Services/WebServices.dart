import 'dart:convert';

import 'package:flutter_food_app_demo/Model/ProductModel.dart';
import 'package:http/http.dart' as http;

class Services{
  Future<List<ProductModel>> fetchPicturesAPI() async{
    String url="https://issg.shopfast.net/api/v1/catalog/products/app-products";
    final responce = await http.get(Uri.parse(url));
    if(responce.statusCode==200){
      print(responce.body.toString());
      final json=jsonDecode(responce.body) as List<dynamic>;
      final listresult=json.map((e) => ProductModel.fromJson(e)).toList();
      print(listresult[0].Name);
      return listresult;
    }
    else{
      throw Exception('Error to Fetch the data');
    }
  }
}