#!/usr/bin/env bash
# 🎈 Block Party Kit — librarian.sh
# Run on any machine already in the mesh. Installs goose (the open-source
# agent from Block / Agentic AI Foundation) if needed, then launches it with
# the room's mesh as its brain, wearing the Village Librarian recipe.

set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"

KIT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
RECIPE="$KIT_DIR/recipes/village-librarian.yaml"

echo "🎈 Block Party Kit — waking the librarian"

if ! command -v goose >/dev/null 2>&1; then
  echo "→ Installing goose CLI (official installer)..."
  curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh | bash
  export PATH="$HOME/.local/bin:$PATH"
fi

if ! command -v mesh-llm >/dev/null 2>&1; then
  echo "✗ mesh-llm not found. Run host.sh or join.sh first." >&2
  exit 1
fi

# `mesh-llm goose` launches goose with mesh-llm as the inference provider.
# If no mesh is running locally it auto-joins as a client. To pin a model:
#   mesh-llm goose --model <id-from: curl -s http://localhost:9337/v1/models>
echo "→ Launching goose against the mesh (the room is now the brain)."
echo
echo "  Once goose is up and configured for the mesh provider, load the"
echo "  librarian's job description in a second terminal with:"
echo "    goose run --recipe \"$RECIPE\" --interactive"
echo
exec mesh-llm goose
