#  SAFLU — Sistema Web de Agendamento para Unidade de Saúde Fluvial

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Em%20Desenvolvimento-orange.svg)]()
[![Instituição](https://img.shields.io/badge/Instituição-CETAM-green.svg)](https://www.cetam.am.gov.br/)
[![Localização](https://img.shields.io/badge/Região-Rio%20Negro%20%2F%20AM-blue)](https://www.amazonas.am.gov.br/)
[![Trello](https://img.shields.io/badge/Gestão-TRELLO-blue.svg)](https://trello.com/b/yCCygNpF/safluagendamento)

> **Projeto de Prática Profissional Supervisionada**  
> **Instituição:** Centro de Educação Tecnológica do Amazonas (CETAM) – Escola Técnica Galiléia  
> **Curso:** Curso Técnico de Nível Médio em Desenvolvimento de Sistemas  
> **Autora:**
> 1. Hydayse Guilhermina Pereira dos Santos
> 2. Jernan Soares de Oliveira
> 3. Angélica Pereira Rodrigues
> 4. Rosinéia Silva
>  
> **Orientadora:** Instrutora Priscila Gonçalves  
> **Período:** 18/08/2026 a 08/09/2026 | **Local:** Manaus - AM  

---

##  Sumário
- [Sobre o Projeto](#-sobre-o-projeto)
- [Justificativa Técnica](#-justificativa-técnica)
- [Área de Abrangência](#-área-de-abrangência)
- [Arquitetura do Projeto](#-arquitetura-do-projeto)
- [Modelagem de Dados](#-modelagem-de-dados)
- [Requisitos do Sistema](#-requisitos-do-sistema)
- [Regras de Negócio](#-regras-de-negócio)
- [Estrutura do Repositório](#-estrutura-do-repositório)
- [Órgãos Envolvidos](#-órgãos-envolvidos)
- [Referências](#-referências)

---

##  Sobre o Projeto

O **SAFLU** é um sistema web desenvolvido para organizar, controlar e gerenciar os agendamentos de atendimentos de saúde realizados por **Unidades Básicas de Saúde Fluviais (UBSF)**. A solução foi projetada especificamente para atender às particularidades logísticas e geográficas das comunidades ribeirinhas ao longo do **Rio Negro**, na Amazônia.

###  Objetivos Principais
* **Gerenciamento de Agendamentos:** Permitir o cadastro e a marcação de consultas, vacinações e atendimentos odontológicos ou de enfermagem.
* **Controle Terrritorial:** Mapear e gerenciar as comunidades ribeirinhas, rotas fluviais e o cronograma de paradas das embarcações.
* **Suporte Offline-First:** Garantir o armazenamento local de dados e a sincronização posterior quando houver conexão via satélite ou no retorno à cidade.
* **Relatórios Gerenciais:** Oferecer métricas sobre atendimentos realizados, demanda reprimida e dados populacionais para planejamento de missões de saúde.

---

##  Justificativa Técnica

Devido à grande extensão territorial e à limitação do transporte na região amazônica, a organização manual por fichas de papel gera duplicidade de horários, perda de dados e descontrole na fila de espera. O SAFLU resolve isso ao centralizar a informação, aplicar validações automáticas de agendamento e sincronizar os registros locais com os bancos centrais do **e-SUS APS/PEC**.

---

##  Área de Abrangência

O sistema atende moradores, agentes comunitários de saúde (ACS), equipes médicas e gestores nas comunidades ribeirinhas do **Rio Negro e afluentes próximos**:
* **Usuários Pacientes:** Moradores ribeirinhos que acessam horários e pré-agendamentos.
* **Profissionais de Saúde:** Médicos, enfermeiros, dentistas e técnicos a bordo.
* **Administradores:** Gestores das Secretarias Municipais de Saúde encarregados do planejamento das expedições.

---
## Arquitetura

>saflu/
├── .github/                       # Configurações do GitHub (Workflows, CI/CD, Templates)
│   ├── ISSUE_TEMPLATE/            # Modelos para abertura de bugs e tarefas
│   └── workflows/                 # Pipelines de integração e deploy contínuo (CI/CD)
│       └── deploy.yml
├── docs/                          # Documentações técnicas, manuais e artefatos do projeto
│   ├── imagens/                   # Prints das telas, logotipos e capturas para o README
│   ├── modelagem/                 # Diagramas de arquitetura, UML e Banco de Dados
│   │   ├── caso_de_uso.png
│   │   ├── diagrama_classes.png
│   │   ├── modelo_conceitual.png
│   │   └── modelo_logico.png
│   └── relatorio_cetam.pdf        # Relatório Técnico Final de Prática Supervisionada
├── public/                        # Arquivos estáticos servidos diretamente
│   ├── favicon.ico                # Ícone da aba do navegador
│   ├── manifest.json              # Configuração do PWA (Progressive Web App)
│   ├── robots.txt                 # Diretrizes para motores de busca
│   └── service-worker.js          # Script para funcionamento Offline-First e cache
├── src/                           # Código-fonte principal da aplicação
│   ├── assets/                    # Recursos visuais e estilização global
│   │   ├── fonts/                 # Fontes personalizadas
│   │   ├── icons/                 # Ícones em formato SVG/PNG
│   │   ├── img/                   # Imagens utilizadas na interface
│   │   └── styles/                # Arquivos CSS/SASS/Styled-Components globais
│   │       ├── global.css
│   │       └── theme.js
│   ├── components/                # Componentes reutilizáveis da interface (UI)
│   │   ├── common/                # Elementos genéricos (Botões, Modais, Inputs, Cards)
│   │   ├── layout/                # Estruturas fixas (Navbar, Sidebar, Footer, Header)
│   │   └── offline/               # Indicadores de status de conexão e sincronização
│   ├── config/                    # Configurações de ambiente, constantes e rotas
│   │   ├── api.js                 # Instância do Axios / Fetch HTTP
│   │   ├── constants.js           # Constantes do sistema (perfis, status)
│   │   └── routes.js              # Mapeamento de rotas e permissões da aplicação
│   ├── context/                   # Contextos globais da aplicação (React Context API / Redux)
│   │   ├── AuthContext.js         # Estado global de autenticação e sessão do usuário
│   │   └── SyncContext.js         # Gerenciador de sincronização dos dados offline
│   ├── database/                  # Modelagem física e migrações do banco de dados
│   │   ├── migrations/            # Histórico de alteração da estrutura do banco
│   │   ├── seeds/                 # Dados iniciais para povoamento (mock de comunidades/serviços)
│   │   └── schema.sql             # Script SQL de criação de tabelas (PostgreSQL + PostGIS)
│   ├── hooks/                     # Custom Hooks (Lógica encapsulada reutilizável)
│   │   ├── useAuth.js             # Hook para manipular autenticação
│   │   ├── useIndexedDB.js        # Hook para leitura/escrita no banco local offline
│   │   └── useOnlineStatus.js     # Hook para detectar queda/retorno de sinal de internet
│   ├── services/                  # Comunicação externa, APIs e regras de negócio
│   │   ├── api.js                 # Serviços de requisições REST
│   │   ├── esusIntegration.js     # Módulo de exportação/sincronização no padrão e-SUS PEC
│   │   ├── indexedDB.js           # Banco de dados local do navegador (IndexedDB/Dexie.js)
│   │   └── syncService.js         # Motor de resolução de conflitos (Last Write Wins)
│   ├── utils/                     # Funções utilitárias e ajudantes (Helpers)
│   │   ├── formatters.js          # Formatadores de CPF, CNS, telefone e datas
│   │   └── validators.js          # Validações de formulários (LGPD, campos obrigatórios)
│   ├── views/                     # Telas/Páginas principais da aplicação
│   │   ├── admin/                 # Painel do Gestor (Gerenciamento de Unidades e Relatórios)
│   │   ├── auth/                  # Telas de Acesso (Login, Cadastro, Recuperação de Senha)
│   │   ├── health/                # Módulo do Profissional (Atendimento Médico e Agendas)
│   │   ├── patient/               # Módulo do Paciente/ACS (Solicitação e Consulta de Agendamentos)
│   │   └── NotFound.js            # Tela de Erro 404
│   ├── App.js                     # Componente raiz da aplicação
│   └── index.js                   # Ponto de entrada (Entry point JavaScript)
├── .env.example                   # Exemplo de variáveis de ambiente (sem chaves secretas)
├── .eslintrc.json                 # Regras de padronização do código JavaScript/React
├── .gitignore                     # Arquivos e pastas ignorados pelo Git (node_modules, .env)
├── .prettierrc                    # Regras de formatação automática do código
├── LICENSE                        # Licença de uso do software (ex: MIT)
├── README.md                      # Documentação principal para o repositório no GitHub
└── package.json                   # Dependências e scripts do Node.js
---

##  Arquitetura do Projeto

          +-------------------------------------------------+
           |             PWA Client / Web App                |
           | (React / Service Workers / IndexedDB (Offline)) |
           +-----------------------+-------------------------+
                                   |
               HTTP / TLS (Sincronização ao conectar)
                                   v
           +-------------------------------------------------+
           |                 API Gateway / REST              |
           +-----------------------+-------------------------+
                                   |
               +-------------------+-------------------+
               |                                       |
               v                                       v
    +--------------------+                   +-------------------+
    | PostgreSQL + PostGIS|                   | Exportação e-SUS  |
    |  (Dados & Geoloc)  |                   | (Thrift / PEC)    |
    +--------------------+                   +-------------------+
    

