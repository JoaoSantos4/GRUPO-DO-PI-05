const express = require('express');
const router = express.Router();
router.get('/', (req, res) => {
  if (!req.session.usuario) {
    return res.redirect('/');
  }
  res.render('sobrenos', { usuario: req.session.usuario });
});
module.exports = router;