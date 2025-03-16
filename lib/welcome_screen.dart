import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'firstpage_handicraft.dart'; // Ensure this file exists and contains HandicraftsPage class
import 'forgotpass_1.dart'; // Ensure this file exists and contains ForgotPass1Page class
import 'signup_1.dart'; // Ensure this file exists and contains SignUpScreen class
import 'package:mysql_client/mysql_client.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class DatabaseService {
  static Future<MySQLConnection> connectToDatabase() async {
    final conn = await MySQLConnection.createConnection(
      host: "10.0.2.2", // Your MySQL host
      port: 3306, // MySQL default port 
      userName: "admin",
      password: "password123", // Your MySQL password
      databaseName: "eco_lokal_app",
      secure: false, // Disable SSL
    );

    await conn.connect();
    print("Connected to MySQL successfully!");
    return conn;
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorPopup("Fields cannot be empty");
      return;
    }

    try {
      // Hash the input password (assuming the database stores hashed passwords)
      var hashedPassword = sha256.convert(utf8.encode(password)).toString();

      // Connect to the database
      final conn = await DatabaseService.connectToDatabase();

      // Query the database for the user
      var result = await conn.execute(
        "SELECT * FROM users WHERE (username = :username OR email = :username) AND password_hash = :password LIMIT 1",
        {
          "username": username,
          "password": hashedPassword, // Use the hashed password
        },
      );

      if (result.rows.isNotEmpty) {
        // If a matching record is found, navigate to the HandicraftsPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HandicraftsPage()),
        );
      } else {
        // If no matching record is found, show an error popup
        _showErrorPopup("Invalid username or password");
      }

      await conn.close();
    } catch (e) {
      _showErrorPopup("Error connecting to the database: $e");
    }
  }

  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Failed"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Eco',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cursive',
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(
                      text: 'Lokal',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cursive',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '"Shop Sustainable,\n Support Lokal"',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 30),
              const Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Divider(thickness: 1, indent: 80, endIndent: 80),
              const SizedBox(height: 10),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username/email',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => usernameController.clear(),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPass1Page(),
                      ),
                    );
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Login', style: TextStyle(color: Colors.white)),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_right_alt, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have an Account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: const Text(
                      'Sign-up',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(child: Divider(thickness: 1, endIndent: 5)),
                  Text('Or Login with'),
                  Expanded(child: Divider(thickness: 1, indent: 5)),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/google-logo.png', width: 20),
                          SizedBox(width: 10),
                          Text("Google"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/facebook.png', width: 20),
                          SizedBox(width: 10),
                          Text("Facebook"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
