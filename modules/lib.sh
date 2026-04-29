#!/usr/bin/env bash
# modules/lib.sh — sourced by every module; never executed directly

[[ -n "${_LIB_SH_LOADED:-}" ]] && return 0
_LIB_SH_LOADED=1

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# --- Logging ---
log()  { printf '[setup] %s\n' "$*"; }
warn() { printf '[setup] WARNING: %s\n' "$*" >&2; }
die()  { printf '[setup] ERROR: %s\n' "$*" >&2; exit 1; }

# --- OS detection ---
detect_os() {
    case "$(uname -s)" in
        Darwin) echo macos ;;
        Linux)
            if   [[ -f /etc/alpine-release ]]; then echo alpine
            elif grep -qi "amazon linux" /etc/system-release 2>/dev/null; then echo amzn
            elif [[ -f /etc/debian_version ]]; then echo debian
            elif [[ -f /etc/redhat-release ]]; then echo rhel
            else echo linux-unknown
            fi ;;
        *) echo unknown ;;
    esac
}
OS="$(detect_os)"
export OS

# --- Package manager dispatch ---
_sudo() { if [[ "$(id -u)" == "0" ]]; then "$@"; else sudo "$@"; fi; }

pkg_install() {
    case "$OS" in
        macos)        brew install "$@" ;;
        debian)       _sudo apt-get install -y "$@" ;;
        rhel)         _sudo yum install -y "$@" ;;
        amzn)         _sudo yum install -y "$@" ;;
        alpine)       apk add --no-cache "$@" ;;
        *) warn "unknown OS ($OS), skipping: pkg_install $*" ;;
    esac
}

pkg_update() {
    case "$OS" in
        macos)   brew update ;;
        debian)  _sudo apt-get update ;;
        rhel)    _sudo yum update -y ;;
        amzn)    _sudo yum update -y ;;
        alpine)  apk update ;;
        *) warn "unknown OS ($OS), skipping pkg_update" ;;
    esac
}

# --- Idempotency helpers ---
command_exists()    { command -v "$1" &>/dev/null; }
source_if_exists()  { [[ -f "$1" ]] && source "$1"; }

# append_if_missing <file> <line>
append_if_missing() {
    grep -qF "$2" "$1" 2>/dev/null || echo "$2" >> "$1"
}

# safe_symlink <src> <dst> — backs up existing non-symlink before linking
safe_symlink() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        mv "$dst" "${dst}.bak.$(date +%s)"
        warn "backed up existing $dst"
    fi
    ln -sf "$src" "$dst"
}
