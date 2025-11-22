const express = require('express');
const router = express.Router();
const db = require('../utils/db');

// Importar funções de hash
const { gerarHash, validarSenha } = require('../utils/hash');

// Tela login
router.get('/', (req, res) => {
  res.render('login', { erro: null, area: null });
});


// 🔐 LOGIN DO CLIENTE
router.post('/login', (req, res) => {
  const { usuario, senha } = req.body;

  db.query(
    'SELECT * FROM usuarios WHERE usuario = ?',
    [usuario],
    (err, results) => {
      if (err) throw err;

      if (results.length === 0) {
        return res.render('login', { erro: 'Usuário ou senha inválidos', area: 'cliente' });
      }

      const user = results[0];

      // Verificar senha
      const senhaCorreta = validarSenha(senha, user.senha, user.salt);

      if (!senhaCorreta) {
        return res.render('login', { erro: 'Usuário ou senha inválidos', area: 'cliente' });
      }

      // Login OK
      req.session.usuario = user;
      return res.redirect('/dashboard');
    }
  );
});


// 🔐 LOGIN CORPORATIVO
router.post('/login-corporativo', (req, res) => {
  const { usuario, senha } = req.body;

  db.query(
    'SELECT * FROM funcionarios WHERE usuario = ?',
    [usuario],
    (err, results) => {
      if (err) throw err;

      if (results.length === 0) {
        return res.render('login', { erro: 'Usuário ou senha inválidos', area: 'corporativo' });
      }

      const user = results[0];

      const senhaCorreta = validarSenha(senha, user.senha, user.salt);

      if (!senhaCorreta) {
        return res.render('login', { erro: 'Usuário ou senha inválidos', area: 'corporativo' });
      }

      req.session.corporativo = user;
      return res.redirect('/admin');
    }
  );
});


// Página cadastro
router.get('/cadastro', (req, res) => {
  res.render('cadastro', { erro: null });
});


// 🔐 CADASTRO DO USUÁRIO COM HASH
router.post('/cadastro', (req, res) => {
  const { usuario, senha } = req.body;

  // Verificar se já existe
  db.query('SELECT * FROM usuarios WHERE usuario = ?', [usuario], (err, results) => {
    if (err) throw err;

    if (results.length > 0) {
      return res.render('cadastro', { erro: 'Usuário já existe!' });
    }

    // Gerar hash e salt
    const { hash, salt } = gerarHash(senha);

    // Inserir com hash + salt
    db.query(
      'INSERT INTO usuarios (usuario, senha, salt, tipo_id) VALUES (?, ?, ?, 2)',
      [usuario, hash, salt],
      (err2) => {
        if (err2) throw err2;

        return res.redirect('/');
      }
    );
  });
});

module.exports = router;
