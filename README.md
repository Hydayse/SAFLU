# 🚤 SAFLU — Sistema Web de Agendamento para Unidade de Saúde Fluvial

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Em%20Desenvolvimento-orange.svg)]()
[![Instituição](https://img.shields.io/badge/Instituição-CETAM-green.svg)](https://www.cetam.am.gov.br/)
[![Localização](https://img.shields.io/badge/Região-Rio%20Negro%20%2F%20AM-blue)](https://www.amazonas.am.gov.br/)
[![Trello](https://trello.com/b/yCCygNpF/safluagendamento)]

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

## 📋 Sumário
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

## 🌊 Sobre o Projeto

O **SAFLU** é um sistema web desenvolvido para organizar, controlar e gerenciar os agendamentos de atendimentos de saúde realizados por **Unidades Básicas de Saúde Fluviais (UBSF)**. A solução foi projetada especificamente para atender às particularidades logísticas e geográficas das comunidades ribeirinhas ao longo do **Rio Negro**, na Amazônia.

### 🎯 Objetivos Principais
* **Gerenciamento de Agendamentos:** Permitir o cadastro e a marcação de consultas, vacinações e atendimentos odontológicos ou de enfermagem.
* **Controle Terrritorial:** Mapear e gerenciar as comunidades ribeirinhas, rotas fluviais e o cronograma de paradas das embarcações.
* **Suporte Offline-First:** Garantir o armazenamento local de dados e a sincronização posterior quando houver conexão via satélite ou no retorno à cidade.
* **Relatórios Gerenciais:** Oferecer métricas sobre atendimentos realizados, demanda reprimida e dados populacionais para planejamento de missões de saúde.

---

## 🛠️ Justificativa Técnica

Devido à grande extensão territorial e à limitação do transporte na região amazônica, a organização manual por fichas de papel gera duplicidade de horários, perda de dados e descontrole na fila de espera. O SAFLU resolve isso ao centralizar a informação, aplicar validações automáticas de agendamento e sincronizar os registros locais com os bancos centrais do **e-SUS APS/PEC**.

---

## 📍 Área de Abrangência

O sistema atende moradores, agentes comunitários de saúde (ACS), equipes médicas e gestores nas comunidades ribeirinhas do **Rio Negro e afluentes próximos**:
* **Usuários Pacientes:** Moradores ribeirinhos que acessam horários e pré-agendamentos.
* **Profissionais de Saúde:** Médicos, enfermeiros, dentistas e técnicos a bordo.
* **Administradores:** Gestores das Secretarias Municipais de Saúde encarregados do planejamento das expedições.

---

## 🏛️ Arquitetura do Projeto

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

saflu/
├── docs/                   # Documentações técnicas e manuais
│   ├── modelagem/          # Diagramas ER, Casos de Uso e Sequência
│   └── relatorio_cetam.pdf # Relatório Técnico do Projeto
├── src/
│   ├── assets/             # Imagens, ícones e estilos globais
│   ├── components/         # Componentes visuais reutilizáveis
│   ├── database/           # Scripts SQL, migrations e seeds
│   ├── services/           # Regras de negócio e integração API/e-SUS
│   └── views/              # Telas do sistema (Login, Agenda, Dashboard)
├── .gitignore
├── LICENSE
├── README.md
└── package.json
