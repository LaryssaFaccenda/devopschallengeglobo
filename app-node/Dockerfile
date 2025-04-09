# Usando uma imagem base do Node.js
FROM node:16-slim

# Definindo o diretório de trabalho
WORKDIR /app

# Copiando os arquivos de dependências
COPY package*.json ./

# Instalando as dependências
RUN npm install

# Copiando o código da aplicação
COPY . .

# Expondo a porta que o aplicativo vai rodar
EXPOSE 8080

# Definindo o comando para rodar a aplicação
CMD ["node", "app.js"]
