// backend/db.js
const mysql = require('mysql2');
const config = require('./config.json');

const pool = mysql.createPool({
  host: config.database.host,
  user: config.database.user,
  password: config.database.password,
  database: config.database.database,
  port: config.database.port,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Test the connection
pool.getConnection((err, connection) => {
  if (err) {
    console.error('Database connection error:', err);
    return;
  }
  console.log('Successfully connected to the database');
  connection.release();
});

const promisePool = pool.promise();

// Add query logging
const originalQuery = promisePool.query;
promisePool.query = async function (...args) {
  console.log('Executing query:', args[0]);
  try {
    const [rows, fields] = await originalQuery.apply(this, args);
    console.log('Query result:', rows);
    return [rows, fields];
  } catch (error) {
    console.error('Query error:', error);
    throw error;
  }
};

module.exports = promisePool;
