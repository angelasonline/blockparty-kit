#!/usr/bin/env bash
# 🎈 Block Party Kit — host.sh
# Run this on the most capable machine in the room. It installs Mesh LLM
# (if needed), starts a private mesh named "block-party", and prints the
# invite token your neighbors will use to join.
#
# Verified against mesh-llm v0.72.2 (Linux x86_64) on 2026-07-07.

set -euo pipefail

MODEL="${BLOCKPARTY_MODEL:-Qwen3-8B-Q4_K_M}"
MESH_NAME="${BLOCKPARTY_NAME:-block-party}"
DISCOVERY="${BLOCKPARTY_DISCOVERY:-nostr}"   # set to "mdns" for no-internet mode

echo "🎈 Block Party Kit — host"
echo "   model: $MODEL   mesh name: $MESH_NAME   discovery: $DISCOVERY"
echo

# 1. Install mesh-llm if it isn't already on this machine
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

# 2. Sanity-check the machine
mesh-llm doctor || echo "⚠ doctor reported issues above — the party may still work; read them."

# 3. Start the private mesh.
#    This downloads the model on first run (several GB — do it before guests
#    arrive), starts the API on :9337 and the console on :3131, and prints
#    an INVITE TOKEN. Write that token on the whiteboard.
echo
echo "→ Starting the mesh. Watch for the invite token below."
echo "  Console: http://localhost:3131   API: http://localhost:9337/v1"
echo
exec mesh-llm serve --model "$MODEL" --mesh-name "$MESH_NAME" \
  --mesh-discovery-mode "$DISCOVERY"
