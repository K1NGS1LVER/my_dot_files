#!/bin/bash
# pipes.sh: Animated pipes terminal screensaver.
# Optimized and fixed version for modern terminals and older bash versions.

export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8

VERSION=1.3.1

M=32768
p=1
f=75
s=13
r=2000
t=0
w=80
h=24

sets=(
    "┃┏ ┓┛━┓  ┗┃┛┗ ┏━"
    "│╭ ╮╯─╮  ╰│╯╰ ╭─"
    "│┌ ┐┘─┐  └│┘└ ┌─"
    "║╔ ╗╝═╗  ╚║╝╚ ╔═"
    "|+ ++-+  +|++ +-"
    "|/ \/-\  \|/\ /-"
    ".. ....  .... .."
    ".o oo.o  o.oo o."
    "-\ /\|/  /-\/ \|"
    "╿┍ ┑┚╼┒  ┕╽┙┖ ┎╾"
)

x=() y=() l=() n=() v=() c=()
V=() C=() VN=0 CN=0
RNDSTART=0 BOLD=1 NOCOLOR=0 KEEPCT=0

parse() {
    OPTIND=1
    while getopts "p:t:c:f:s:r:RBCKhv" arg; do
        case $arg in
            p) ((p = OPTARG > 0 ? OPTARG : p));;
            t) [[ "$OPTARG" = c???????????????? ]] && { V+=(${#sets[@]}); sets+=("${OPTARG:1}"); } || { ((OPTARG >= 0 && OPTARG < ${#sets[@]})) && V+=($OPTARG); };;
            c) [[ $OPTARG =~ ^[0-7]$ ]] && C+=($OPTARG);;
            f) ((f = (OPTARG > 9 && OPTARG < 201) ? OPTARG : f));;
            s) ((s = (OPTARG > 4 && OPTARG < 16) ? OPTARG : s));;
            r) ((r = OPTARG >= 0 ? OPTARG : r));;
            R) RNDSTART=1;;
            B) BOLD=0;;
            C) NOCOLOR=1;;
            K) KEEPCT=1;;
            h) echo "Usage: $(basename "$0") [-p pipes] [-f frame_rate] [-t type] [-c color] [-r limit] [-RBCK]"; exit 0;;
            v) echo "pipes.sh $VERSION"; exit 0;;
        esac
    done
    ((${#V[@]})) || V=(0); VN=${#V[@]}
    ((${#C[@]})) || C=(1 2 3 4 5 6 7 0); CN=${#C[@]}
}

cleanup() {
    printf "\e[?25h\e[0m\e[u"
    stty echo 2>/dev/null
    tput rmcup 2>/dev/null
    exit 0
}

resize() {
    w=$(tput cols) h=$(tput lines)
}

init() {
    resize
    trap resize SIGWINCH
    local i ci vi
    ci=$((KEEPCT ? 0 : CN * RANDOM / M))
    vi=$((KEEPCT ? 0 : VN * RANDOM / M))
    for ((i = 0; i < p; i++)); do
        n[i]=0 l[i]=$((RNDSTART ? RANDOM % 4 : 0))
        x[i]=$((RNDSTART ? w * RANDOM / M : w / 2))
        y[i]=$((RNDSTART ? h * RANDOM / M : h / 2))
        c[i]=${C[ci]} v[i]=${V[vi]}
        ci=$(( (ci + 1) % CN )); vi=$(( (vi + 1) % VN ))
    done
    stty -echo 2>/dev/null
    tput smcup 2>/dev/null
    printf "\e[?25l\e[2J\e[s"
    trap cleanup HUP TERM INT
}

main() {
    parse "$@"
    init
    local i KEY delay
    HAS_BC=$(command -v bc >/dev/null && echo 1 || echo 0)

    while true; do
        if read -t 0 -n 1 2>/dev/null; then
            read -n 1 KEY
            case "$KEY" in
                [pP]) ((s = s < 15 ? s + 1 : s));;
                [oO]) ((s = s > 3 ? s - 1 : s));;
                [fF]) ((f = f < 200 ? f + 1 : f));;
                [dD]) ((f = f > 10 ? f - 1 : f));;
                [bB]) BOLD=$(( (BOLD + 1) % 2 ));;
                [cC]) NOCOLOR=$(( (NOCOLOR + 1) % 2 ));;
                [kK]) KEEPCT=$(( (KEEPCT + 1) % 2 ));;
                q|Q|$'\e') break;;
            esac
        fi

        for ((i = 0; i < p; i++)); do
            ((l[i] % 2)) && ((x[i] += -l[i] + 2)) || ((y[i] += l[i] - 1))
            if (( x[i] >= w || x[i] < 0 || y[i] >= h || y[i] < 0 )); then
                ((!KEEPCT)) && { c[i]=${C[CN * RANDOM / M]}; v[i]=${V[VN * RANDOM / M]}; }
                x[i]=$(( (x[i] % w + w) % w ))
                y[i]=$(( (y[i] % h + h) % h ))
            fi
            n[i]=$(( s * RANDOM / M - 1 ))
            n[i]=$(( (n[i] > 1 || n[i] == 0) ? l[i] : l[i] + n[i] ))
            n[i]=$(( (n[i] < 0) ? 3 : n[i] % 4 ))
            
            # Draw optimized
            if ((NOCOLOR)); then
                printf "\e[%d;%dH\e[%dm%s" $((y[i] + 1)) $((x[i] + 1)) $BOLD "${sets[v[i]]:l[i]*4+n[i]:1}"
            else
                printf "\e[%d;%dH\e[%d;3%dm%s" $((y[i] + 1)) $((x[i] + 1)) $BOLD ${c[i]} "${sets[v[i]]:l[i]*4+n[i]:1}"
            fi
            l[i]=${n[i]}
        done

        if ((r > 0 && t * p >= r)); then
            printf "\e[2J"
            t=0
        else
            ((t++))
        fi
        
        # Delay calculation
        if ((HAS_BC)); then
            delay=$(echo "scale=4; 1 / $f" | bc -l)
            sleep "$delay"
        else
            # Fallback for systems without bc
            sleep 0.013
        fi
    done
    cleanup
}

main "$@"
