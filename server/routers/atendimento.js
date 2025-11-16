const express = require('express');
const router = express.Router();
const db = require('../db');

// Exibe o formulário
router.get('/', (req, res) => {
    if (!req.session.usuario) {
        return res.redirect('/');
    }

    res.render('atendimento', { 
        usuario: req.session.usuario,
        sucesso: null 
    });
});

// Recebe o formulário e salva no banco
router.post('/', (req, res) => {
    const { nome, email, mensagem } = req.body;

    db.query(
        'INSERT INTO atendimento (nome, email, mensagem) VALUES (?, ?, ?)',
        [nome, email, mensagem],
        (err) => {
            if (err) throw err;

            return res.render('atendimento', { 
                usuario: req.session.usuario,
                sucesso: 'Mensagem enviada! Retornamos no seu e-mail em até 24 horas.'
            });
        }
    );
});

module.exports = router;
