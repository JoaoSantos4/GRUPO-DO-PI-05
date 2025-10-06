const express = require('express');
const router = express.Router();
router.get('/', (req, res) => {
    if (!req.session.corporativo) {
        return res.redirect('/');
    }
    res.render('admin', { usuario: req.session.usuario });
});
module.exports = router;