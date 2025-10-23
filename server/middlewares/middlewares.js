function isAuthenticated(req, res, next) {
  if (req.session && req.session.user) {
    return next()
  } else {
    return res.redirect('/')
  }
}

function checkRole(requiredRole) {
  return (req, res, next) => {
    if (!req.session.user || req.session.user.nivel < requiredRole) {
      return res.status(403).render('erros/403.ejs', {
        msg: 'Acesso negado: você não tem permissão suficiente.'
      })
    }
    next()
  }
}

module.exports = { isAuthenticated, checkRole }
