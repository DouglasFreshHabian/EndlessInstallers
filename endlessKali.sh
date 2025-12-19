#!/usr/bin/env bash

# ============================================================
#  ENDLESS KALI — with hashcat/aircrack/starkiller
#  Fully Safe – Purely Cosmetic
# ============================================================

# --- Colors ---
RED="\e[31m"; GREEN="\e[32m"; YELLOW="\e[33m"; BLUE="\e[34m"
MAGENTA="\e[35m"; CYAN="\e[36m"; GRAY="\e[90m"; RESET="\e[0m"
BRIGHT="\e[1m"; WHITE="\e[97m"

# --- Data lists (Kali-flavored) ---
PREFIXES=(kali exploit metasploit sec pentest net wireless forensics osint crypto fuzz recon)
SUFFIXES=(tools core suite utils scanner agent module payload driver support)
REPOS=(
    "http://http.kali.org/kali"
    "http://kali.download/kali"
)
DISTROS=(kali-rolling)
SECTIONS=(main contrib non-free non-free-firmware)

SPECIAL_TOOLS=(hashcat aircrack-ng starkiller)

# --- Helpers ---
rand() { shuf -i "$1"-"$2" -n 1; }

rand_item() {
    local arr=("$@")
    echo "${arr[$(rand 0 $((${#arr[@]} - 1)))]}"
}

pkg_name() { echo "$(rand_item "${PREFIXES[@]}")-$(rand_item "${SUFFIXES[@]}")"; }
version() { echo "$(rand 0 4).$(rand 0 20).$(rand 0 100)-kali$(rand 1 3)"; }

pause() { sleep "$(awk -v min=$1 -v max=$2 'BEGIN{srand(); print min+rand()*(max-min)}')"; }

progress_bar() {
    local label="$1"
    local width=38

    echo -ne "\e[?25l"  # hide cursor

    for i in $(seq 0 $(rand 95 100)); do
        filled=$((i * width / 100))
        empty=$((width - filled))

        printf "\r${BRIGHT}%s${RESET} " "$label"
        printf "${CYAN}"; printf "█%.0s" $(seq 1 $filled)
        printf "${GRAY}"; printf "░%.0s" $(seq 1 $empty)
        printf "${RESET} ${GREEN}%d%%%s" "$i" "$RESET"

        pause 0.01 0.05
    done

    echo -ne "\r${BRIGHT}$label${RESET} "
    printf "█%.0s" $(seq 1 $width)
    echo -e " ${GREEN}100%${RESET}"

    echo -ne "\e[?25h" # show cursor
}

print_prompt() {
    echo -e "${BLUE}┌──(${CYAN}kali${BLUE})-[${CYAN}~${BLUE}]"
    echo -e "└─${GREEN}\$${RESET} $1"
    pause 0.12 0.25
}

# ------------------------------------------------------------
#  Special installation routines
# ------------------------------------------------------------

install_hashcat() {
    print_prompt "sudo apt install hashcat -y"

    echo "Reading package lists... Done"
    echo "Building dependency tree..."
    echo "Reading state information... Done"
    echo -e "The following NEW packages will be installed:"
    echo -e "  ${BRIGHT}hashcat${RESET}"
    echo "Need to get 12.4 MB of archives."
    pause 0.4 0.9

    echo -e "${BLUE}Get:${RESET} hashcat 6.$(rand 0 2).$(rand 0 9)-kali1 [${YELLOW}12.4 MB${RESET}]"
    pause 0.4 1

    progress_bar "Optimizing GPU kernels"

    echo "Setting up hashcat (6.$(rand 0 2).$(rand 0 9)-kali1) ..."
    progress_bar "Compiling OpenCL hash modes"
    echo -e "${GREEN}hashcat installation complete.${RESET}"
    pause 0.3 0.6
}

install_aircrack() {
    print_prompt "sudo apt install aircrack-ng -y"

    echo "Reading package lists... Done"
    echo "Building dependency tree..."
    echo "Reading state information... Done"
    echo -e "The following NEW packages will be installed:"
    echo -e "  ${BRIGHT}aircrack-ng${RESET}"
    echo "Need to get 4.6 MB of archives."
    pause 0.4 0.9

    echo -e "${BLUE}Get:${RESET} aircrack-ng 1.$(rand 5 7).$(rand 0 9)-kali1 [${YELLOW}4.6 MB${RESET}]"
    pause 0.3 0.7

    progress_bar "Calibrating wireless interfaces"

    echo "Setting up aircrack-ng..."
    progress_bar "Installing aircrack-ng suite"
    echo -e "${GREEN}aircrack-ng installation complete.${RESET}"
    pause 0.3 0.6
}

install_starkiller() {
    print_prompt "sudo apt install starkiller -y"

    echo "Reading package lists... Done"
    echo "Building dependency tree..."
    echo "Reading state information... Done"
    echo -e "The following NEW packages will be installed:"
    echo -e "  ${BRIGHT}starkiller${RESET}"
    echo "Need to get 22.8 MB of archives."
    pause 0.4 0.9

    echo -e "${BLUE}Get:${RESET} starkiller 2.$(rand 0 3).$(rand 0 9)-kali1 [${YELLOW}22.8 MB${RESET}]"
    pause 0.4 1

    progress_bar "Downloading Electron runtime"

    echo "Setting up starkiller..."
    progress_bar "Linking to Empire API"
    echo -e "${GREEN}starkiller installation complete.${RESET}"
    pause 0.3 0.6
}

run_special_install() {
    tool=$(rand_item "${SPECIAL_TOOLS[@]}")
    case "$tool" in
        hashcat) install_hashcat ;;
        aircrack-ng) install_aircrack ;;
        starkiller) install_starkiller ;;
    esac
}

# ------------------------------------------------------------
#  Standard APT simulations
# ------------------------------------------------------------

apt_update_sim() {
    print_prompt "sudo apt update"

    for i in $(seq 1 $(rand 15 40)); do
        type="Get"; color="$BLUE"
        r=$(rand 1 100)
        [[ $r -gt 90 ]] && type="Ign" && color="$GRAY"
        [[ $r -gt 75 && $r -le 90 ]] && type="Hit" && color="$GREEN"

        repo=$(rand_item "${REPOS[@]}")
        distro=$(rand_item "${DISTROS[@]}")
        section=$(rand_item "${SECTIONS[@]}")

        size=""
        [[ $type == "Get" ]] && size=" [${YELLOW}$(rand 1000 50000) B${RESET}]"

        echo -e "${color}${type}:${i}${RESET} $repo ${CYAN}$distro${RESET} $section$size"
        pause 0.02 0.12
    done

    echo -e "Fetched ${YELLOW}$(rand 3000 90000) kB${RESET} in $(rand 1 3)s"
    echo -e "${GRAY}Reading package lists...${RESET} Done"
}

apt_install_sim() {
    local count=$(rand 3 8)
    local pkgs=()

    for _ in $(seq 1 $count); do pkgs+=("$(pkg_name)"); done

    print_prompt "sudo apt install -y ${pkgs[*]}"

    echo "Reading package lists... Done"
    echo "Building dependency tree..."
    echo "Reading state information... Done"

    echo -e "${CYAN}The following NEW packages will be installed:${RESET}"
    echo -e "  ${BRIGHT}${pkgs[*]}${RESET}"

    echo "Need to get $(rand 10 300) MB of archives."
    echo "After this operation, $(rand 200 1500) MB of disk space will be used."
    pause 0.5 1

    for pkg in "${pkgs[@]}"; do
        echo -e "${BLUE}Get:${RESET} $pkg $(version) [${YELLOW}$(rand 100 8000) kB${RESET}]"
        pause 0.03 0.15
    done

    progress_bar "Reading database ..."

    for pkg in "${pkgs[@]}"; do
        v=$(version)
        echo "Preparing to unpack .../$pkg-$v.deb ..."
        pause 0.03 0.12
        echo "Unpacking $pkg ($v) ..."
        pause 0.04 0.2
    done

    for pkg in "${pkgs[@]}"; do
        echo -e "Setting up ${GREEN}${pkg}${RESET} ($(version)) ..."
        [[ $(rand 0 100) -gt 75 ]] && progress_bar "Configuring $pkg"
        pause 0.05 0.25
    done
}

# ------------------------------------------------------------
#  Startup
# ------------------------------------------------------------
clear
echo -e "${CYAN}Kali Linux Fake Installer Simulation${RESET}"
echo -e "${GREEN}User:${RESET} $USER"
echo -e "${GREEN}Host:${RESET} $(hostname)"
echo -e "${GRAY}Environment Check: OK${RESET}"
echo

trap "echo -e \"\n${RED}ABORTED BY USER${RESET}\"; tput cnorm; exit" SIGINT

# ------------------------------------------------------------
#  Main Loop
# ------------------------------------------------------------
while true; do
    r=$(rand 1 100)

    if (( r < 20 )); then
        run_special_install
    elif (( r < 55 )); then
        apt_update_sim
    else
        apt_install_sim
    fi

    pause 0.4 1.2
done
