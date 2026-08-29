-- ============================================================
--  RÉPERTOIRE NUMÉRIQUE DE LA JEUNESSE D'AVLÉKÉTÉ
--  Schéma Supabase — à exécuter UNE SEULE FOIS
--  dans : Dashboard Supabase → SQL Editor → New query
-- ============================================================

-- Extension UUID (activée par défaut sur Supabase)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ──────────────────────────────────────────────────────────
-- 1. TABLE VILLAGES
-- ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS villages (
  id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  nom        TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Villages par défaut
INSERT INTO villages (nom) VALUES
  ('Adounko'),
  ('Adounko Ayignon'),
  ('Agbanzin-Kpota'),
  ('Agbanzin-Kpota Zounvlamè'),
  ('Agouin'),
  ('Ahouandji-Avlékété'),
  ('Avlékété'),
  ('Hio'),
  ('Hio Vinawa')
ON CONFLICT (nom) DO NOTHING;

-- ──────────────────────────────────────────────────────────
-- 2. TABLE JEUNES (profils)
-- ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS jeunes (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  nom         TEXT NOT NULL,
  prenom      TEXT NOT NULL,
  sexe        TEXT,
  dob         DATE,
  cip         TEXT UNIQUE NOT NULL,
  tel         TEXT,
  email       TEXT,
  niveau      TEXT,
  situation   TEXT,
  profession  TEXT,
  village     TEXT,
  competences TEXT,
  diplomes    TEXT,
  biographie  TEXT,
  status      TEXT NOT NULL DEFAULT 'pending'
                   CHECK (status IN ('pending','approved','rejected')),
  files       JSONB DEFAULT '[]'::jsonb,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ──────────────────────────────────────────────────────────
-- 3. TABLE ACCOUNTS (authentification des jeunes)
-- ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS accounts (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  cip           TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  user_id       UUID REFERENCES jeunes(id) ON DELETE CASCADE,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- ──────────────────────────────────────────────────────────
-- 4. TABLE MESSAGES
-- ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS messages (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  to_user_id    UUID REFERENCES jeunes(id) ON DELETE CASCADE,
  text          TEXT NOT NULL,
  from_role     TEXT NOT NULL CHECK (from_role IN ('admin','user')),
  read_by_admin BOOLEAN DEFAULT FALSE,
  read_by_user  BOOLEAN DEFAULT FALSE,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- ──────────────────────────────────────────────────────────
-- 5. TABLE ADMINS (comptes "responsables" créés depuis le
--    tableau de bord par l'administrateur principal)
--    NB : les 2 comptes historiques (admin / resp.avlekete)
--    restent codés en dur dans index.html et ne sont PAS ici.
--    Cette table sert uniquement aux comptes créés via l'UI.
-- ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS admins (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  username      TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  nom           TEXT NOT NULL,
  role          TEXT NOT NULL DEFAULT 'responsable'
                    CHECK (role IN ('principal','responsable')),
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- ──────────────────────────────────────────────────────────
-- 6. TABLE JOURNAL D'ACTIVITÉ
-- ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS activity_log (
  id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  msg        TEXT NOT NULL,
  type       TEXT DEFAULT 'info',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ──────────────────────────────────────────────────────────
-- 7. ROW LEVEL SECURITY (RLS)
--    Sécurité applicative gérée côté frontend.
--    Les politiques ci-dessous permettent la clé anon
--    d'effectuer toutes les opérations CRUD.
--    ⚠️ Comme pour les autres tables, ceci n'est pas une
--    vraie barrière serveur : à terme, envisagez une Edge
--    Function pour la création de comptes admin.
-- ──────────────────────────────────────────────────────────
ALTER TABLE villages     ENABLE ROW LEVEL SECURITY;
ALTER TABLE jeunes       ENABLE ROW LEVEL SECURITY;
ALTER TABLE accounts     ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages     ENABLE ROW LEVEL SECURITY;
ALTER TABLE admins       ENABLE ROW LEVEL SECURITY;
ALTER TABLE activity_log ENABLE ROW LEVEL SECURITY;

-- Supprimer les anciennes politiques si elles existent
DROP POLICY IF EXISTS "anon_villages"     ON villages;
DROP POLICY IF EXISTS "anon_jeunes"       ON jeunes;
DROP POLICY IF EXISTS "anon_accounts"     ON accounts;
DROP POLICY IF EXISTS "anon_messages"     ON messages;
DROP POLICY IF EXISTS "anon_admins"       ON admins;
DROP POLICY IF EXISTS "anon_activity_log" ON activity_log;

-- Créer les nouvelles politiques
CREATE POLICY "anon_villages"     ON villages     FOR ALL USING (TRUE) WITH CHECK (TRUE);
CREATE POLICY "anon_jeunes"       ON jeunes       FOR ALL USING (TRUE) WITH CHECK (TRUE);
CREATE POLICY "anon_accounts"     ON accounts     FOR ALL USING (TRUE) WITH CHECK (TRUE);
CREATE POLICY "anon_messages"     ON messages     FOR ALL USING (TRUE) WITH CHECK (TRUE);
CREATE POLICY "anon_admins"       ON admins       FOR ALL USING (TRUE) WITH CHECK (TRUE);
CREATE POLICY "anon_activity_log" ON activity_log FOR ALL USING (TRUE) WITH CHECK (TRUE);

-- ──────────────────────────────────────────────────────────
-- 8. INDEX POUR LES PERFORMANCES
-- ──────────────────────────────────────────────────────────
CREATE INDEX IF NOT EXISTS idx_jeunes_status    ON jeunes(status);
CREATE INDEX IF NOT EXISTS idx_jeunes_village   ON jeunes(village);
CREATE INDEX IF NOT EXISTS idx_jeunes_cip       ON jeunes(cip);
CREATE INDEX IF NOT EXISTS idx_accounts_cip     ON accounts(cip);
CREATE INDEX IF NOT EXISTS idx_messages_to_user ON messages(to_user_id);
CREATE INDEX IF NOT EXISTS idx_admins_username  ON admins(username);
CREATE INDEX IF NOT EXISTS idx_actlog_created   ON activity_log(created_at DESC);

-- ──────────────────────────────────────────────────────────
-- FIN DU SCHÉMA
-- ✅ Exécutez ce script, puis configurez les clés dans index.html
-- ──────────────────────────────────────────────────────────
