# 🎈 The Block Party Kit

**Turn a room full of ordinary laptops into a shared AI your community runs.**

Not a metaphor. Three friends' laptops on the same Wi-Fi, three commands,
and you have a shared model — served from the room, owned by the people in
it, with an agent on top that anyone can talk to. No cloud account. No
subscription. No company that can turn it off.

We call the first gathering a **block party**, because that's what it is:
you bring a laptop instead of a casserole.

---

## Why this exists

Every conversation about AI assumes one of two owners: *you* (one laptop,
one small model) or *a corporation* (their datacenter, your subscription).

There's a third owner nobody talks about: **a group of people.** A street.
A school. A library. A church basement. A co-op.

The pieces to make that real shipped in the open:

- [**Mesh LLM**](https://github.com/Mesh-LLM/mesh-llm) pools GPUs and memory
  across machines and exposes the result as one OpenAI-compatible API. Models
  too large for any single box get split into layer stages across peers.
- [**goose**](https://github.com/block/goose) — the open-source agent
  started at Block, now governed by the Agentic AI Foundation at the Linux
  Foundation — sits on top as the thing you actually *talk to*, and Mesh
  ships a one-command launcher for it.
- Spiral's new [**Goose Development Kit (GDK)**](https://spiral.xyz/goose/)
  means anyone can embed that agent into their own apps — kiosks, tools,
  whatever your community needs next.

This kit is the missing social layer: the instructions, scripts, and
invitation to actually do it **together**.

It's a potluck for computers: everyone brings what they have, and together the table holds something nobody could have made alone.

---

## What you need

- **3+ computers** on the same network (2 works; more is better).
  macOS or Linux, ideally with 8GB+ RAM each. GPUs help but aren't required.
- **One evening.**
- **Snacks.** Non-negotiable. It's a party.

---

## The party, step by step

### 1. The host machine — start the mesh

On the most capable machine in the room:

```bash
curl -fsSL https://raw.githubusercontent.com/Mesh-LLM/mesh-llm/main/install.sh | bash
mesh-llm serve --model Qwen3-8B-Q4_K_M --mesh-name "block-party"
```

This installs Mesh (checksum-verified release binaries), downloads the model,
starts a **private** mesh, and prints an **invite token**. Write the token on
a whiteboard. That token *is* the key to your village — only machines that
have it can join.

(Or run `./scripts/host.sh`, which does the above with guardrails and
friendlier output.)

### 2. Everyone else — join it

On each additional machine:

```bash
curl -fsSL https://raw.githubusercontent.com/Mesh-LLM/mesh-llm/main/install.sh | bash
mesh-llm serve --join <TOKEN-FROM-THE-WHITEBOARD>
```

(Or `./scripts/join.sh <TOKEN>`.)

Each machine that joins adds its memory and compute to the pool. Open the
web console at `http://localhost:3131` on any node and watch the room's
machines find each other. This is the moment. Take the photo.

### 3. Meet your librarian — put goose on top

On any machine in the mesh:

```bash
curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh | bash
mesh-llm goose
```

`mesh-llm goose` launches goose with the mesh as its inference provider —
the agent's "brain" is now the room itself. Load our recipe to give it a
job description:

```bash
goose run --recipe recipes/village-librarian.yaml
```

Now anyone at the party can ask it anything, and the thinking happens on
your neighbors' machines, not in anyone's datacenter.

### 4. Go bigger than any one box (optional)

Once you trust the setup, try a model none of your machines could run alone:

```bash
mesh-llm serve --model hf://meshllm/<repo>@<rev> --split
```

`--split` divides the model into layer stages across the room's machines.
This is the party trick: *collectively* you're running something *individually
impossible*. That sentence is the whole project.

### 5. The internet goes out? The party doesn't. (optional)

Mesh discovery normally uses Nostr relays, but it also supports pure
local-network discovery:

```bash
mesh-llm serve --model Qwen3-8B-Q4_K_M --mesh-discovery-mode mdns
```

`mdns` finds peers over the LAN with **no internet at all**. A neighborhood
mesh keeps answering questions when the fiber line doesn't. Communities in
disaster-prone areas: this section is for you.

---

## What's verified and what isn't (honesty section)

**Verified by us, 2026-07-07, on Linux x86_64, mesh-llm v0.72.2:**
the install script runs clean with checksums verified; the `mesh-llm` CLI,
`goose`, `claude`, `discover`, and `doctor` subcommands exist as documented;
`--join`, `--publish`, `--split`, `--mesh-name`, and
`--mesh-discovery-mode mdns` are real flags; the goose installer resolves at
its Linux Foundation home. Every command above is taken verbatim from, or
tested against, the upstream projects.

**Not yet verified by us:** a full multi-machine party. On purpose — it
*can't* be done by one person, and that's the point of the project. Which
brings us to:

## 🎈 Hold the first block party

Nobody has done this yet as a *community* act. Be first. Grab 2+ friends
and their laptops, follow the steps, and open an issue titled
**"Party report: <your town>"** with what worked, what broke, and (if you
want) a photo of the room. `FIRST_PARTY.md` has a checklist.

We'll keep a map. First pin wins bragging rights forever.

## Troubleshooting

`mesh-llm doctor` diagnoses most local issues. For multi-interface Linux
machines and Docker hosts, see the upstream
[MESHES.md](https://github.com/Mesh-LLM/mesh-llm/blob/main/docs/MESHES.md)
notes on `--bind-ip`. Mesh LLM is experimental distributed-systems software —
expect rough edges, report them upstream kindly.

## Credits & independence

This is an **unofficial community kit**. It stands on:
[Mesh LLM](https://github.com/Mesh-LLM/mesh-llm) (Apache-2.0),
[goose](https://github.com/block/goose) (Apache-2.0, Agentic AI Foundation /
Linux Foundation), and the [GDK](https://spiral.xyz/goose/) work from Spiral.
We're not affiliated with Block, Spiral, or the AAIF — we just think they
built the parts of something bigger than any of them has said out loud.

License: Apache-2.0. Fork it, translate it, throw a better party than ours.
