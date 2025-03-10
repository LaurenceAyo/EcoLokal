import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'firstpage_handicraft.dart'; // Import the HandicraftsPage
import 'forgotpass_1.dart'; // Import the ForgotPass1Page
import 'signup_1.dart'; // Import the sign-up screen

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key}); // ✅ Fixed here

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _showErrorPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 360), // Moves image UP
            child: Center(
              child: Image.asset('assets/images/error_pop.png'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // ✅ Prevents overflow issues
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo and tagline
              SizedBox(height: 80),
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
              const Text('Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Divider(thickness: 1, indent: 80, endIndent: 80),
              const SizedBox(height: 10),

              // Username Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16), // Adds spacing from edges
                child: SizedBox(
                  width: double.infinity, // Ensures it doesn't overflow
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username/email',
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(12),
                        child: IconButton(
                          icon: Image.asset(
                            'assets/images/cancelCross.png',
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            usernameController.clear();
                          },
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Password Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16), // Adds spacing from edges
                child: SizedBox(
                  width: double.infinity, // Ensures it stays within screen width
                  child: TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(12),
                        child: IconButton(
                          icon: Image.asset(
                            _isPasswordVisible
                                ? 'assets/images/open_eye.png'
                                : 'assets/images/closed_eye.png',
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
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

              // Login Button
              ElevatedButton(
                onPressed: () {
                  _showErrorPopup(); // Simulate login failure
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
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

              // Sign-up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have an Account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()), // Navigate to SignupScreen
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

              const SizedBox(height: 10),

              // Social Login Buttons
            Column(
              children: [
                // Divider with text in between
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 1, endIndent: 5)),
                    Text('Or Login with'),
                    Expanded(child: Divider(thickness: 1, indent: 5)),
                  ],
                ),
                const SizedBox(height: 10),

                // Social login buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Login Button
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/google-logo.png', width: 40),
                            const SizedBox(width: 10),
                            Text("Google"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Facebook Login Button
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/facebook.png', width: 50),
                            const SizedBox(width: 10),
                            Text("Facebook"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ],
              ),
              const SizedBox(height: 10), // Add space at bottom
            ],
          ),
        ),
      ),
    );
  }
}
