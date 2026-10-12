#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
npx -y mcp-excalidraw-server start
echo "Canvas: http://127.0.0.1:3000"
echo "Open that URL in a browser to watch live AI drawings."
