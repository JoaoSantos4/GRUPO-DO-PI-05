const express = require('express');
const router = express.Router();
const db = require('../utils/db'); // caminho pode variar no seu projeto

// Página Minhas Compras
router.get('/', (req, res) => {
    if (!req.session.usuario) {
        return res.redirect('/');
    }

    const usuarioNome = req.session.usuario.usuario; // nome do usuário logado

    const sql = `
        SELECT 
            v.id AS venda_id,
            v.nome_cliente,
            v.email,
            v.telefone,
            v.total,
            v.data_venda,
            p.nome_produto,
            iv.quantidade,
            iv.preco_unitario
        FROM vendas v
        JOIN itens_venda iv ON iv.venda_id = v.id
        JOIN Produtos p ON p.cod_produto = iv.produto_id
        WHERE v.nome_cliente = ?
        ORDER BY v.data_venda DESC
    `;

    db.query(sql, [usuarioNome], (err, resultados) => {
        if (err) {
            console.log(err);
            return res.send("Erro ao buscar suas compras.");
        }

        res.render('minhas_compras', {
            usuario: req.session.usuario,
            compras: resultados
        });
    });
});

module.exports = router;
