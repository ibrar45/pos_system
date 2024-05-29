import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late List<dynamic> items = [];
  late DateTime _selectedDate;
  int _selectedIndex = 2;
  DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _endDate = DateTime.now();
  late String storeID;

  Timer? _debounceTimer;

  void _updateDates(int days) {
    DateTime newStartDate = DateTime.now().subtract(Duration(days: days));
    DateTime newEndDate = DateTime.now();

    // Check if the start and end dates have changed
    if (_startDate != newStartDate || _endDate != newEndDate) {
      setState(() {
        _startDate = newStartDate;
        _endDate = newEndDate;
      });
    }

    // Cancel the existing debounce timer
    _debounceTimer?.cancel();

    // Set up a new debounce timer
    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      fetchData();
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      storeID = args['storeId'];
      print("-------------object$storeID");
      fetchData();
    } else {
      // Handle the case when args are null, if necessary
      print('No arguments received');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Initial fetch
  }

  @override
  void dispose() {
    _debounceTimer
        ?.cancel(); // Cancel the debounce timer when the widget is disposed
    super.dispose();
  }

  Future<void> fetchData() async {
    String apiUrl =
        'https://$storeID.alfpos.com/api/purchase?start_date=$_startDate&end_date=$_endDate&limit=5';

    // Create headers with authorization token
    Map<String, String> headers = {
      'Accept': 'application/json', // Assuming JSON content
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          var data = jsonDecode(response.body);
          items = data['data']['purchase'];
        });
        print("---------------------------my-${response.body}");
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Screen"),
      ),
      body: Column(
        children: [
          FlutterToggleTab(
            width: MediaQuery.of(context).size.width * 0.25,
            borderRadius: 30,
            height: 40,
            selectedIndex: _selectedIndex,
            selectedTextStyle: TextStyle(color: Colors.white),
            unSelectedTextStyle: TextStyle(color: Colors.black),
            labels: ["Today", "7 Days", "30 Days"],
            selectedLabelIndex: (index) {
              setState(() {
                _selectedIndex = index;
                if (index == 0) {
                  _updateDates(0);
                } else if (index == 1) {
                  _updateDates(7);
                } else {
                  _updateDates(30);
                }
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: MyGrid(purchase: items),
          ),
        ],
      ),
    );
  }
}

class MyGrid extends StatelessWidget {
  final List<dynamic> purchase;

  MyGrid({required this.purchase});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Name',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ),
          DataColumn(
            label: Text(
              'Sales',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ),
          DataColumn(
            label: Text(
              'Reference No',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ),
        ],
        rows: purchase.map((dynamic item) {
          return DataRow(
            cells: <DataCell>[
              DataCell(
                Text(
                  item['name'] ?? 'Unknown',
                ),
              ),
              DataCell(
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: '\$ ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 55, 198, 132),
                        ),
                      ),
                      TextSpan(
                        text: item['grand_total'] != null
                            ? item['grand_total'].toString()
                            : 'Unknown',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              DataCell(
                Text(
                  item['reference_no'] ?? 'Unknown',
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
