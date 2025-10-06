const express = require('express')
const router = express.Router()
router.get('/',(req,res)=>{
    res.render('dashboard',{usuario: req.session.usuario})
})
router.get('/', (req, res) => {
    res.send('atendimento');
});
router.get('/', (req, res) => {
    res.send('minhaconta');
});
router.get('/', (req, res) => {
    res.send('atendimento');
});
router.get('/', (req, res) => {
    res.send('sobrenos');
});
router.get('/', (req, res) => {
    res.send('sair');
});
router.get('/', (req, res) => {
    res.send('carrinho');
});
module.exports = router;