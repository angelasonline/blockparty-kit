#!/usr/bin/env bash
# 🎈 Block Party Kit — join.sh
# Run this on every other machine in the room:
#   ./join.sh <INVITE-TOKEN-FROM-THE-WHITEBOARD>
#
# Your machine's memory and compute join the pool. Verified against
# mesh-llm v0.72.2 (Linux x86_64) on 2026-07-07.

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <invite-token>"
  echo "Ask the host — the token was printed when they started the mesh."
  exit 1
fi
TOKEN="$1"

echo "🎈 Block Party Kit — joining the mesh"

if ! command -v mesh-llm >/dev/null 2>&1; then
  if [ -x "$HOME/.local/bin/mesh-llm" ]; then
    export PATH="$HOME/.local/bin:$PATH"
  else
    echo "→ Installing mesh-llm (official installer, checksum-verified)..."
    curl -fsSL https://raw.githubusercontent.com/Mesh-LLM/mesh-llm/main/install.sh | bash
    export PATH="$HOME/.local/bin:$PATH"
  fi
fi
echo "→ $(mesh-llm --version)"

# Low-spec laptop? Join as an API-only client instead (uses the mesh without
# serving models):   mesh-llm client --join "$TOKEN"
echo "→ Joining as a serving node. Console: http://localhost:3131"
exec mesh-llm serve --join "$TOKEN"
