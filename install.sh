#!/bin/sh
# OMO Config — One-Command Installer
# Supports: curl | bash, git clone, or manual run

set -e

REPO_URL="https://github.com/kolisachint/omo-config.git"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.config/omo-config}"
CONFIG_DIR="$HOME/.config/opencode"
DEFAULT_PROFILE="${1:-codex-daily}"

# Colors (safe for sh)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info()  { printf "${BLUE}ℹ %s${NC}\n" "$1"; }
ok()    { printf "${GREEN}✅ %s${NC}\n" "$1"; }
warn()  { printf "${YELLOW}⚠ %s${NC}\n" "$1"; }
err()   { printf "${RED}❌ %s${NC}\n" "$1"; }

# Detect if we're running from a cloned repo or from curl
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$SCRIPT_DIR/profiles/codex-daily.json" ]; then
    REPO_ROOT="$SCRIPT_DIR"
    FROM_CLONE=1
else
    REPO_ROOT="$INSTALL_DIR"
    FROM_CLONE=0
fi

ensure_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        info "Created: $1"
    fi
}

clone_repo() {
    if [ -d "$REPO_ROOT/.git" ]; then
        info "Repo already exists at $REPO_ROOT"
        cd "$REPO_ROOT"
        git pull origin main 2>/dev/null || warn "Could not pull updates"
    else
        info "Cloning $REPO_URL → $REPO_ROOT"
        git clone --depth 1 "$REPO_URL" "$REPO_ROOT"
        ok "Cloned successfully"
    fi
}

backup_if_exists() {
    if [ -f "$1" ]; then
        backup="$1.backup-$(date +%Y%m%d-%H%M%S)"
        cp "$1" "$backup"
        ok "Backup created: $backup"
    fi
}

install_profile() {
    profile="$1"
    profile_file="$REPO_ROOT/profiles/${profile}.json"
    if [ ! -f "$profile_file" ]; then
        err "Profile not found: $profile_file"
        err "Run './bin/omo list' to see available profiles."
        exit 1
    fi
    ensure_dir "$CONFIG_DIR"
    backup_if_exists "$CONFIG_DIR/oh-my-openagent.json"
    cp "$profile_file" "$CONFIG_DIR/oh-my-openagent.json"
    ok "Installed profile: $profile"
}

install_bin() {
    bin_src="$REPO_ROOT/bin/omo"
    if [ ! -f "$bin_src" ]; then
        warn "omo binary not found at $bin_src"
        return
    fi

    # Check if already in PATH
    if command -v omo >/dev/null 2>&1; then
        ok "omo is already in PATH: $(command -v omo)"
        return
    fi

    # Try common bin directories
    for bin_dir in "$HOME/.local/bin" "$HOME/bin"; do
        ensure_dir "$bin_dir"
        if echo "$PATH" | tr ':' '\n' | grep -qx "$bin_dir"; then
            ln -sf "$bin_src" "$bin_dir/omo"
            ok "Linked omo → $bin_dir/omo"
            return
        fi
    done

    # Fallback: symlink anyway to ~/.local/bin and warn
    ensure_dir "$HOME/.local/bin"
    ln -sf "$bin_src" "$HOME/.local/bin/omo"
    warn "Linked omo → $HOME/.local/bin/omo"
    warn "Make sure ~/.local/bin is in your PATH:"
    warn '  export PATH="$HOME/.local/bin:$PATH"'
}

main() {
    printf "\n🔧 OMO Config Installer\n\n"

    if [ "$FROM_CLONE" -eq 0 ]; then
        clone_repo
    fi

    install_profile "$DEFAULT_PROFILE"
    install_bin

    printf "\n🎉 Installation complete!\n\n"
    printf "   Config:   %s\n" "$CONFIG_DIR/oh-my-openagent.json"
    printf "   Profile:  %s\n" "$DEFAULT_PROFILE"
    printf "   Repo:     %s\n\n" "$REPO_ROOT"
    printf "Next steps:\n"
    printf "  omo list              - List all profiles\n"
    printf "  omo <profile>         - Switch profile\n"
    printf "  omo status            - Check current profile\n"
    printf "  omo compare           - Compare providers\n\n"
}

main
