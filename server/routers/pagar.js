const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    if (!req.session.usuario) {
        return res.redirect('/');
    }

    // pagar.ejs NÃO existe → usar finalizar.ejs
    res.render('finalizar', { usuario: req.session.usuario });
});

module.exports = router;
