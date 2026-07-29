#!/bin/sh
set -e

echo "Generating environment config..."
node scripts/set-env.js

echo "Starting Angular dev server..."
npx ng serve --host 0.0.0.0 --port 4200