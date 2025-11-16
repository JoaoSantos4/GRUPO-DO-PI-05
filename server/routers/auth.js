const express = require('express');
const router = express.Router();
const db = require('../db');
router.get('/', (req, res) => {
  res.render('login', { erro: null, area: null });
});
router.post('/login', (req, res) => {
  const { usuario, senha } = req.body;
  db.query(
    'SELECT * FROM usuarios WHERE usuario = ? AND senha = ?',
    [usuario, senha],
    (err, results) => {
      if (err) throw err;

      if (results.length > 0) {
        req.session.usuario = results[0];
        return res.redirect('/dashboard');
      } else {
        return res.render('login', { erro: 'Usuário ou senha inválidos', area: 'cliente' });
      }
    }
  );
});
router.post('/login-corporativo', (req, res) => {
  const { usuario, senha } = req.body;
  db.query(
    'SELECT * FROM funcionarios WHERE usuario = ? AND senha = ?',
    [usuario, senha],
    (err, results) => {
      if (err) throw err;

      if (results.length > 0) {
        req.session.corporativo = results[0];
        return res.redirect('/admin');
      } else {
        return res.render('login', { erro: 'Usuário ou senha inválidos', area: 'corporativo' });
      }
    }
  );
});


router.get('/cadastro', (req, res) => {
  res.render('cadastro', { erro: null });
});

router.post('/cadastro', (req, res) => {
  const { usuario, senha } = req.body;

  // Verificar se já existe
  db.query('SELECT * FROM usuarios WHERE usuario = ?', [usuario], (err, results) => {
    if (err) throw err;

    if (results.length > 0) {
      return res.render('cadastro', { erro: 'Usuário já existe!' });
    }

    db.query(
      'INSERT INTO usuarios (usuario, senha, tipo_id) VALUES (?, ?, 2)',
      [usuario, senha],
      (err2) => {
        if (err2) throw err2;

        return res.redirect('/');
      }
    );
  });
});

module.exports = router;
    