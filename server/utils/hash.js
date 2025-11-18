const crypto = require('crypto');

function gerarHash(senha) {
    const salt = crypto.randomBytes(16).toString('hex');
    const hash = crypto
        .pbkdf2Sync(senha, salt, 1000, 64, 'sha512')
        .toString('hex');

    return { hash, salt };
}

function validarSenha(senhaDigitada, hashOriginal, salt) {
    const hash = crypto
        .pbkdf2Sync(senhaDigitada, salt, 1000, 64, 'sha512')
        .toString('hex');

    return hash === hashOriginal;
}

module.exports = {
    gerarHash,
    validarSenha
};
