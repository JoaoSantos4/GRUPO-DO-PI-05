const express = require('express');
const router = express.Router();
const db = require('../db');

router.get('/', (req, res) => {
  db.query('SELECT * FROM Produtos', (error, resultados) => {
    if (error) {
      console.error('Erro ao carregar produtos:', error);
      return res.status(500).send('Erro ao carregar produtos');
    }

     console.log(resultados)

    res.render('dashboard', {
      usuario: req.session.usuario,
      produtos: resultados
    });
  });
});

// Outras rotas
router.get('/atendimento', (req, res) => {
  res.send('Página de atendimento');
});

router.get('/minhaconta', (req, res) => {
  res.send('Página Minha Conta');
});

router.get('/sobrenos', (req, res) => {
  res.send('Página Sobre Nós');
});

router.get('/sair', (req, res) => {
  req.session.destroy();
  res.redirect('/');
});

router.get('/carrinho', (req, res) => {
  res.send('Página do Carrinho');
});

module.exports = router;
