import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,_,__) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: "Hellix"),
          // initialRoute: ,
          routes: {
            
          },
        );
      }
    );
  }
}