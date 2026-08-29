# Répertoire Numérique de la Jeunesse d'Avlékété
**Version 2.0 Production — Ouidah · Bénin**

---

## 🚀 Mise en ligne en 3 étapes (10 minutes)

### ÉTAPE 1 — Créer la base de données (Firebase, gratuit)

1. Allez sur **console.firebase.google.com**
2. Cliquez **"Ajouter un projet"** → donnez un nom → Continuer → Continuer → Créer
3. Dans le menu gauche : **Build → Realtime Database → Créer une base de données**
4. Choisissez une région → cochez **"Démarrer en mode test"** → Activer
5. **Copiez l'URL** affichée (ressemble à : `https://mon-projet-rtdb.firebaseio.com`)

---

### ÉTAPE 2 — Configurer le fichier (30 secondes)

Ouvrez `index.html` avec un éditeur de texte.
Trouvez la **ligne 24** et remplacez :

```
const FB_DB = 'https://VOTRE-PROJET.firebaseio.com';
```

Par votre vraie URL Firebase :

```
const FB_DB = 'https://mon-projet-rtdb.firebaseio.com';
```

Sauvegardez.

---

### ÉTAPE 3 — Mettre en ligne sur Vercel (2 minutes)

1. Allez sur **vercel.com** → créez un compte gratuit si besoin
2. Cliquez **"Add New → Project"**
3. Choisissez **"Browse"** et sélectionnez ce dossier (ou glissez-le)
4. Framework Preset : laissez **"Other"**
5. Cliquez **Deploy** → votre site est en ligne !

Vercel vous donne une URL publique du type : `https://repertoire-avlekete.vercel.app`

---

## 🔐 Identifiants administrateur

| Identifiant | Mot de passe |
|---|---|
| `admin` | `Admin@2025!Avl` |
| `resp.avlekete` | `Resp@Avl2025!` |

> ⚠️ Pour changer ces mots de passe : ouvrez `index.html`, cherchez `const ADMINS` (vers la ligne 30) et modifiez les valeurs.

---

## 📌 Pour rendre la base permanente (après 30 jours)

Dans la console Firebase → Realtime Database → Règles, collez :
```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```
Puis cliquez Publier.

---

## 📁 Contenu

| Fichier | Rôle |
|---|---|
| `index.html` | L'application complète |
| `vercel.json` | Configuration Vercel (site statique) |
| `README.md` | Ce guide |

---
*Répertoire de la Jeunesse d'Avlékété · v2.0 · 2025*
