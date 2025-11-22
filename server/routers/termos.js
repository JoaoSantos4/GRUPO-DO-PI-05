const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.render('termo', { 
        usuario: req.session.usuario || null 
    });
});

module.exports = router;
