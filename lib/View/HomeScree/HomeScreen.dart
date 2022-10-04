import 'package:flutter/material.dart';
import 'package:flutter_food_app_demo/View/DetailScreen/DetailScreen.dart';
import 'package:flutter_food_app_demo/ViewModel/HomeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState(){
    var provider= Provider.of<HomeViewViewModel>(context,listen: false);
    provider.AceesforlocationPermission();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<HomeViewViewModel>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd99e57),
        title: Text("DashBooardScreen"),
      ),
      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.9),
                      itemCount: provider.products!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset("assets/images/foodgiftcard.jpg",fit: BoxFit.fill)),
                              SizedBox(height: 10,),
                              Center(child: Text( provider.products![index].Name.toString(),style: TextStyle(fontWeight: FontWeight.w600),maxLines: 1,),),
                              Center(child: Text( provider.products![index].price.toString(),style: TextStyle(fontWeight: FontWeight.w400),),),
                              SizedBox(height: 5,),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailScreen(productModel: provider.products![index],)));
                                    },
                                    child: Container(
                                      color:Color(0xffd99e57),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(child: Text("Details",style: TextStyle(color: Colors.white),)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );

                  } else {
                    return Center(child: CircularProgressIndicator());
                  }

                },
                future: provider.fetchdata(),
              ),
            ),
          ],
        ),
      )


    );
  }
}
