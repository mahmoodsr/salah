import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'loading_screen.dart';
import 'package:provider/provider.dart';
import 'DataPrayer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DataPrayer(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoadingScreen(),
        ));
  }
}
