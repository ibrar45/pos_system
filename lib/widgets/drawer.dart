import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String storeId;
  MyDrawer({required this.storeId});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 14, 212, 159),
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Sale'),
            onTap: () {
              Navigator.pushNamed(context, '/sale_screen',
                  arguments: {'storeId': storeId});
              // Implement item 1 functionality
            },
          ),
          ListTile(
            title: Text('Purchase'),
            onTap: () {
              Navigator.pushNamed(context, '/purchase',
                  arguments: {'storeId': storeId});
            },
          ),
          ListTile(
            title: Text('Add Store'),
            onTap: () {
              Navigator.pushNamed(context, '/store');
            },
          ),

          // Add more list tiles for additional items
        ],
      ),
    );
  }
}
