#!/bin/bash
# ====================================================
# @Author: Engeryu
# Date:   2018-09-02 08:01:12
# @Last Modified by:   Engeryu
# @Last Modified time: 2025-04-07 09:52:22
# Description: Command-line application that displays 
#              system information. The menu is navigable via a 
#              numbered list. Each number corresponds to a selection
# ====================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

pause() {
    read -rp $'\nPress enter to continue...'
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

print_header() {
    clear
    echo -e "${CYAN}======================================="
    echo -e " $1"
    echo -e "=======================================${NC}"
}

main_menu() {
    while true; do
        print_header "System Information Menu"
        echo "1) Hardware Information"
        echo "2) Network Information"
        echo "3) Process Management"
        echo "4) Exit"
        read -p $'\nEnter your choice: ' main_choice
        case "$main_choice" in
            1) hardware_menu ;;
            2) network_menu ;;
            3) process_menu ;;
            4) exit 0 ;;
            *) echo -e "${RED}Invalid option. Try again.${NC}" ; pause ;;
        esac
    done
}

hardware_menu() {
    while true; do
        print_header "Hardware Information"
        echo "1) Motherboard Info"
        echo "2) CPU Info"
        echo "3) RAM Info"
        echo "4) GPU/PCI Info"
        echo "5) Disk Info"
        echo "6) USB Info"
        echo "7) Kernel Version"
        echo "8) Back"
        read -p $'\nEnter your choice: ' hw_choice
        case "$hw_choice" in
            1)
                echo "----- Motherboard -----"
                command_exists dmidecode && sudo dmidecode -t baseboard | less || echo "dmidecode not found."
                echo "----- BIOS Version -----"
                command_exists dmidecode && sudo dmidecode -t bios | grep -i version || echo "dmidecode not found."
                pause ;;
            2)
                echo "----- CPU -----"
                lscpu
                pause ;;
            3)
                echo "----- RAM -----"
                free -h
                cat /proc/meminfo | less
                pause ;;
            4)
                echo "----- GPU/PCI -----"
                command_exists lspci && lspci | grep VGA || echo "lspci not found."
                command_exists glxinfo && glxinfo | grep rendering || echo "glxinfo not found."
                pause ;;
            5)
                echo "----- Disks -----"
                df -h | less
                echo "Home folder usage:"
                du -sh $HOME
                command_exists smartctl && sudo smartctl -a /dev/sda | less || echo "smartctl not found."
                pause ;;
            6)
                echo "----- USB -----"
                command_exists lsusb && lsusb | less || echo "lsusb not found."
                pause ;;
            7)
                echo "Kernel Version:"
                uname -r
                pause ;;
            8) break ;;
            *) echo -e "${RED}Invalid option.${NC}" ; pause ;;
        esac
    done
}

network_menu() {
    while true; do
        print_header "Network Information"
        echo "1) Ping"
        echo "2) ARP Table"
        echo "3) Traceroute"
        echo "4) IP Config"
        echo "5) Routing Table"
        echo "6) DNS Lookup"
        echo "7) Netstat"
        echo "8) Nmap Scan"
        echo "9) UFW Status"
        echo "10) Back"
        read -p $'\nEnter your choice: ' net_choice
        case "$net_choice" in
            1) read -p "Host to ping: " target; ping -c 4 "$target" ; pause ;;
            2) arp -a ; pause ;;
            3) read -p "Host for traceroute: " target; traceroute "$target" ; pause ;;
            4) ip addr show ; pause ;;
            5) ip route show ; pause ;;
            6) read -p "Hostname: " target; nslookup "$target" ; pause ;;
            7) netstat -tulpen ; pause ;;
            8)
                if command_exists nmap; then
                    read -p "Target for nmap scan: " target
                    nmap "$target"
                else
                    echo "nmap not found."
                fi
                pause ;;
            9)
                if command_exists ufw; then
                    sudo ufw status
                else
                    echo "ufw not installed."
                fi
                pause ;;
            10) break ;;
            *) echo -e "${RED}Invalid option.${NC}" ; pause ;;
        esac
    done
}

process_menu() {
    while true; do
        print_header "Process Management"
        echo "1) List Processes"
        echo "2) Top"
        echo "3) Kill a Process"
        echo "4) Back"
        read -p $'\nEnter your choice: ' proc_choice
        case "$proc_choice" in
            1) ps aux | less ; pause ;;
            2) top ;;
            3)
                read -p "Enter PID to kill: " pid
                kill "$pid" && echo "Killed $pid" || echo "Failed to kill process."
                pause ;;
            4) break ;;
            *) echo -e "${RED}Invalid option.${NC}" ; pause ;;
        esac
    done
}

# Run the script
main_menu