const express = require("express");
const mysql = require("mysql2"); // Use mysql2 for better performance
const cors = require("cors");
const bcrypt = require("bcrypt");

const app = express();
app.use(express.json());
app.use(cors());

const db = mysql.createConnection({
  host: "127.0.0.1", // Use loopback IP
  user: "root", // Replace with your MySQL username
  password: "", // Replace with your MySQL password
  database: "eco_lokal_app", // Your actual database name
});

// Connect to MySQL
db.connect(err => {
  if (err) {
    console.error("❌ Database connection failed:", err.message);
    process.exit(1); // Stop the server if the database doesn't connect
  }
  console.log("✅ MySQL Connected...");
});

// Login API
app.post("/login", async (req, res) => {
  const { username, password } = req.body;
  console.log(`🔍 Login attempt for: ${username}`);

  if (!username || !password) {
    return res.status(400).json({ success: false, message: "Username and password are required" });
  }

  const query = "SELECT id, username, email, password_hash FROM users WHERE username = ? OR email = ? LIMIT 1";

  db.query(query, [username, username], async (err, results) => {
    if (err) {
      console.error("❌ Database query error:", err);
      return res.status(500).json({ success: false, message: "Server error" });
    }

    if (results.length === 0) {
      console.warn(`⚠️ User not found: ${username}`);
      return res.status(404).json({ success: false, message: "User not found" });
    }

    const user = results[0];
    console.log("✅ User found:", user.username);

    try {
      const isMatch = await bcrypt.compare(password, user.password_hash);
      console.log(`🔍 Password match: ${isMatch}`);

      if (!isMatch) {
        console.warn("⚠️ Invalid password attempt");
        return res.status(401).json({ success: false, message: "Invalid credentials" });
      }

      res.json({
        success: true,
        message: "Login successful",
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
        }
      });
    } catch (error) {
      console.error("❌ Error comparing passwords:", error);
      res.status(500).json({ success: false, message: "Authentication error" });
    }
  });
});

// Start server
const PORT = 3000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
app.post("/login", async (req, res) => {
  const { username, password } = req.body;
  console.log("Login attempt:", username, password); // Debug log

  const query = "SELECT * FROM users WHERE username = ? OR email = ? LIMIT 1";
  db.query(query, [username, username], async (err, results) => {
    if (err) {
      console.error("Database query error:", err);
      return res.status(500).json({ success: false, message: "Server error" });
    }

    console.log("Query results:", results); // Debug log

    if (results.length === 0) {
      return res.status(404).json({ success: false, message: "User not found" });
    }

    const user = results[0];

    try {
      const isMatch = await bcrypt.compare(password, user.password_hash);
      console.log("Password match:", isMatch); // Debug log
      if (!isMatch) {
        return res.status(401).json({ success: false, message: "Invalid credentials" });
      }

      res.json({
        success: true,
        message: "Login successful",
        user: { id: user.id, username: user.username, email: user.email }
      });
    } catch (error) {
      console.error("Error comparing passwords:", error);
      res.status(500).json({ success: false, message: "Authentication error" });
    }
  });
});
