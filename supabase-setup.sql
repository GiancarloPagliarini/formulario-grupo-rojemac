-- ============================================
-- RODAR NO SUPABASE DASHBOARD > SQL EDITOR
-- ============================================

-- 1. Tabela de Produtos
CREATE TABLE IF NOT EXISTS produtos (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at timestamptz DEFAULT now(),
  marca_selecionada text,
  nome_produto text NOT NULL,
  url_produto text,
  conjunto text NOT NULL,
  qtd_pecas text,
  altura numeric,
  largura numeric,
  cor_principal text NOT NULL,
  cores_secundarias text[],
  foto_frente_url text,
  foto_verso_url text,
  foto_lateral_url text,
  foto_topo_url text,
  foto_uso_url text,
  foto_segurando_url text
);

-- 2. Tabela de Influencers
CREATE TABLE IF NOT EXISTS influencers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at timestamptz DEFAULT now(),
  marca_selecionada text,
  nome_artistico text NOT NULL,
  idade_aparente integer,
  etnia text,
  sotaque text,
  intensidade_sotaque text,
  sotaque_outro text,
  tom_de_pele text,
  cor_dos_olhos text,
  cor_do_cabelo text,
  tipo_de_cabelo text,
  comprimento_cabelo text,
  estatura text,
  tipo_de_corpo text,
  estilo_de_maquiagem text,
  elevenlabs_voice_id text,
  elevenlabs_voice_name text,
  voz_descricao_custom text,
  estilo_de_roupa text,
  paleta_de_roupas text[],
  acessorios_frequentes text[],
  foto_referencia_rosto_url text,
  foto_referencia_corpo_url text,
  moodboard_url text,
  inspiracoes text,
  observacoes_gerais text
);

-- 3. Habilitar RLS (Row Level Security)
ALTER TABLE produtos ENABLE ROW LEVEL SECURITY;
ALTER TABLE influencers ENABLE ROW LEVEL SECURITY;

-- 4. Conceder permissão de INSERT ao role anon
GRANT INSERT ON produtos TO anon;
GRANT INSERT ON influencers TO anon;

-- 5. Policies: permitir INSERT anônimo (formulário público)
CREATE POLICY "Allow anonymous insert on produtos"
  ON produtos FOR INSERT
  TO anon
  WITH CHECK (true);

CREATE POLICY "Allow anonymous insert on influencers"
  ON influencers FOR INSERT
  TO anon
  WITH CHECK (true);

-- 5. Policy de Storage: permitir upload anônimo no bucket
CREATE POLICY "Allow anonymous uploads"
  ON storage.objects FOR INSERT
  TO anon
  WITH CHECK (bucket_id = 'formulario-uploads');

-- 6. Policy de Storage: permitir leitura pública
CREATE POLICY "Allow public read"
  ON storage.objects FOR SELECT
  TO anon
  USING (bucket_id = 'formulario-uploads');
