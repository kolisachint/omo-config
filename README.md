# OMO Config — Portable Oh-My-Openagent Profiles

A portable, reusable collection of [oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent) profiles for [OpenCode](https://opencode.ai/). Switch between premium, daily, fast, and free-tier combinations with a single command.

## Philosophy

- **Premium when it matters** — Use best models (Kimi K2.5 max, GLM-5 xhigh, GPT-5.4) for architecture and deep reasoning
- **Daily for routine work** — GPT-5.4-mini handles 90% of tasks at a fraction of the cost
- **Fast for iterations** — Codex Spark gives you speed when you just need to move
- **Free when broke** — Zero-cost models so you never get blocked by quotas

## Profiles

| Profile | Cost | Primary Models | Best For |
|---------|------|----------------|----------|
| `omo-go` | $$$$ | Kimi K2.5 max, GLM-5 xhigh, MiniMax highspeed | Complex architecture, max quality |
| `omo-codex` | $$$$ | GPT-5.4 high/xhigh, GPT-5.4-mini | OpenAI-first consistency |
| `omo-daily` | $$ | GPT-5.4-mini primary, Kimi fallback, nano quick | Everyday coding (recommended) |
| `omo-fast` | $ | GPT-5.3-codex-spark, GPT-5-nano | Rapid iterations, speed first |
| `omo-free` | FREE | Kimi-free, Big Pickle, GPT-5-nano | Zero cost, quota exhausted |

## Quick Start

### Option 1: Clone & Setup (recommended)

```bash
git clone <this-repo> ~/.config/omo-config
cd ~/.config/omo-config
npm run setup
```

This installs:
- Default `omo-daily` profile to `~/.config/opencode/oh-my-openagent.json`
- The `omo` CLI binary to your PATH

### Option 2: One-liner Install

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/omo-config/main/scripts/setup.js | node
```

### Option 3: Copy Manually

```bash
cp profiles/omo-daily.json ~/.config/opencode/oh-my-openagent.json
```

## Usage

```bash
# List all profiles
omo list

# Switch profile
omo omo-daily
omo omo-fast
omo omo-go
omo omo-free

# Check current profile
omo status

# Compare all profiles side-by-side
omo compare

# Full setup
omo setup
```

## NPM (optional)

If you want to publish or install via npm:

```bash
# Install globally
npm install -g @sachinkoli/omo-config

# Or use via npx
npx @sachinkoli/omo-config omo-daily
```

## Repo Structure

```
.
├── bin/omo                  # CLI profile switcher
├── profiles/
│   ├── omo-go.json          # Premium opencode-go
│   ├── omo-codex.json       # Premium OpenAI
│   ├── omo-daily.json       # Balanced daily driver
│   ├── omo-fast.json        # Fast coding mode
│   └── omo-free.json        # Free tier only
├── scripts/setup.js         # One-command installer
├── package.json
└── README.md
```

## Agent Mapping Reference

| Agent | Role | omo-go | omo-daily | omo-fast | omo-free |
|-------|------|--------|-----------|----------|----------|
| sisyphus | Orchestrator | Kimi K2.5 max | GPT-5.4-mini | Codex Spark | Kimi-free |
| oracle | Deep reasoning | GLM-5 xhigh | GPT-5.4 med | GPT-5.4-mini | Big Pickle |
| prometheus | Planning | Kimi K2.5 high | GPT-5.4-mini | Codex Spark | Big Pickle |
| metis | Pre-planning | Kimi K2.5 high | GPT-5.4-mini | Codex Spark | Big Pickle |
| momus | Review | GPT-5.4 xhigh | GPT-5.4 high | GPT-5.4-mini | Big Pickle |
| atlas | Build | Kimi K2.5 high | GPT-5.4-mini | Codex Spark | Big Pickle |
| librarian | Search | MiniMax highspeed | MiniMax highspeed | GPT-5-nano | GPT-5-nano |
| explore | Codebase search | MiniMax highspeed | MiniMax highspeed | GPT-5-nano | GPT-5-nano |

## License

MIT
