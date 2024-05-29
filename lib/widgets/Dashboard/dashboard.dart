// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
// import 'package:pos_system/serviceApi.dart';
// import 'package:pos_system/widgets/Dashboard/appBar.dart';
// import 'package:pos_system/widgets/Graph/bar_graph.dart';
// import 'package:http/http.dart' as http;
// import 'package:pos_system/widgets/drawer.dart';

// class Dashboard extends StatefulWidget {
//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   late ApiService apiService;
//   late Future<Map<String, dynamic>> futureData;
//   late DateTime _selectedDate;
//   late List<dynamic> items = [];
//   int _selectedIndex = 2;
//   DateTime _startDate = DateTime.now();
//   DateTime _endDate = DateTime.now();
//   void _updateDates(int days) {
//     setState(() {
//       _endDate = DateTime.now();
//       _startDate = _endDate.subtract(Duration(days: days));
//       // fetchData("your_token_here", context);
//     });
//   }

//   late String _responseData = '';

//   @override
//   void initState() {
//     DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
//     DateTime _endDate = DateTime.now();
//     int _selectedIndex = 2;
//     futureData =
//         apiService.dashboard_api('your_token_here', _startDate, _endDate);
//   }

//   double textSize(BuildContext context) {
//     if (MediaQuery.of(context).orientation == Orientation.portrait) {
//       return MediaQuery.of(context).size.width * 0.05;
//     } else {
//       return MediaQuery.of(context).size.height * 0.05;
//     }
//   }

//   double alignBox(BuildContext context) {
//     if (MediaQuery.of(context).orientation == Orientation.portrait) {
//       return MediaQuery.of(context).size.width * 0.05;
//     } else {
//       return MediaQuery.of(context).size.height * 0.05;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).orientation == Orientation.portrait
//         ? MediaQuery.of(context).size.height * 0.2
//         : MediaQuery.of(context).size.width * 0.2;

//     var width = MediaQuery.of(context).orientation == Orientation.portrait
//         ? MediaQuery.of(context).size.width * 0.4
//         : MediaQuery.of(context).size.height * 0.97;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 229, 227, 227),
//       appBar: MyAppBar(),
//       drawer: MyDrawer(),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: futureData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             var data = snapshot.data!;
//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     // Display revenue
//                     SizedBox(
//                       height: 20,
//                     ),
//                     FlutterToggleTab(
//                       width: MediaQuery.of(context).size.width * 0.20,
//                       borderRadius: 30,
//                       height: 40,
//                       selectedIndex: _selectedIndex,
//                       selectedTextStyle: TextStyle(color: Colors.white),
//                       unSelectedTextStyle: TextStyle(color: Colors.black),
//                       labels: ["Today", "7 Days", "30 Days"],
//                       selectedLabelIndex: (index) {
//                         setState(() {
//                           _selectedIndex = index;
//                           if (index == 0) {
//                             _updateDates(0);
//                           } else if (index == 1) {
//                             _updateDates(7);
//                           } else {
//                             _updateDates(30);
//                           }
//                         });
//                       },
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                 color: Colors.black, // Border color
//                                 width: 0.4,
//                                 // Border width
//                               ),
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10)),
//                             ),
//                             height: height,
//                             width: width,
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Icon(
//                                     Icons.signal_cellular_alt_outlined,
//                                     size: 40, // Adjust size as needed
//                                     color:
//                                         Colors.purple, // Adjust color as needed
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.009,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.width *
//                                               0.1,
//                                     ),
//                                     Text(
//                                       ' ${data['revenue']}',
//                                       style: TextStyle(
//                                         fontSize: textSize(context),
//                                         color: Colors.black87,
//                                         fontWeight: FontWeight.w100,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       "Revenue",
//                                       style: TextStyle(
//                                         fontSize: textSize(context),
//                                         color: Colors.purple,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                 color: Colors.black, // Border color
//                                 width: 0.4,
//                                 // Border width
//                               ),
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10)),
//                             ),
//                             height: height,
//                             width: width,
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Icon(
//                                     Icons.undo,
//                                     size: 40, // Adjust size as needed
//                                     color:
//                                         Colors.orange, // Adjust color as needed
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.009,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.width *
//                                               0.1,
//                                     ),
//                                     Text(
//                                       ' ${data['return']}',
//                                       style: TextStyle(
//                                         fontSize: textSize(context),
//                                         color: Colors.black87,
//                                         fontWeight: FontWeight.w100,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       "Return",
//                                       style: TextStyle(
//                                         fontSize: textSize(context),
//                                         color: Colors.orange,
//                                         // fontWeight: FontWeight.w100,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                 color: Colors.black, // Border color
//                                 width: 0.4,
//                                 // Border width
//                               ),
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10)),
//                             ),
//                             height: height,
//                             width: width,
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Icon(
//                                     Icons.emoji_events_outlined,
//                                     size: 40, // Adjust size as needed
//                                     color:
//                                         Colors.blue, // Adjust color as needed
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.009,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.width *
//                                               0.1,
//                                     ),
//                                     Text(
//                                       '${data['profit']}',
//                                       style: TextStyle(
//                                         fontSize: textSize(context),

//                                         // color: Colors.black87,
//                                         fontWeight: FontWeight.w100,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       "Profit",
//                                       style: TextStyle(
//                                         fontSize: textSize(context),
//                                         color: Colors.blue,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                 color: Colors.black, // Border color
//                                 width: 0.4,
//                                 // Border width
//                               ),
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10)),
//                             ),
//                             height: height,
//                             width: width,
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Icon(
//                                     Icons.arrow_circle_right_outlined,
//                                     size: 40, // Adjust size as needed
//                                     color:
//                                         Colors.green, // Adjust color as needed
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.008,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.width *
//                                               0.1,
//                                     ),
//                                     Text(
//                                       ' ${data['purchase_return']}',
//                                       style: TextStyle(
//                                         fontSize: textSize(context),
//                                         color: Colors.black87,
//                                         fontWeight: FontWeight.w100,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       "Purchase",
//                                       style: TextStyle(
//                                         fontSize: textSize(context),
//                                         color: Colors.green,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     // SizedBox(
//                     //   height: MediaQuery.of(context).size.height * 0.4,
//                     //   width: MediaQuery.of(context).size.width * 0.8,
//                     //   child: MyBarGraph(
//                     //     revnue: widget.revnue,
//                     //   ),
//                     // ),
//                     // Other dashboard components can be added here
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
