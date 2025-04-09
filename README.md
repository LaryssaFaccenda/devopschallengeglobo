# Desafio DevOps

Este projeto envolve o deploy automatizado de aplicações Node.js e Python no Google Cloud Run, utilizando Terraform para gerenciar a infraestrutura e Google Memorystore (Redis) para implementar uma camada de cache. O objetivo do projeto é demonstrar como automatizar a criação de infraestrutura na Google Cloud, implementar cache de alta performance e permitir a fácil execução de deployments.

## Arquitetura
![devopschallenge drawio](https://github.com/user-attachments/assets/6231cf7b-6455-4465-909d-2d82ce06906e)

## Como executar?
### Disparando o Workflow Manualmente
Para rodar o workflow de deploy manualmente, siga estas etapas:
* Acesse a aba Actions do repositório no GitHub.
* Selecione o workflow desejado e clique em "Run workflow", como: Deploy VPC, depois o Deploy Memorystore para Redis e então o Deploy to Cloud Run para testar todo esse fluxo.

O workflow será executado e você poderá acompanhar o progresso e ver os logs.

Passos do Workflow
* Deploy da VPC e Deploy Memorystore para Redis:
* O Terraform cria a VPC e o Redis Memorystore.

Deploy das Aplicações para Cloud Run:
Cloud Build cria as imagens Docker para as aplicações Node.js e Python.
O Cloud Run é configurado com as variáveis do Redis para poder acessá-lo.


## Configuração da Camada de Cache
Este projeto utiliza Google Memorystore (Redis) como camada de cache para as aplicações Node.js e Python. A camada de cache ajuda a melhorar a performance das aplicações, armazenando em cache dados frequentemente acessados, evitando a necessidade de consultas repetidas ao banco de dados ou cálculos caros.

Como funciona?
Python: A aplicação Python usa FastAPI para expor duas rotas (/texto e /horario). Os dados dessas rotas são armazenados em cache no Redis com um TTL de 10 segundos.

Node.js: A aplicação Node.js funciona de maneira similar, utilizando o node-cache para armazenar as respostas em cache.

## Infraestrutura Automatizada para Fácil Execução
A infraestrutura foi automatizada utilizando Terraform e GitHub Actions. O Terraform é responsável por provisionar todos os recursos necessários na Google Cloud, incluindo:
* VPC (rede privada) para garantir que o Cloud Run e o Redis Memorystore possam se comunicar.
* Google Cloud Run para hospedar as aplicações Node.js e Python.
* Google Memorystore para Redis, configurado como camada de cache para as aplicações.

## Análise e Sugestões de Melhoria

Escalabilidade:
* As instâncias do Cloud Run podem ser escaladas automaticamente, mas é bom configurar um mínimo e máximo de instâncias para otimizar custos e performance.
* Para uma alta disponibilidade do Redis, posso considerar usar a configuração STANDARD_HA para garantir que o serviço continue disponível em caso de falhas em um cenário mais comercial e corporativo.

Monitoramento e Logs:
Embora escolhi o Cloud Run pela facilidade de deploy de uma aplicação, ele também dispõe de SLIs interessantes para se ter uma ideia da saúde da aplicação como tempo de resposta e tráfego. Porém, fica a ideia de um up no monitoramento:
* Adicionar monitoramento para o Cloud Run e Redis para detectar possíveis problemas de performance como saturação desta infra, como atingimento de limite ou perto do limite.
* Implementar Google Cloud Logging e Cloud Monitoring para rastrear o uso do cache e as métricas de aplicação.
