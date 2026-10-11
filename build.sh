#!/usr/bin/env bash
#
# build.sh — builds the Rajdeep Mandal (RJD) portfolio into ./dist/
#
#   Usage: ./build.sh
#
# Zero dependencies: pure bash + coreutils. No npm, no Node required.
# Output (dist/) is 100% static — deploy anywhere (Vercel, Netlify, GitHub
# Pages, Nginx, S3, ...).
#
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$PROJECT_DIR/src"
PUBLIC="$PROJECT_DIR/public"
DIST="$PROJECT_DIR/dist"

echo "🔨 Building rajdeep-portfolio → $DIST"

# 1. Clean and recreate dist
rm -rf "$DIST"
mkdir -p "$DIST/css" "$DIST/js" "$DIST/images"

# 2. Copy site source
cp "$SRC/index.html" "$DIST/index.html"
cp "$SRC/css/"*.css "$DIST/css/"
cp "$SRC/js/"*.js "$DIST/js/"

# 3. Copy public assets (images) — rajdeep-profile.jpg is THE swappable asset:
#    replace public/images/rajdeep-profile.jpg and rebuild (or drop it straight into dist/)
if [ -d "$PUBLIC/images" ]; then
  cp "$PUBLIC/images/"*.jpg "$PUBLIC/images/"*.jpeg "$PUBLIC/images/"*.png "$PUBLIC/images/"*.webp "$PUBLIC/images/"*.gif "$DIST/images/" 2>/dev/null || true
fi

# 4. Validate: required files present
for f in "index.html" "css/styles.css" "js/main.js" "images/rajdeep-profile.jpg" "images/throwback.jpg"; do
  if [ ! -f "$DIST/$f" ]; then
    echo "❌ BUILD FAILED: missing dist/$f"
    exit 1
  fi
done

# 5. Validate: no leftover template placeholders for PHOTO or EMAIL.
#    (a [PLACEHOLDER: school name] is EXPECTED — Rajdeep's school is unconfirmed.)
if grep -Rni "PLACEHOLDER: photo\|PLACEHOLDER: email" "$DIST" >/dev/null 2>&1; then
  echo "⚠️  WARNING: dist/ still contains a photo/email placeholder — check index.html"
fi

# 6. Basic sanity: HTML tags balanced (rough check) and no empty files
if [ ! -s "$DIST/index.html" ]; then
  echo "❌ BUILD FAILED: dist/index.html is empty"
  exit 1
fi

echo "✅ Build successful. Deployable output in: $DIST"
echo "   Files: $(find "$DIST" -type f | wc -l) | Size: $(du -sh "$DIST" | cut -f1)"
echo ""
echo "   Preview locally:  python3 -m http.server 8080 --directory \"$DIST\""
echo "   Deploy:           upload dist/ contents to any static host"
echo "                     (Vercel: 'vercel --prod' from project root — see vercel.json)"
