#!/bin/sh
set -e

echo "Generating environment config..."
node scripts/set-env.js

# The Angular dev server proxies /api/cover (see proxy.conf.json) to a
# Cloudflare Pages Functions dev server on :8788, which runs functions/api/cover.ts
# (the image proxy/CDN-cache layer for Google Books/Open Library/ISBNnet covers).
# `wrangler pages dev` needs a static asset directory to serve alongside the
# functions, so build one once at container startup — it only has to exist,
# it doesn't need to be kept in sync with live edits: `functions/` is read
# live off disk on every request, independent of this build.
echo "Building static assets for Pages Functions dev server..."
npx ng build --configuration smoke

echo "Starting Cloudflare Pages Functions dev server (image/cover proxy) on :8788..."
npx wrangler pages dev dist/unibooks-fe/browser --port 8788 --ip 0.0.0.0 &

echo "Starting Angular dev server..."
exec npx ng serve --host 0.0.0.0 --port 4200 --proxy-config proxy.conf.json