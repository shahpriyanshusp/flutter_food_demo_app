import 'package:flutter/material.dart';
import 'package:flutter_food_app_demo/View/SplashScreen/SplashScreen.dart';
import 'package:provider/provider.dart';

import 'ViewModel/HomeViewModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewViewModel()),
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        home: SplashScreen(),
      ),
    );
  }
}


/* MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Food App Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );*/
