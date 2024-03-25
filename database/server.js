const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();

app.use(cors());
app.use(bodyParser.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '12345',
  database: 'bd',
  port: '3306'
});

db.connect((err) => {
  if (err) throw err;
  console.log('Conectado a la base de datos');
});

app.get('/api/data', (req, res) => {
  let sql = 'SELECT * FROM tipo_operaciones';
  db.query(sql, (err, results) => {
    if(err) throw err;
    res.send(results);
  });
});

app.listen(3000, () => {
  console.log('Servidor corriendo en el puerto 3000');
});