# Répertoire Numérique de la Jeunesse d'Avlékété
**Version 2.0 Production — Commune de Ouidah · Bénin**

---

## 🚀 Déploiement sur Vercel (5 min)

### Étape 1 — Créer la base de données Supabase
1. Créez un compte gratuit sur **[supabase.com](https://supabase.com)**
2. Créez un nouveau projet
3. Ouvrez **SQL Editor → New query**
4. Copiez-collez le contenu de `schema.sql` et cliquez **Run**

### Étape 2 — Récupérer les clés
1. Allez dans **Project Settings → API**
2. Copiez **Project URL** et **anon public key**

### Étape 3 — Configurer index.html
Ouvrez `index.html` et remplacez les lignes **24-25** :
```
const SUPABASE_URL  = 'https://VOTRE_ID.supabase.co';
const SUPABASE_ANON = 'VOTRE_CLE_ANON_PUBLIQUE';
```
Par vos vraies valeurs :
```
const SUPABASE_URL  = 'https://abcxyz.supabase.co';
const SUPABASE_ANON = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

### Étape 4 — Déployer sur Vercel
1. Allez sur **[vercel.com](https://vercel.com)**
2. Cliquez **Add New → Project**
3. Importez ce dossier (ou glissez-déposez le ZIP)
4. Framework Preset : **Other** (pas Next.js)
5. Cliquez **Deploy**

---

## 🔐 Identifiants administrateur

| Identifiant | Mot de passe | Rôle |
|---|---|---|
| `admin` | `Admin@2025!Avl` | Administrateur Principal |
| `resp.avlekete` | `Resp@Avl2025!` | Responsable Avlékété |

> ⚠️ Changez ces mots de passe dans `index.html` avant de mettre en production (section `ADMINS`, vers la ligne 30).

---

## 🏘️ Villages couverts

Adounko · Adounko Ayignon · Agbanzin-Kpota · Agbanzin-Kpota Zounvlamè · Agouin · Ahouandji-Avlékété · Avlékété · Hio · Hio Vinawa

---

## ✨ Fonctionnalités

### Espace Jeune
- Inscription libre en 3 étapes (identité, parcours, documents)
- Upload de pièces justificatives (PDF, JPG, PNG — max 600 Ko)
- Profil modifiable (niveau, situation, profession, compétences…)
- Messagerie avec les responsables
- Lien WhatsApp direct

### Espace Administrateur (sécurisé)
- Validation des inscriptions (approuver / rejeter)
- Tableau de bord avec statistiques et graphiques
- Filtrage avancé : village, situation, profession, niveau, sexe, statut
- Messagerie avec chaque membre + accès WhatsApp
- Export CSV
- Gestion des villages
- Journal d'activité complet

---

## 🏗️ Architecture

- **Frontend** : React 18 (CDN) + Babel + Chart.js
- **Base de données** : Supabase (PostgreSQL hébergé)
- **Auth** : Admins hardcodés + hash SHA-256 pour les jeunes
- **Fichier unique** : tout dans `index.html`, aucun build nécessaire
- **Déploiement** : Vercel (site statique)

---

## 📁 Contenu du ZIP

```
repertoire-avlekete/
├── index.html     ← Application complète (ouvrir après config)
├── schema.sql     ← À exécuter une fois dans Supabase
├── vercel.json    ← Configuration Vercel (site statique)
└── README.md      ← Ce fichier
```

---

*Répertoire Numérique de la Jeunesse d'Avlékété · v2.0 · 2025*
