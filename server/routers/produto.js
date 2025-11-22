const express = require('express');
const router = express.Router();
const db = require('../utils/db');

// Página de produto individual
router.get('/:id', (req, res) => {
  const id = req.params.id;

  db.query(
    'SELECT * FROM produtos WHERE cod_produto = ?',
    [id],
    (erro, resultados) => {
      if (erro) {
        console.error(erro);
        return res.status(500).send('Erro ao carregar produto');
      }

      if (resultados.length === 0) {
        return res.status(404).send('Produto não encontrado');
      }

      const produto = resultados[0];

      res.render('produto', { produto });
    }
  );
});

module.exports = router;