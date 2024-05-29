import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:http/http.dart' as http;
import 'package:pos_system/serviceApi.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);

  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  late List<dynamic> items = [];
  late DateTime _selectedDate;
  int _selectedIndex = 2;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  late String storeID;
  late ApiService apiService;
  bool _isInit = true;
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   if (_isInit) {
  //     final args =
  //         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  //     if (args != null) {
  //       storeID = args['storeId'];
  //       String token = args['token'];

  //       // Print the storeID here
  //       print('Store ID: $storeID');

  //       // Initialize ApiService
  //       apiService = ApiService();

  //       // Fetch initial data
  //       futureData = apiService.dashboard_api(storeID, _startDate, _endDate);
  //       // futureData = apiService.login(storeID);
  //     } else {
  //       // Handle the case when args are null, if necessary
  //       print('No arguments received');
  //     }
  //     _isInit = false;
  //   }
  // }
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   if (_isInit) {
  //     final args =
  //         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  //     if (args != null) {
  //       storeID = args['storeId'];
  //       String token = args['token'];

  //       // Print the storeID here
  //       print('-----------------------------Store ID12: $storeID');

  //       // Initialize ApiService
  //       apiService = ApiService();

  //       // Fetch initial data
  //       // futureData = apiService.dashboard_api(storeID, _startDate, _endDate);
  //       // futureData = apiService.login(storeID);
  //     } else {
  //       // Handle the case when args are null, if necessary
  //       print('No arguments received');
  //     }
  //     _isInit = false;
  //   }
  // }
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

  void _updateDates(int days) {
    setState(() {
      _endDate = DateTime.now();
      _startDate = _endDate.subtract(Duration(days: days));

      fetchData();
    });
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    String apiUrl =
        'https://$storeID.alfpos.com/api/sale?start_date=$_startDate&end_date=$_endDate&limit=5';

    // Create headers with authorization token
    Map<String, String> headers = {
      'Accept': 'application/json', // Assuming JSON content
    };

    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        var data = jsonDecode(response.body);
        items = data['data']['sale'];
      });
      print("---------------------------my-${response.body}");
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    storeID = args['storeId'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Sale Screen $storeID"),
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
                  _updateDates(360);
                }
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          MyGrid(sale: items),
        ],
      ),
    );
  }
}

class MyGrid extends StatelessWidget {
  final List<dynamic> sale;

  MyGrid({required this.sale});

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
        rows: sale.map((dynamic item) {
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
