#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
npx -y mcp-excalidraw-server stop
