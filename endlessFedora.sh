#!/usr/bin/env bash

# ============================================================
#  ENDLESS FEDORA
#  Fully Safe – Purely Cosmetic
# ============================================================

# --- Colors ---
RED="\e[31m"; GREEN="\e[32m"; YELLOW="\e[33m"; BLUE="\e[34m"
MAGENTA="\e[35m"; CYAN="\e[36m"; GRAY="\e[90m"; RESET="\e[0m"
BRIGHT="\e[1m"; WHITE="\e[97m"

# --- Fedora-themed package/rpm data ---
PREFIXES=(fedora system kernel selinux gnome gtk pipewire mesa rpmfusion plasma qt kde libvirt podman)
SUFFIXES=(core utils libs common driver module plugin tools runtime daemon)
REPOS=(
    "Fedora - BaseOS"
    "Fedora - AppStream"
    "Fedora - Updates"
    "RPM Fusion Free"
    "RPM Fusion Non-Free"
)
EDITIONS=(39 40 41 rawhide)

# --- Helpers ---
rand() { shuf -i "$1"-"$2" -n 1; }

rand_item() {
    local arr=("$@")
    echo "${arr[$(rand 0 $((${#arr[@]} - 1)))]}"
}

pkg_name() { echo "$(rand_item "${PREFIXES[@]}")-$(rand_item "${SUFFIXES[@]}")"; }

rpm_version() { echo "$(rand 1 5).$(rand 0 30).$(rand 0 200)-$(rand 1 5).fc$(rand_item "${EDITIONS[@]}")"; }

pause() { sleep "$(awk -v min=$1 -v max=$2 'BEGIN{srand(); print min+rand()*(max-min)}')"; }

progress_bar() {
    local label="$1"
    local width=38

    echo -ne "\e[?25l"  # hide cursor

    for i in $(seq 1 $(rand 95 100)); do
        filled=$((i * width / 100))
        empty=$((width - filled))

        printf "\r${BRIGHT}%s${RESET} " "$label"
        printf "${BLUE}"; printf "█%.0s" $(seq 1 $filled)
        printf "${GRAY}"; printf "░%.0s" $(seq 1 $empty)
        printf "${RESET} ${GREEN}%d%%%s" "$i" "$RESET"
        pause 0.01 0.04
    done

    echo -ne "\r${BRIGHT}$label${RESET} "
    printf "${BLUE}"; printf "█%.0s" $(seq 1 $width)
    echo -e " ${GREEN}100%${RESET}"

    echo -ne "\e[?25h"
}

print_prompt() {
    echo -e "${BLUE}[fedora@$(hostname) ~]${RESET}$ $1"
    pause 0.12 0.3
}

# ------------------------------------------------------------
#  DNF UPDATE SIMULATION
# ------------------------------------------------------------
dnf_update() {
    print_prompt "sudo dnf check-update"

    for i in $(seq 1 $(rand 10 30)); do
        repo=$(rand_item "${REPOS[@]}")
        pkg=$(pkg_name)
        ver=$(rpm_version)
        echo -e "${CYAN}${pkg}${RESET}.${YELLOW}x86_64${RESET} ${VER} ${GRAY}$repo${RESET}"
        pause 0.03 0.12
    done

    echo -e "${GRAY}Last metadata expiration check: $(rand 1 59) minutes ago.${RESET}"
    echo -e "${GREEN}Done.${RESET}"
}

# ------------------------------------------------------------
#  DNF INSTALL SIMULATION
# ------------------------------------------------------------
dnf_install() {
    local count=$(rand 3 10)
    local pkgs=()

    for _ in $(seq 1 $count); do pkgs+=("$(pkg_name)"); done

    print_prompt "sudo dnf install -y ${pkgs[*]}"

    echo -e "${GRAY}Last metadata expiration check: $(rand 1 59) minutes ago.${RESET}"
    echo "Dependencies resolved."
    echo "================================================================================"
    for p in "${pkgs[@]}"; do
        echo "${p}.x86_64 $(rpm_version)"
    done
    echo "================================================================================"
    echo "Total size: $(rand 5 200) M"
    echo "Installed size: $(rand 20 500) M"
    echo "Downloading Packages:"
    pause 0.5 1

    for p in "${pkgs[@]}"; do
        echo -e "${BLUE}Downloading${RESET} ${p}.rpm [${YELLOW}$(rand 100 5000) kB${RESET}]"
        pause 0.03 0.18
    done

    progress_bar "Running transaction check"
    progress_bar "Running transaction"
    pause 0.2 0.5

    for p in "${pkgs[@]}"; do
        echo "  Installing  : ${p}  $(rpm_version)"
        pause 0.02 0.15
        echo "  Running scriptlet: ${p}"
        pause 0.03 0.18
    done

    echo "Verifying..."
    pause 0.2 0.5
    for p in "${pkgs[@]}"; do
        echo "  Verifying   : ${p}"
        pause 0.02 0.1
    done
    echo -e "${GREEN}Installed:${RESET} ${pkgs[*]}"
}

# ------------------------------------------------------------
#  STARTUP BANNER
# ------------------------------------------------------------
clear
echo -e "${BLUE}Fedora Fake Installer Simulation${RESET}"
echo -e "${GREEN}User:${RESET} $USER"
echo -e "${GREEN}Host:${RESET} $(hostname)"
echo -e "${GRAY}System Ready.${RESET}"
echo

trap "echo -e \"\n${RED}ABORTED BY USER${RESET}\"; tput cnorm; exit" SIGINT

# ------------------------------------------------------------
#  MAIN LOOP
# ------------------------------------------------------------
while true; do
    if (( $(rand 1 100) > 55 )); then
        dnf_update
    else
        dnf_install
    fi
    pause 0.4 1.2
done
