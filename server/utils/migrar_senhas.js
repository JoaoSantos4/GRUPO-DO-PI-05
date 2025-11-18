const db = require('../db');
const { gerarHashComSalt } = require('./hash');

db.query('SELECT id, senha, salt FROM usuarios', async (err, resultados) => {
    if (err) {
        console.error('Erro ao buscar usuários:', err);
        return;
    }

    for (const usuario of resultados) {
        if (usuario.salt) {
            console.log(`Usuário ${usuario.id} já convertido, pulando.`);
            continue;
        }

        const { hash, salt } = gerarHashComSalt(usuario.senha);

        db.query(
            'UPDATE usuarios SET senha = ?, salt = ? WHERE id = ?',
            [hash, salt, usuario.id],
            (err2) => {
                if (err2) {
                    console.error(`Erro ao atualizar usuário ${usuario.id}:`, err2);
                } else {
                    console.log(`Usuário ${usuario.id} convertido com sucesso!`);
                }
            }
        );
    }

    console.log("Migração finalizada!");
});
//node server/utils/migrar_senhas.js
