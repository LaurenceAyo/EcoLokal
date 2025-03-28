import 'package:flutter/material.dart';
import 'signup_2.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState(); // Updated to use the public class
}

class SignUpScreenState extends State<SignUpScreen> { // Removed the leading underscore
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  String? _selectedDay;
  String? _selectedMonth;
  String? _selectedYear;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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

              /// 🔹 Updated Step Indicator
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _stepIndicator("1", isActive: true), // Highlighted
                    const SizedBox(width: 10),
                    Text(" - - - - ", style: TextStyle(color: Colors.grey.shade400)),
                    const SizedBox(width: 10),
                    _stepIndicator("2"),
                    const SizedBox(width: 10),
                    Text(" - - - - ", style: TextStyle(color: Colors.grey.shade400)),
                    const SizedBox(width: 10),
                    _stepIndicator("3"),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text("BASIC INFORMATION", style: TextStyle(fontSize: 12)),
              const SizedBox(height: 10),
              const Text("Create An Account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text("Fill in the required details to continue"),
              const SizedBox(height: 20),
              Form(
                key: _formKey, // Attach the form key
                child: Column(
                  children: [
                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(labelText: "Full Name"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Full Name is required";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: "Username"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: "Email Address"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email Address is required";
                        }
                        // Regular expression for validating email format
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("GENDER", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _genderOption("Male", "assets/images/male-users.png"),
                        const SizedBox(width: 15),
                        _genderOption("Female", "assets/images/female-users.png"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Birth Date", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(labelText: "Day"),
                            items: List.generate(31, (index) => (index + 1).toString())
                                .map((day) => DropdownMenuItem(value: day, child: Text(day)))
                                .toList(),
                            onChanged: (value) => setState(() => _selectedDay = value),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(labelText: "Month"),
                            items: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
                                .map((month) => DropdownMenuItem(value: month, child: Text(month)))
                                .toList(),
                            onChanged: (value) => setState(() => _selectedMonth = value),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(labelText: "Year"),
                            items: List.generate(100, (index) => (2025 - index).toString())
                                .map((year) => DropdownMenuItem(value: year, child: Text(year)))
                                .toList(),
                            onChanged: (value) => setState(() => _selectedYear = value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedGender != null) {
                              final String birthDate = "${_selectedDay ?? ''} ${_selectedMonth ?? ''} ${_selectedYear ?? ''}";
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen2(
                                    fullName: _fullNameController.text.trim(),
                                    username: _usernameController.text.trim(),
                                    emailAddress: _emailController.text.trim(),
                                    gender: _selectedGender!,
                                    birthDate: birthDate,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Please select a gender")),
                              );
                            }
                          }
                        },
                        child: const Text("Continue", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0); // Start from the right
                              const end = Offset.zero; // End at the current position
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Step Indicator Widget (Highlights Active Step)
  Widget _stepIndicator(String number, {bool isActive = false}) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: isActive ? Colors.blue : Colors.grey.shade300,
      child: Text(
        number,
        style: TextStyle(color: isActive ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// 🔹 Gender Option Widget
  Widget _genderOption(String gender, String imagePath) {
    bool isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedGender = gender);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade300 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: Colors.grey.shade500) : null,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Image.asset(imagePath, width: 30, height: 30),
            ),
            const SizedBox(width: 10),
            Text(gender, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
