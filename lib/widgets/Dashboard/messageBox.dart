import 'package:flutter/material.dart';

class _DelayedMessageDialog extends StatefulWidget {
  @override
  _DelayedMessageDialogState createState() => _DelayedMessageDialogState();
}

class _DelayedMessageDialogState extends State<_DelayedMessageDialog> {
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_dialogShown) {
        _showMessageDialog();
        _dialogShown = true;
      }
    });
  }

  Future<void> _showMessageDialog() async {
    await Future.delayed(Duration(milliseconds: 500)); // Delay for effect
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Welcome"),
          content: Text("Message"),
        );
      },
    );
    await Future.delayed(Duration(seconds: 2)); // Wait for 2 seconds
    Navigator.of(context).pop(); // Close the dialog after 2 seconds
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
