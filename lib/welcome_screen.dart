import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo and tagline
            Text(
              'EcoLokal',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cursive',
                color: Colors.green,
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
            TextField(
              decoration: InputDecoration(
                hintText: 'Username/email',
                suffixIcon: Icon(Icons.close),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Password Field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: Icon(Icons.close),
                border: OutlineInputBorder(),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 10),
            // Login Button
            ElevatedButton(
              onPressed: () {},
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
                  onPressed: () {},
                  child: const Text('Sign-up',
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Or Login with'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset('assets/google.png'),
                  iconSize: 50,
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: Image.asset('assets/facebook.png'),
                  iconSize: 50,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}