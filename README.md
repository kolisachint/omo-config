# OMO Config — Portable Oh-My-Openagent Profiles

A portable, reusable collection of [oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent) profiles for [OpenCode](https://opencode.ai/). Switch between provider-specific model tiers with a single command.

## Philosophy

Pick your provider, pick your tier:

- **premium** — Best models for architecture, deep reasoning, max quality
- **daily** — Balanced quality and cost for everyday coding
- **fast** — Speed first, lowest latency for rapid iterations
- **free** — Zero cost, never get blocked by quotas

## Providers & Profiles

| Provider | premium | daily | fast | free |
|----------|---------|-------|------|------|
| **OpenAI (codex)** | GPT-5.4 high/xhigh | GPT-5.4-mini | GPT-5.3-codex-spark | GPT-5-nano |
| **OpenCode Go** | Kimi K2.5 max + GLM-5 | Kimi K2.5 + MiniMax | MiniMax + DeepSeek | Kimi-free + Big Pickle |
| **GitHub Copilot** | Claude Sonnet 4 + GPT-4o | GPT-4o | o3-mini | Nano fallback |
| **Anthropic (claude)** | Claude Opus 4 + Sonnet 4 | Claude Sonnet 4 | Claude Haiku 3.5 | Nano fallback |
| **Google (gemini)** | Gemini 2.5 Pro | Gemini 2.5 Flash | Gemini 2.0 Flash | Gemini 2.0 Flash |

## Quick Start

### Clone & Setup

```bash
git clone https://github.com/kolisachint/omo-config.git ~/.config/omo-config
cd ~/.config/omo-config
npm run setup
```

### Switch Profiles

```bash
# List all profiles grouped by provider
omo list

# Switch to any profile
omo codex-daily
omo opencodego-fast
omo githubcopilot-premium
omo claude-daily
omo gemini-free

# Check current profile
omo status

# Compare all providers side-by-side
omo compare

# Compare specific providers
omo compare codex claude
```

## NPM (optional)

```bash
npm install -g
# or
npx omo-config codex-daily
```

## Repo Structure

```
.
├── bin/omo                      # CLI profile switcher
├── profiles/
│   ├── codex-premium.json       # OpenAI max quality
│   ├── codex-daily.json         # OpenAI balanced
│   ├── codex-fast.json          # OpenAI speed
│   ├── codex-free.json          # OpenAI zero cost
│   ├── opencodego-premium.json  # OpenCode Go max quality
│   ├── opencodego-daily.json    # OpenCode Go balanced
│   ├── opencodego-fast.json     # OpenCode Go speed
│   ├── opencodego-free.json     # OpenCode Go zero cost
│   ├── githubcopilot-premium.json
│   ├── githubcopilot-daily.json
│   ├── githubcopilot-fast.json
│   ├── githubcopilot-free.json
│   ├── claude-premium.json
│   ├── claude-daily.json
│   ├── claude-fast.json
│   ├── claude-free.json
│   ├── gemini-premium.json
│   ├── gemini-daily.json
│   ├── gemini-fast.json
│   └── gemini-free.json
├── scripts/setup.js             # One-command installer
├── package.json
└── README.md
```

## Model Notes

- **GitHub Copilot** models require an active Copilot subscription. The `-free` profiles fall back to OpenAI nano/Big Pickle when Copilot quota is exhausted.
- **Claude** API is not free. The `-free` profiles use OpenAI nano/Big Pickle as fallback.
- **Gemini** has a generous free tier, so `gemini-free` and `gemini-fast` can be nearly identical.
- **OpenCode Go** free tier uses `opencode/kimi-k2.5-free` and `opencode/big-pickle`.
- Adjust model names in JSON files if your OpenCode setup uses different identifiers.

## License

MIT
