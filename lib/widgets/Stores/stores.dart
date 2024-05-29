import 'package:flutter/material.dart';
import 'package:pos_system/widgets/Stores/addStore.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  List<String> stores = [];

  void _addNewStore(String newStore) {
    setState(() {
      stores.add(newStore);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stores'),
      ),
      body: ListView.builder(
        itemCount: stores.length + 1,
        itemBuilder: (context, index) {
          if (index == stores.length) {
            return ListTile(
              title: Text(
                'Add Store',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddStoreScreen()),
                );
                if (result != null) {
                  _addNewStore(result);
                }
              },
            );
          }
          return ListTile(
            title: Text(stores[index]),
          );
        },
      ),
    );
  }
}
