import 'package:flutter/material.dart';
import 'package:pos_system/widgets/HomeScreen.dart';
import 'package:pos_system/widgets/loginScreen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate some initialization tasks
    _mockInitialization().then((value) {
      // Navigate to the home screen after initialization tasks are done
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  Future _mockInitialization() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          'https://baraj.alfpos.com/logo/20240123043814.png',
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              );
            }
          },
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Text('Failed to load image');
          },
        ),
      ),
    );
  }
}
