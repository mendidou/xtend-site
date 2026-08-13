#!/bin/zsh
# Publie le contenu de la BRANCHE stage sur getxtend.com/stage (preview).
# La racine du site (prod) n'est jamais touchée.
set -e
cd "$(dirname "$0")"

git checkout main >/dev/null 2>&1
rm -rf stage && mkdir stage
# contenu de la branche stage → dossier stage/
git archive stage | tar -x -C stage
rm -f stage/CNAME stage/.nojekyll stage/sync-stage.sh
# jamais indexé par Google
for f in stage/*.html; do
  sed -i '' 's/<head>/<head><meta name="robots" content="noindex">/' "$f"
done
git add stage
git commit -m "stage: sync preview" >/dev/null
git push origin main
echo "→ preview en ligne : https://getxtend.com/stage (1-2 min)"
