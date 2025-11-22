const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      console.log('Erro ao encerrar sessão:', err);
      return res.status(500).send('Erro ao sair');
    }
    res.clearCookie('connect.sid');
    res.redirect('/');
  });
});

module.exports = router;
