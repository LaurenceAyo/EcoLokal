import 'package:sqflite/sqflite.dart'; // Correct import for sqflite
import 'package:path/path.dart'; // For handling database paths

class DatabaseHelper {
  // Initialize and open the database
  static Future<Database> _getDatabase() async {
    final dbPath = await getDatabasesPath(); // Corrected from `await C`
    return openDatabase(
      join(dbPath, 'eco_lokal.db'), // Combine the database path and name
      onCreate: (db, version) async {
        // Create the `products` table
        await db.execute(
          '''
          CREATE TABLE products (
            product_id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            price REAL NOT NULL,
            stock_quantity INTEGER NOT NULL,
            category_id INTEGER NOT NULL,
            sku TEXT NOT NULL,
            weight REAL NOT NULL,
            dimensions TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
          '''
        );

        // Create the `product_images` table
        await db.execute(
          '''
          CREATE TABLE product_images (
            image_id INTEGER PRIMARY KEY,
            product_id INTEGER NOT NULL,
            image_url TEXT NOT NULL,
            is_primary INTEGER NOT NULL,
            FOREIGN KEY (product_id) REFERENCES products (product_id)
          )
          '''
        );
      },
      version: 1,
    );
  }

  // Fetch all products from the database
  static Future<List<Map<String, dynamic>>> fetchProducts() async {
    final db = await _getDatabase();
    return db.query('products'); // Query all rows from the `products` table
  }

  // Insert a product into the database
  static Future<void> insertProduct(Map<String, dynamic> product) async {
    final db = await _getDatabase();
    await db.insert('products', product, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Insert an image into the database
  static Future<void> insertProductImage(Map<String, dynamic> image) async {
    final db = await _getDatabase();
    await db.insert('product_images', image, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Fetch images for a specific product
  static Future<List<Map<String, dynamic>>> fetchImagesForProduct(int productId) async {
    final db = await _getDatabase();
    return db.query(
      'product_images',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
  }

  // Delete all products (for testing purposes)
  static Future<void> deleteAllProducts() async {
    final db = await _getDatabase();
    await db.delete('products');
  }

  // Delete all product images (for testing purposes)
  static Future<void> deleteAllProductImages() async {
    final db = await _getDatabase();
    await db.delete('product_images');
  }
}
