const db = require('../db');
const { gerarHash } = require('../utils/hash');

db.query('SELECT id, usuario, senha FROM usuarios WHERE salt IS NULL', (err, results) => {
    if (err) throw err;

    if (results.length === 0) {
        console.log("Nenhum usuário antigo para migrar.");
        process.exit();
    }

    console.log(`Convertendo ${results.length} usuários...`);

    results.forEach(usuario => {
        const senhaAntiga = usuario.senha;

        const { hash, salt } = gerarHash(senhaAntiga);

        db.query(
            'UPDATE usuarios SET senha = ?, salt = ? WHERE id = ?',
            [hash, salt, usuario.id],
            err2 => {
                if (err2) throw err2;
            }
        );
    });

    console.log("Migração concluída!");
    process.exit();
}); 
