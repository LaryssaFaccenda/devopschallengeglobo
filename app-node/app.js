const express = require('express');
const NodeCache = require('node-cache');
const app = express();
const port = process.env.PORT || 8080;

// Instanciando o cache
const cache = new NodeCache({ stdTTL: 60, checkperiod: 120 }); // Cache de 1 minuto

// Rota que retorna um texto fixo
app.get('/texto', (req, res) => {
    const cacheKey = 'texto';
    let texto = cache.get(cacheKey);

    if (!texto) {
        texto = 'Olá do app Node!';
        cache.set(cacheKey, texto); // Armazena no cache por 1 minuto
    }

    res.send(texto);
});

// Rota que retorna a hora atual do servidor
app.get('/horario', (req, res) => {
    const cacheKey = 'horario';
    let horario = cache.get(cacheKey);

    if (!horario) {
        horario = new Date().toISOString();
        cache.set(cacheKey, horario); // Armazena no cache por 1 minuto
    }

    res.send(horario);
});

// Inicia o servidor
app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});
