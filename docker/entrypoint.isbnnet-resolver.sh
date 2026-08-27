#!/bin/sh
set -e

echo "Starting ISBNnet Resolver dev server..."
npx wrangler dev --port 8789 --ip 0.0.0.0
