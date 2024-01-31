#!/bin/bash

# Initialize variables
TOOLS_DIR="$HOME/.hacker-toolbox"
TOOLS_LIST=("nmap" "wireshark" "metasploit-framework" "sqlmap" "john" "hashcat" "hydra" "aircrack-ng" "ettercap" "maltego")

# Create the tools directory if it doesn't exist
mkdir -p "$TOOLS_DIR"

# Install the tools
for tool in "${TOOLS_LIST[@]}"; do
  echo "Installing $tool..."
  if ! command -v "$tool" &> /dev/null; then
    case "$tool" in
      nmap)
        sudo apt-get install nmap
        ;;
      wireshark)
        sudo apt-get install wireshark
        ;;
      metasploit-framework)
        curl -L https://raw.githubusercontent.com/rapid7/metasploit-framework/master/scripts/install.sh | bash
        ;;
      sqlmap)
        sudo apt-get install sqlmap
        ;;
      john)
        sudo apt-get install john
        ;;
      hashcat)
        sudo apt-get install hashcat
        ;;
      hydra)
        sudo apt-get install hydra
        ;;
      aircrack-ng)
        sudo apt-get install aircrack-ng
        ;;
      ettercap)
        sudo apt-get install ettercap
        ;;
      maltego)
        sudo apt-get install maltego
        ;;
    esac
  fi
done

# Create the main menu
MENU="""
Hacker Toolbox

1. Network Scanning
2. Packet Sniffing
3. Penetration Testing
4. Vulnerability Assessment
5. Password Cracking
6. Wireless Attacks
7. Social Engineering
8. Exit

Enter your choice (1-8): """

# Display the main menu and get the user's choice
while true; do
  echo "$MENU"
  read -p "" choice

  # Handle the user's choice
  case "$choice" in
    1)
      nmap
      ;;
    2)
      wireshark
      ;;
    3)
      msfconsole
      ;;
    4)
      sqlmap
      ;;
    5)
      john
      ;;
    6)
      aircrack-ng
      ;;
    7)
      maltego
      ;;
    8)
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a number between 1 and 8."
      ;;
  esac
done
