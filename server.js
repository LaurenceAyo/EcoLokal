const express = require("express");
const mysql = require("mysql2"); // Use mysql2 for better performance
const cors = require("cors");
const bcrypt = require("bcrypt");

const app = express();
app.use(express.json());
app.use(cors());

const db = mysql.createConnection({
  host: "localhost", // Change to your actual database host
  user: "root", // Replace with your MySQL username
  password: "", // Replace with your MySQL password
  database: "eco_lokal_app" // Your actual database name
});

// Connect to MySQL
db.connect(err => {
  if (err) {
    console.error("Database connection failed:", err.message);
    process.exit(1); // Stop the server if the database doesn't connect
  }
  console.log("MySQL Connected...");
});

// Login API
app.post("/login", async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: "Username and password are required" });
  }

  const query = "SELECT * FROM users WHERE username = ? OR email = ?";

  db.query(query, [username, username], async (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res.status(500).json({ error: "Server error" });
    }

    if (results.length === 0) {
      return res.status(404).json({ error: "User not found" });
    }

    const user = results[0];

    try {
      const isMatch = await bcrypt.compare(password, user.password_hash);
      if (!isMatch) {
        return res.status(401).json({ error: "Invalid credentials" });
      }

      res.json({ success: true, message: "Login successful", user });
    } catch (error) {
      console.error("Error comparing passwords:", error);
      res.status(500).json({ error: "Authentication error" });
    }
  });
});

app.listen(3000, () => console.log("Server running on port 3000"));