const express = require('express');
const router = express.Router();
const db = require('../db');

// Recebe o email da newsletter
router.post('/', (req, res) => {
    const { email } = req.body;

    db.query(
        'INSERT INTO newsletter (email) VALUES (?)',
        [email],
        (err) => {
            if (err) {
                // Caso o email já exista na tabela
                if (err.code === "ER_DUP_ENTRY") {
                    return res.render('sobrenos', {
                        usuario: req.session.usuario,
                        sucesso: "Esse e-mail já está cadastrado!"
                    });
                }
                throw err;
            }

            return res.render('sobrenos', {
                usuario: req.session.usuario,
                sucesso: "Obrigado! Você receberá nossas promoções em primeira mão!"
            });
        }
    );
});

module.exports = router;
