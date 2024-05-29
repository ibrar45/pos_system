import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(height: 24.0),
                LoginForm(
                  onLogin: (String token) {
                    // Route to another screen or perform actions after successful login
                    print('Logged in with token: $token');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final Function(String) onLogin;

  LoginForm({required this.onLogin});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _storeidController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _storeidController.dispose(); // Dispose the controllers
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      String storeId = _storeidController.text;

      final String baseUrl = 'https://$storeId.alfpos.com/api';
      final String loginUrl = '$baseUrl/login';

      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        String token = responseBody['data']['token'];
        String name = responseBody['data']['name'];
        // print('--------------store:$storeId');

        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: {'storeId': storeId, 'token': token},
        );

        // Perform data fetching using token
        // await fetchData(token, context);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid Store Name, username, or password'),
            actions: [
              TextButton(
                onPressed: () {
                  _usernameController.clear();
                  _passwordController.clear();
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width *
                  0.3, // 50% of screen width
              width: MediaQuery.of(context).size.width * 0.3,
              child: Center(
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
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Text('Failed to load image');
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width *
                  0.1, // 50% of screen width
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Store ID",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  width: 0.3,
                ),
              ),
              child: TextFormField(
                controller: _storeidController,
                decoration: const InputDecoration(
                  hintText: 'Store Name',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  border: InputBorder.none,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Store Name';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "User Name",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  width: 0.3,
                ),
              ),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  border: InputBorder.none,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Password",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  width: 0.3,
                ),
              ),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: _isObscure,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 32.0),
            Container(
              width: 50,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text(
                  "login",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class UserData {
//   // final String token;
//   final String name;
//   // final String email;
//   // final String message;

//   UserData({
//     // required this.token,
//     required this.name,
//     // required this.email,
//     // required this.message,
//   });
// }

class UserData2 {
  final String revenue;
  final String returnn;
  final String profit;
  final String purchase;
  // final String name;
  // final String email;
  // final String message;

  UserData2(
      {required this.revenue,
      required this.returnn,
      required this.profit,
      required this.purchase
      // required this.name,
      // required this.email,
      // required this.message,
      });
}
