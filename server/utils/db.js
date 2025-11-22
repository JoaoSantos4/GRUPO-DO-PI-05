const mysql = require('mysql2');

const conexao = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: 'DeD@8689',
  database: 'gestao'
});

conexao.connect((err) => {
  if (err) {
    console.error('Erro ao conectar ao MySQL:', err);
    return;
  }
  console.log('Conectado ao MySQL!');
});

module.exports = conexao;
