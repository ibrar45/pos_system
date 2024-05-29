import 'package:flutter/material.dart';
import 'package:pos_system/widgets/Dashboard/dashboard.dart';
import 'package:pos_system/widgets/Dashboard/dashboardData.dart';
import 'package:pos_system/widgets/loginScreen.dart';

import 'package:pos_system/widgets/Graph/bar_graph.dart';

class HomeScreen extends StatefulWidget {
  // final String token;
  // final String name;
  // final String email;
  // final String message;

  // const HomeScreen({
  //   Key? key,
  // }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<double> weeklySummary = [1.1, 3.2, 5.5, 7.6, 3.8];

  @override
  Widget build(BuildContext context) {
    return DashboardScreen();
  }
}
