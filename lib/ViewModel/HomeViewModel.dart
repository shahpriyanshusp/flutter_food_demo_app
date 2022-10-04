import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

import '../Model/ProductModel.dart';
import '../Services/WebServices.dart';
import '../Services/sqlite_main.dart';

class HomeViewViewModel with ChangeNotifier {
  List<ProductModel>? products;
  // Future<List<ProductModel>> futuredata=Future<List<ProductModel>>([]);
  Location location=new Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  PermissionStatus? permissionGranted;
  LocationData? _locationData;
  final dbHelper = DatabaseHelper.instance;


  Future<List<ProductModel>?> fetchdata() async{

      print("main");
      products=[];
      final alldata=await dbHelper.queryAllRows();
      if(alldata.length>0){
        products=[];
        for(Map i in alldata){
          products!.add(ProductModel.fromJson(i));
          print(i);
        }
        return products;
      }
      else{
        final apiResult=await Services().fetchPicturesAPI();
        this.products=apiResult;
        print("yyesss"+products!.length.toString());
        if(products!.length>0){
          print("reach herer as well");
          for(int i=0;i<products!.length;i++){
            _insert(products![i]);
          }
        }
        return products;
      }



  }


  void _insert(ProductModel productModel) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.product_id :productModel.id ,
      DatabaseHelper.product_name  : productModel.Name,
      DatabaseHelper.product_price  : productModel.price,
      DatabaseHelper.product_shortdescription  : productModel.ShortDescription,
    };
    final id = await dbHelper.insert(row);


    print('inserted row id: $id');

  }

  AceesforlocationPermission()async{
    print("reach in this section");
    if(permissionGranted==PermissionStatus.granted){
      notifyListeners();
      fetchdata();
    }else{
      permissionGranted = await location.requestPermission();
    }
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        // return;
      }
    }

    permissionGranted = await location.hasPermission();
    try{
      if(permissionGranted==PermissionStatus.granted){
        notifyListeners();
        fetchdata();
      }

      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          permissionGranted = await location.requestPermission();
          // return;
        }

      }
    } catch(e){
      print(e);
    }


    _locationData = await location.getLocation();
  }



}