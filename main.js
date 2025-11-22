const { app, BrowserWindow } = require("electron");
const path = require("path");
const http = require("http");

let serverStarted = false;

// Evitar múltiplas instâncias
if (!app.requestSingleInstanceLock()) {
    app.quit();
}

function waitForServer(url, callback) {
    const check = () => {
        http.get(url, res => {
            console.log("✔ Servidor respondeu:", res.statusCode);
            callback();
        }).on("error", () => {
            console.log("Aguardando servidor iniciar...");
            setTimeout(check, 500);
        });
    };
    check();
}

function createWindow() {
    const win = new BrowserWindow({
        width: 1100,
        height: 700,
        webPreferences: {
            preload: path.join(__dirname, "preload.js"),
            nodeIntegration: false,
            contextIsolation: true
        }
    });

    win.loadURL("http://127.0.0.1:4040");
}

app.whenReady().then(() => {
    process.env.ELECTRON_IS_PACKAGED = app.isPackaged ? "true" : "false";

    if (!serverStarted) {
        serverStarted = true;

        let serverPath;

        if (app.isPackaged) {
            serverPath = path.join(process.resourcesPath, "app.asar", "server", "app.js");
        } else {
            serverPath = path.join(__dirname, "server", "app.js");
        }

        console.log("Iniciando servidor em:", serverPath);

        require(serverPath);
    }

    waitForServer("http://127.0.0.1:4040", () => {
        console.log("Servidor pronto! Abrindo janela...");
        createWindow();
    });
});

app.on("window-all-closed", () => {
    app.quit();
});
