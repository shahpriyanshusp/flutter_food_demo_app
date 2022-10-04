import 'package:flutter/material.dart';
import 'package:flutter_food_app_demo/Model/ProductModel.dart';


class DetailScreen extends StatefulWidget {
  ProductModel productModel;
   DetailScreen({Key? key,required this.productModel}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.productModel.Name.toString()),
        backgroundColor: Color(0xffd99e57),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
        child: Column(
          children: [
            Container(
              child: Image.asset("assets/images/foodgiftcard.jpg"),
            ),
            SizedBox(height: 15,),
            Text(widget.productModel.ShortDescription.toString() !=null && widget.productModel.ShortDescription.toString()!=""? widget.productModel.ShortDescription.toString():"No Data Found")
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Color(0xffd99e57),
        child: Center(child: Text("\$ "+widget.productModel.price.toString(),style: TextStyle(color: Colors.white),),),
      ),

    );
  }
}
