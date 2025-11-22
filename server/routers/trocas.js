const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.render('trocas', { 
        usuario: req.session.usuario || null 
    });
});

module.exports = router;
