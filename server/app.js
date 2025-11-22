const express = require("express");
const path = require("path");
const session = require("express-session");

const app = express();

const isPackaged = process.env.ELECTRON_IS_PACKAGED === "true";

const basePath = isPackaged
    ? path.join(process.resourcesPath, "app.asar", "renderer")
    : path.join(__dirname, "../renderer");

console.log("BasePath carregado:", basePath);

app.set("view engine", "ejs");
app.set("views", path.join(basePath, "views"));
app.use(express.static(path.join(basePath, "public")));

app.use(express.urlencoded({ extended: false }));

app.use(session({
    secret: "segredo-super-seguro",
    resave: false,
    saveUninitialized: false
}));

// Rotas...
// (mantenha todas as suas rotas aqui exatamente como estão)

const authRouter = require("./routers/auth");
const dashboardRouter = require("./routers/dashboard");
const atendimentoRouter = require('./routers/atendimento')
const sairRouter = require('./routers/sair') 
const carrinhoRouter = require('./routers/carrinho')
const sobrenosRouter = require('./routers/sobrenos') 
const termosRouter = require('./routers/termos') 
const trocasRouter = require('./routers/trocas') 
const privacidadeRouter = require('./routers/privacidade')
const adminRouter = require('./routers/admin')
const pegarRouter = require('./routers/pagar')
const vendasRouter = require('./routers/vendas')
const produtoRouter = require('./routers/produto')
const finalizarRouter = require('./routers/finalizar')
const compra_finalizadaRouter = require('./routers/compra_finalizado')
const cadastroRouter = require('./routers/cadastro')
const newsletterRoute = require('./routers/newsletter')


app.use("/", authRouter);
app.use("/dashboard", dashboardRouter);
app.use('/atendimento', atendimentoRouter)
app.use('/sair', sairRouter)
app.use('/carrinho', carrinhoRouter)
app.use('/sobrenos', sobrenosRouter)
app.use('/termos', termosRouter)
app.use('/trocas', trocasRouter)
app.use('/privacidade', privacidadeRouter)
app.use('/admin', adminRouter)
app.use('/pagar', pegarRouter)
app.use('/vendas', vendasRouter)
app.use('/produto', produtoRouter)
app.use('/finalizar', finalizarRouter)
app.use('/compra_finalizado', compra_finalizadaRouter)
app.use('/cadastro', cadastroRouter)
app.use('/newsletter', newsletterRoute)


const PORT = 4040;

app.listen(PORT, "127.0.0.1", () => {
    console.log(`Servidor rodando em http://127.0.0.1:${PORT}`);
});
