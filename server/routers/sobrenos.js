const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.render('sobrenos', { 
    usuario: req.session.usuario || null,
    sucesso: null 
  });
});

module.exports = router;
