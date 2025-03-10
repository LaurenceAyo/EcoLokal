import 'package:flutter/material.dart';

class HandicraftsPage extends StatelessWidget {
  const HandicraftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset('assets/logo.png', height: 50),
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
                  backgroundImage: AssetImage('assets/user_avatar.png'),
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
            const Text('Handwoven Goods Choices', style: TextStyle(fontWeight: FontWeight.bold)),
            
            // Product Cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  _buildProductCard('500.00'),
                  _buildProductCard('1,500.00'),
                ],
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

  Widget _buildProductCard(String price) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}