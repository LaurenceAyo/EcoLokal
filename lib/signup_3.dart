import 'package:flutter/material.dart';
import 'dart:developer'; // Import the log function

class SignUpScreen3 extends StatefulWidget {
  final String fullName;
  final String username;
  final String emailAddress;
  final String gender;
  final String birthDate;

  const SignUpScreen3({
    super.key,
    required this.fullName,
    required this.username,
    required this.emailAddress,
    required this.gender,
    required this.birthDate,
  });

  @override
  _SignUpScreen3State createState() => _SignUpScreen3State();
}

class _SignUpScreen3State extends State<SignUpScreen3> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedUserType; // Stores selected user type

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  bool _agreeToTerms = false;
  bool _termsError = false; // Tracks if user hasn't checked terms

  void _validateAndSubmit() {
    setState(() {
      _termsError = !_agreeToTerms; // Show error if checkbox is not checked
    });

    if (_formKey.currentState!.validate() && _selectedUserType != null && _agreeToTerms) {
      // Collect all data
      final String address = _addressController.text.trim();
      final String city = _cityController.text.trim();
      final String postalCode = _postalCodeController.text.trim();
      final String userType = _selectedUserType!;

      // Log the collected data
      log("Full Name: ${widget.fullName}");
      log("Username: ${widget.username}");
      log("Email Address: ${widget.emailAddress}");
      log("Gender: ${widget.gender}");
      log("Birth Date: ${widget.birthDate}");
      log("Address: $address");
      log("City: $city");
      log("Postal Code: $postalCode");
      log("User Type: $userType");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields and agree to terms")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up - Step 3"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              /// 🔹 Step Indicator for Step 3
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.withAlpha((0.4 * 255).toInt()), // Replaced withAlpha
                      child: const Text('1', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    const Text(" - - - - "),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Colors.blue.withAlpha((0.4 * 255).toInt()), // Replaced withAlpha
                      child: const Text('2', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    const Text(" - - - - "),
                    const SizedBox(width: 10),
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('3', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Center(child: Text("Preferences and Finalization", style: TextStyle(fontSize: 12))),
              const SizedBox(height: 10),
              const Text("Create An Account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text("Fill in the required details to continue"),
              const SizedBox(height: 20),

              // User Profile Avatar (Changes Based on Gender)
              Center(
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    widget.gender == "Male"
                        ? "assets/images/male-users.png"
                        : "assets/images/female-users.png",
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text("User Type", style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              // User Type Selection (Seller/Buyer)
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedUserType = "Seller"),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: _selectedUserType == "Seller" ? Colors.blue : Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: _selectedUserType == "Seller" ? Colors.blue.withAlpha((0.4 * 255).toInt()) : Colors.transparent,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/sellers-and-buyers-4.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 5),
                            const Text("Seller"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedUserType = "Buyer"),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: _selectedUserType == "Buyer" ? Colors.blue : Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: _selectedUserType == "Buyer" ? Colors.blue.withAlpha((0.4 * 255).toInt()) : Colors.transparent,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/sellers_and_buyers_5.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 5),
                            const Text("Buyer"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Address Input
              const Text("Address", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your address",
                ),
              ),

              const SizedBox(height: 10),

              // City Input
              const Text("City", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your city",
                ),
              ),

              const SizedBox(height: 10),

              // Postal Code Input
              const Text("Postal Code", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              TextField(
                controller: _postalCodeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your postal code",
                ),
              ),

              const SizedBox(height: 15),

              // Terms & Conditions Checkbox (Required)
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                        _termsError = false; // Reset error when checked
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "I agree to all terms & conditions",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              // Show error message if terms are not checked
              if (_termsError)
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "You must agree to continue",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 20),

              // Sign-up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: _validateAndSubmit,
                  child: const Text("Sign-up", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
