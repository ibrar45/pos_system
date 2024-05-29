import 'package:flutter/material.dart';
import 'package:pos_system/widgets/Dashboard/dashboard.dart';
import 'package:pos_system/widgets/Dashboard/dashboardData.dart';
import 'package:pos_system/widgets/HomeScreen.dart';
import 'package:pos_system/widgets/Stores/stores.dart';
import 'package:pos_system/widgets/loginScreen.dart';
import 'package:pos_system/widgets/purchase/purchase.dart';
import 'package:pos_system/widgets/sale/sale_screen.dart';
import 'package:pos_system/widgets/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if ModalRoute is available

    // Extract the values from the arguments map

    return MaterialApp(
      title: 'Pos System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'OpenSans',
        primaryColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
          splashScreen(), // Note: Widget class names should start with uppercase
      routes: {
        '/home': (context) => HomeScreen(),
        '/sale_screen': (context) => SaleScreen(),
        '/purchase': (context) => MyWidget(),
        '/store': ((context) => Store())
      },
    );
  }
}
