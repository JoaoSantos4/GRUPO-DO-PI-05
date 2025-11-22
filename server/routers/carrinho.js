const express = require('express');
const router = express.Router();
const db = require('../utils/db');

// Página do carrinho
router.get('/', (req, res) => {
  if (!req.session.usuario) return res.redirect('/');

  const carrinho = req.session.carrinho || [];

  const total = carrinho.reduce((acc, item) => acc + item.preco_real * item.quantidade, 0);

  res.render('carrinho', {
    usuario: req.session.usuario,
    carrinho,
    total
  });
});

// Adicionar ao carrinho
router.post('/add/:id', (req, res) => {
  const id = req.params.id;

  if (!req.session.carrinho) req.session.carrinho = [];

  const itemExistente = req.session.carrinho.find(p => p.cod_produto == id);

  if (itemExistente) {
    itemExistente.quantidade++;
    return res.redirect('/carrinho');
  }

  db.query('SELECT * FROM produtos WHERE cod_produto = ?', [id], (error, resultados) => {
    if (error || resultados.length === 0) {
      return res.status(500).send('Erro ao adicionar ao carrinho');
    }

    const produto = resultados[0];
    produto.quantidade = 1;

    req.session.carrinho.push(produto);

    return res.redirect('/carrinho');
  });
});

// Remover 1 unidade
router.post('/remove/:id', (req, res) => {
  const id = req.params.id;

  const carrinho = req.session.carrinho || [];

  const item = carrinho.find(p => p.cod_produto == id);

  if (!item) return res.redirect('/carrinho');

  if (item.quantidade > 1) {
    item.quantidade--;
  } else {
    req.session.carrinho = carrinho.filter(p => p.cod_produto != id);
  }

  return res.redirect('/carrinho');
});

// Limpar carrinho
router.post('/limpar', (req, res) => {
  req.session.carrinho = [];
  res.redirect('/carrinho');
});

module.exports = router;
