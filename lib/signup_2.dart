import 'package:flutter/material.dart';
import 'signup_3.dart'; // Ensure correct import with semicolon

class SignUpScreen2 extends StatelessWidget {
  final String gender; // Receive gender from previous screen

  const SignUpScreen2({Key? key, required this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              /// 🔹 Step Indicator for Step 2
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _stepIndicator("1"),
                    const SizedBox(width: 10),
                    Text(" - - - - ", style: TextStyle(color: Colors.grey.shade400)),
                    const SizedBox(width: 10),
                    _stepIndicator("2", isActive: true), // Highlighted step
                    const SizedBox(width: 10),
                    Text(" - - - - ", style: TextStyle(color: Colors.grey.shade400)),
                    const SizedBox(width: 10),
                    _stepIndicator("3"),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text("Credentials and Security", style: TextStyle(fontSize: 12)),
              const SizedBox(height: 10),
              const Text("Create An Account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text("Fill in the required details to continue"),
              const SizedBox(height: 20),

              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Confirm Password"),
                obscureText: true,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),

              const SizedBox(height: 20),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen3(gender: gender), // Pass gender
                      ),
                    );
                  },
                  child: const Text("Continue", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Goes back to SignUpScreen1
                  },
                  child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Step Indicator Widget
  Widget _stepIndicator(String number, {bool isActive = false}) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: isActive ? Colors.blue : Colors.grey.shade300,
      child: Text(
        number,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
