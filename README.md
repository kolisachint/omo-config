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
| **OpenAI (codex)** | GPT-5.5 + GPT-5.4 | GPT-5.4 | GPT-5.4-mini + Spark | GPT-5.4-mini + Spark |
| **OpenCode Go** | GLM-5.1 + Kimi K2.6 | Kimi K2.5 + DeepSeek V4 Pro | MiniMax M2.5 + DeepSeek V4 Flash | Kimi-free + Big Pickle |
| **GitHub Copilot** | GPT-5.5 + Claude Opus 4.7 | GPT-5.4 + Sonnet 4.6 | GPT-5.4-mini + GPT-5.2 | GPT-5 mini + GPT-4o |
| **Anthropic (claude)** | Claude Opus 4 + Sonnet 4 | Claude Sonnet 4 | Claude Haiku 3.5 | Nano fallback |
| **Google (gemini)** | Gemini 2.5 Pro | Gemini 2.5 Flash | Gemini 2.0 Flash | Gemini 2.0 Flash |

## Installation

Choose one of the three methods below. All methods work on **macOS** and **Windows**.

> **Windows users:** If you have [WSL](https://learn.microsoft.com/windows/wsl/) or Git Bash, use the **macOS / Linux** instructions. Otherwise, use the **Windows (PowerShell)** instructions below.

---

### 1. One-Command Install (Recommended)

The fastest way. No git or npm required.

<details open>
<summary><b>macOS / Linux / WSL / Git Bash</b></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/kolisachint/omo-config/main/install.sh | bash
```

With a custom default profile:

```bash
curl -fsSL https://raw.githubusercontent.com/kolisachint/omo-config/main/install.sh | bash -s -- opencodego-daily
```

</details>

<details>
<summary><b>Windows (PowerShell)</b></summary>

```powershell
irm https://raw.githubusercontent.com/kolisachint/omo-config/main/install.ps1 | iex
```

With a custom default profile:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/kolisachint/omo-config/main/install.ps1))) opencodego-daily
```

</details>

---

### 2. Git Repo Install

Clone the repo and run the installer. Great if you want to stay up to date with `git pull`.

<details open>
<summary><b>macOS / Linux / WSL / Git Bash</b></summary>

```bash
# Fresh install
git clone https://github.com/kolisachint/omo-config.git ~/.config/omo-config

# Or update existing install
cd ~/.config/omo-config && git pull origin main

# Run installer (defaults to codex-daily)
cd ~/.config/omo-config
./install.sh

# Or pick a different default profile
./install.sh gemini-daily
```

</details>

<details>
<summary><b>Windows (PowerShell)</b></summary>

```powershell
# Fresh install
git clone https://github.com/kolisachint/omo-config.git $env:USERPROFILE\.config\omo-config

# Or update existing install
cd $env:USERPROFILE\.config\omo-config
git pull origin main

# Run installer (defaults to codex-daily)
cd $env:USERPROFILE\.config\omo-config
.\install.ps1

# Or pick a different default profile
.\install.ps1 gemini-daily
```

</details>

---

### 3. Manual Install

If you prefer full control over every step.

<details open>
<summary><b>macOS / Linux / WSL / Git Bash</b></summary>

```bash
# 1. Create config directory
mkdir -p ~/.config/opencode

# 2. Copy your chosen profile
cp profiles/codex-daily.json ~/.config/opencode/oh-my-openagent.json

# 3. (Optional) Add the omo CLI to your PATH
ln -sf "$(pwd)/bin/omo" ~/.local/bin/omo

# 4. Verify
omo status
```

</details>

<details>
<summary><b>Windows (PowerShell)</b></summary>

```powershell
# 1. Create config directory
New-Item -ItemType Directory -Path "$env:USERPROFILE\.config\opencode" -Force

# 2. Copy your chosen profile
Copy-Item profiles\codex-daily.json "$env:USERPROFILE\.config\opencode\oh-my-openagent.json"

# 3. (Optional) Add the omo CLI to your PATH
$repoPath = (Get-Location).Path
$binDir = "$env:USERPROFILE\bin"
New-Item -ItemType Directory -Path $binDir -Force

# CMD wrapper
Set-Content -Path "$binDir\omo.cmd" -Value "@node `"$repoPath\bin\omo`" %*"

# PowerShell wrapper
Set-Content -Path "$binDir\omo.ps1" -Value "node `'$repoPath\bin\omo`' `$args"

# Add to PATH
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$binDir", "User")

# 4. Verify (restart terminal first if PATH was just updated)
node bin\omo status
```

</details>

### Switch Profiles

> On Windows, use `omo` directly in PowerShell or CMD (if in PATH), or run `node bin\omo` from the repo root.

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
├── install.sh                   # POSIX shell installer (macOS / Linux / WSL / Git Bash)
├── install.ps1                  # PowerShell installer (Windows)
├── scripts/setup.js             # Node.js setup script (npm run setup)
├── package.json
└── README.md
```

## Model Notes

- **OpenAI (codex)** `-free` is not actually free — Codex has no zero-cost tier. It uses the cheapest Codex models (`gpt-5.4-mini` / `gpt-5.3-codex-spark`).
- **GitHub Copilot** requires an active subscription. On Enterprise, `gpt-5-mini` and `gpt-4o` have a 0× multiplier (effectively free). The `-free` profile uses these.
- **Claude** API is not free. The `-free` profiles use OpenAI nano/Big Pickle as fallback.
- **Gemini** has a generous free tier, so `gemini-free` and `gemini-fast` can be nearly identical.
- **OpenCode Go** free tier uses `opencode/kimi-k2.5-free` and `opencode/big-pickle`.
- Adjust model names in JSON files if your OpenCode setup uses different identifiers.

## Model References

- **OpenAI Codex:** [developers.openai.com/codex/models](https://developers.openai.com/codex/models)
- **OpenCode Go:** [opencode.ai/docs/go](https://opencode.ai/docs/go)
- **GitHub Copilot Enterprise:** [docs.github.com/copilot/reference/ai-models/supported-models](https://docs.github.com/en/enterprise-cloud@latest/copilot/reference/ai-models/supported-models)

## Changelog

### 2026-05-03
- **Fix:** `scripts/setup.js` default profile changed from `omo-daily` (non-existent) to `codex-daily` to match available provider-specific profiles.

## License

MIT
