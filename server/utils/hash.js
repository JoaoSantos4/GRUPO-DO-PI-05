const crypto = require("crypto");

// Gera salt + hash para cadastro
function gerarHash(senha) {
  const salt = crypto.randomBytes(16).toString("hex");
  const hash = crypto.pbkdf2Sync(senha, salt, 1000, 64, "sha512").toString("hex");
  return { salt, hash };
}

// Valida login
function validarSenha(senhaDigitada, hashBanco, saltBanco) {
  // compatibilidade com banco velho (sem salt)
  if (!saltBanco) {
    console.log("⚠ Usuário sem SALT — comparação direta.");
    return senhaDigitada === hashBanco;
  }

  const hashTest = crypto.pbkdf2Sync(
    senhaDigitada,
    saltBanco,
    1000,
    64,
    "sha512"
  ).toString("hex");

  return hashTest === hashBanco;
}

module.exports = { gerarHash, validarSenha };
