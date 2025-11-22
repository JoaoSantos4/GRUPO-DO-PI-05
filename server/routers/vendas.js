const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    if (!req.session.usuario) {
        return res.redirect('/');
    }

    // vendas.ejs NÃO existe → usar dashboard.ejs
    res.render('dashboard', { usuario: req.session.usuario });
});

module.exports = router;
