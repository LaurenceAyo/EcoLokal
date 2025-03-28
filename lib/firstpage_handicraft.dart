import 'package:flutter/material.dart';
import 'db_helper.dart'; // Import the database helper

class HandicraftsPage extends StatefulWidget {
  const HandicraftsPage({super.key});

  @override
  _HandicraftsPageState createState() => _HandicraftsPageState();
}

class _HandicraftsPageState extends State<HandicraftsPage> {
  late Future<List<Map<String, dynamic>>> _products;

  // Default avatar image
  String _userAvatar = 'assets/images/user-male.png';

  @override
  void initState() {
    super.initState();
    _products = DatabaseHelper.fetchProducts(); // Fetch products from the database

    // Simulate fetching the user's avatar choice (e.g., from a database or shared preferences)
    _fetchUserAvatar();
  }

  // Simulate fetching the user's avatar choice
  void _fetchUserAvatar() async {
    // Replace this with actual logic to fetch the user's avatar (e.g., from a database or API)
    String? userAvatarChoice = await _getUserAvatarFromDatabase();

    setState(() {
      _userAvatar = userAvatarChoice ?? 'assets/images/user-male.png'; // Default to user-male.png
    });
  }

  // Simulated method to fetch the user's avatar from a database
  Future<String?> _getUserAvatarFromDatabase() async {
    // Simulate a delay for fetching data
    await Future.delayed(const Duration(seconds: 1));

    // Example: Return a different avatar based on user choice
    // Return null to use the default avatar
    return 'assets/images/user-female.png'; // Replace with actual logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 5,
        title: Image.asset('assets/images/mainLogo.png', height: 80),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(_userAvatar), // Dynamically set the avatar
                  radius: 24,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hello There', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const Text('Irene', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Handicrafts',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.filter_list),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // Popular Places
            const Text('Popular Places', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Chip(label: Text('Legazpi')),
                Chip(label: Text('Ligao')),
                Chip(label: Text('Tabaco')),
              ],
            ),
            const SizedBox(height: 16),

            // Handwoven Goods Choices
            const Text('Handwoven Goods Choices', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Dynamic Product Grid
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _products,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error fetching products'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No products available'));
                  }

                  var products = snapshot.data!;
                  return GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var product = products[index];
                      return GestureDetector(
                        onTap: () => _showProductDetails(context, product),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/images/${product['image']}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Text(product['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text('₱${product['price']}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 36), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.local_cafe), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  void _showProductDetails(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/${product['image']}'),
            SizedBox(height: 10),
            Text(product['description']),
            SizedBox(height: 10),
            Text('₱${product['price']}', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
        ],
      ),
    );
  }
}