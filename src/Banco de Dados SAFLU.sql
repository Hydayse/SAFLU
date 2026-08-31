-- Comunidades/Localidades de Atendimento
CREATE TABLE comunidades (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    rio VARCHAR (50) NOT NULL,
    localizacao GEOMETRY (Point, 4326) -- Coordenadas GPS da comunidade
);

-- Expedição/Viagem da Embarcação
CREATE TABLE expedicoes (
    id SERIAL PRIMARY KEY,
    embarcacao_nome VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'PLANALTO' -- 'PLANEJADA', 'EM_ANDAMENTO', 'CONCLUIDA'
);

-- Cronograma por Comunidade em uma Expedição
CREATE TABLE paradas_expedicao (
    id SERIAL PRIMARY KEY,
    expedicao_id INT REFERENCES expedicoes(id),
 
   comunidade_id INT REFERENCES comunidades(id),
    data_chegada TIMESTAMP NOT NULL,
    data_saida TIMESTAMP NOT NULL,
    vagas_medicas INT DEFAULT 30,
    vagas_odontology INT DEFAULT 20
);

-- Usuários / Pacientes Ribeirinhos
CREATE TABLE pacientes (
    id SERIAL PRIMARY KEY,
    cns VARCHAR(15) UNIQUE NOT NULL, -- Cartão Nacional de Saúde
    cpf VARCHAR(11) UNIQUE,
    nome VARCHAR(150) NOT NULL,
    comunidade_id INT REFERENCES comunidades(id),
    sync_status BOOLEAN DEFAULT true -- Controle de sincronização offline
);
-- Agendamentos
CREATE TABLE agendamentos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    parada_id INT REFERENCES paradas_expedicao(id),
    paciente_id INT REFERENCES pacientes(id),
    especialidade VARCHAR(50) NOT NULL, -- 'CLINICO_GERAL', 'ODONTOLOGIA', 'ENFERMAGEM'
    horario_estimado TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'AGENDADO', -- 'AGENDADO', 'ATENDIDO', 'FALTOU'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
