import 'package:flutter/material.dart';
import 'package:generate_image_app/screens/screens.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Image Generator',

      routes: {
        'image-generator': ( _ ) =>  ImageGeneratorPage()
      },
      initialRoute: 'image-generator',

      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.grey
        )
      ),
    );
  }
}

