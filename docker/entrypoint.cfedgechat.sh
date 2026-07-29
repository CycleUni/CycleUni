#!/bin/sh
set -e

echo "Generating .dev.vars from environment..."
cat > /app/.dev.vars << EOF
EDGE_CHAT_JWT_SECRET=${EDGE_CHAT_JWT_SECRET}
DJANGO_WEBHOOK_URL=${DJANGO_WEBHOOK_URL:-http://backend:8000/api/v1/messaging/webhook/edge-chat/}
DJANGO_WEBHOOK_SECRET=${DJANGO_WEBHOOK_SECRET}
APP_ORIGINS=${APP_ORIGINS:-http://localhost:4200,http://127.0.0.1:4200}
ENVIRONMENT=${ENVIRONMENT:-development}
EOF

echo "Starting CFEdgeChat dev server..."
npx wrangler dev --port 8787 --ip 0.0.0.0