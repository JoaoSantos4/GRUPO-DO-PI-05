const express = require('express');
const router = express.Router();
const db = require('../utils/db');

router.post('/', (req, res) => {
    const { email } = req.body;

    db.query(
        'INSERT INTO newsletter (email) VALUES (?)',
        [email],
        (err) => {
            if (err) {

                if (err.code === "ER_DUP_ENTRY") {
                    return res.render('sobrenos', {
                        usuario: req.session.usuario || null,
                        sucesso: "Esse e-mail já está cadastrado!"
                    });
                }

                throw err;
            }

            return res.render('sobrenos', {
                usuario: req.session.usuario || null,
                sucesso: "Obrigado! Você receberá nossas promoções em primeira mão!"
            });
        }
    );
});

module.exports = router;
