const express = require('express');
const router = express.Router();
const db = require('../utils/db');

router.post('/', (req, res) => {
    if (!req.session.usuario) return res.redirect('/');

    const { nome, email, telefone } = req.body;
    const carrinho = req.session.carrinho || [];

    if (carrinho.length === 0) {
        return res.send("Carrinho vazio.");
    }

    const total = carrinho.reduce((acc, item) =>
        acc + (item.preco_real * item.quantidade), 0);

    const vendaSQL = `
        INSERT INTO vendas (nome_cliente, email, telefone, total)
        VALUES (?, ?, ?, ?)
    `;

    db.query(vendaSQL, [nome, email, telefone, total], (err, vendaResultado) => {
        if (err) {
            console.log("Erro ao salvar venda:", err);
            return res.status(500).send("Erro ao registrar venda.");
        }

        const vendaID = vendaResultado.insertId;

        const itensSQL = `
            INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario)
            VALUES ?
        `;

        const valoresItens = carrinho.map(item => [
            vendaID,
            item.cod_produto,
            item.quantidade,
            item.preco_real
        ]);

        db.query(itensSQL, [valoresItens], (err) => {
            if (err) {
                console.log("Erro ao salvar itens:", err);
                return res.status(500).send("Erro ao salvar itens da venda.");
            }

            let updates = carrinho.map(item => {
                return new Promise((resolve, reject) => {
                    db.query(
                        "UPDATE produtos SET estoque = estoque - ? WHERE cod_produto = ?",
                        [item.quantidade, item.cod_produto],
                        (err) => err ? reject(err) : resolve()
                    );
                });
            });

            Promise.all(updates)
                .then(() => {
                    req.session.carrinho = [];

                    db.query("SELECT * FROM vendas WHERE id = ?", [vendaID], (err, vendaDados) => {
                        if (err || vendaDados.length === 0) {
                            return res.send("Erro ao buscar venda finalizada.");
                        }

                        const venda = vendaDados[0];

                        res.render("compra_finalizado", {
                            usuario: req.session.usuario,
                            venda
                        });
                    });
                })
                .catch((err) => {
                    console.log("Erro ao atualizar estoque:", err);
                    res.status(500).send("Erro ao atualizar estoque.");
                });
        });
    });
});

module.exports = router;
