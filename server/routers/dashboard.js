const express = require('express');
const router = express.Router();
const db = require('../utils/db');

// =========================
// DASHBOARD PRINCIPAL
// =========================
router.get('/', (req, res) => {
  db.query('SELECT * FROM produtos', (error, resultados) => {
    if (error) {
      console.error('Erro ao carregar produtos:', error);
      return res.status(500).send('Erro ao carregar produtos');
    }

    res.render('dashboard', {
      usuario: req.session.usuario,
      produtos: resultados
    });
  });
});

// CARRINHO REAL COM EJS
router.get('/loja/carrinho', (req, res) => {
  const carrinho = req.session.carrinho || [];
  res.render('carrinho', { carrinho });
});

// ADICIONAR PRODUTO AO CARRINHO
router.post('/carrinho/add/:id', async (req, res) => {
  const id = req.params.id;

  const [rows] = await db.query(
    "SELECT * FROM produtos WHERE cod_produto = ?",
    [id]
  );

  if (rows.length === 0) {
    return res.send("Produto não encontrado!");
  }

  const produto = rows[0];

  if (!req.session.carrinho) req.session.carrinho = [];

  req.session.carrinho.push({
    id: produto.cod_produto,
    nome: produto.nome_produto,
    preco: produto.preco_real, 
    quantidade: 1
  });

  res.redirect('/loja/carrinho');
});

// PÁGINA DE FINALIZAÇÃO
router.get('/finalizar', (req, res) => {
  const carrinho = req.session.carrinho || [];

  if (carrinho.length === 0) {
    return res.send('Seu carrinho está vazio.');
  }

  res.render('finalizar', { carrinho });
});

// FINALIZAR COMPRA
router.post('/finalizar', async (req, res) => {
  const { nome, email, telefone } = req.body;
  const carrinho = req.session.carrinho || [];

  if (carrinho.length === 0) {
    return res.send("Carrinho vazio!");
  }

  try {
    const total = carrinho.reduce((s, p) => s + (p.preco * p.quantidade), 0);

    const [resultado] = await db.query(
      "INSERT INTO vendas (nome_cliente, email, telefone, total) VALUES (?, ?, ?, ?)",
      [nome, email, telefone, total]
    );

    const vendaId = resultado.insertId;

    for (const item of carrinho) {
      await db.query(
        "INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario) VALUES (?, ?, ?, ?)",
        [vendaId, item.id, item.quantidade, item.preco]
      );

      await db.query(
        "UPDATE produtos SET estoque = estoque - ? WHERE cod_produto = ?",
        [item.quantidade, item.id]
      );
    }

    req.session.carrinho = [];

    res.redirect(`/compra_finalizado/${vendaId}`);

  } catch (err) {
    console.log(err);
    res.status(500).send("Erro ao finalizar compra");
  }
});

// PÁGINA COMPRA FINALIZADA
router.get('/compra_finalizado/:id', async (req, res) => {
  const id = req.params.id;

  const [venda] = await db.query("SELECT * FROM vendas WHERE id = ?", [id]);

  if (!venda.length) {
    return res.send("Venda não encontrada!");
  }

  res.render('compra_finalizado', { venda: venda[0] });
});

module.exports = router;
