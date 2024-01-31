#!/bin/bash

# Display a welcome banner
echo " __    __   _______  __       __        ______"
echo "|  |  |  | |   ____||  |     |  |      /  __  \ "
echo "|  |__|  | |  |__   |  |     |  |     |  |  |  |"
echo "|   __   | |   __|  |  |     |  |     |  |  |  |"
echo "|  |  |  | |  |____ |  `----.|  `----.|  `--'  |"
echo "|__|  |__| |_______||_______||_______| \______/ "
echo

# Check if the user is root
if [ $EUID -ne 0 ]; then
  echo "This script must be run as root."
  exit 1
fi

# Define the update function
function update() {
  apt-get update && apt-get upgrade -y
  pip3 install --upgrade pip
  pip3 install --upgrade -r requirements.txt
}

# Define the install function
function install() {
  echo "Select the tools you want to install:"
  select tool in "nmap" "nikto" "whois" "python3-pip" "python3-scapy" "gobuster" "metasploit-framework" "Exit"; do
    case $tool in
      nmap)
        apt-get install -y nmap
        ;;
      nikto)
        apt-get install -y nikto
        ;;
      whois)
        apt-get install -y whois
        ;;
      python3-pip)
        apt-get install -y python3-pip
        ;;
      python3-scapy)
        apt-get install -y python3-scapy
        ;;
      gobuster)
        apt-get install -y gobuster
        ;;
      metasploit-framework)
        apt-get install -y metasploit-framework
        ;;
      Exit)
        break
        ;;
      *)
        echo "Invalid choice. Please select a valid option."
        ;;
    esac
  done
}

# Define the help function
function help() {
  echo "Available commands:"
  echo
  echo "  help: Display this help message."
  echo "  clear: Clear the screen."
  echo "  update: Check for updates to the installed tools."
  echo "  install: Install additional tools."
  echo "  scan: Scan a website."
  echo "  whois: Perform a whois lookup."
  echo "  nmap: Perform an Nmap scan."
  echo "  gobuster: Perform a Gobuster scan."
  echo "  msf: Start the Metasploit console."
  echo "  search: Search for exploits."
  echo "  payload: Generate a payload."
  echo "  sessions: Manage Metasploit sessions."
  echo "  exit: Exit the Hacker Toolbox."
}

# Define the scan function
function scan() {
  echo "Enter the website URL:"
  read website
  nikto -h $website
}

# Define the whois function
function whois() {
  echo "Enter the domain name:"
  read domain
  whois $domain
}

# Define the nmap function
function nmap() {
  echo "Enter the target IP address:"
  read ip
  nmap -A $ip
}

# Define the gobuster function
function gobuster() {
  echo "Enter the target URL:"
  read url
  gobuster dir -u $url
}

# Define the msf function
function msf() {
  msfconsole
}

# Define the search function
function search() {
  echo "Enter the search term:"
  read search_term
  msfvenom --list | grep $search_term
}

# Define the payload function
function payload() {
  echo "Enter the payload type:"
  read payload_type
  msfvenom -p $payload_type --list
}

# Define the sessions function
function sessions() {
  echo "Select an action:"
  select action in "List sessions" "Interact with session" "Kill session" "Exit"; do
    case $action in
      "List sessions")
        msfconsole -x "sessions"
        ;;
      "Interact with session")
        echo "Enter the session ID:"
        read session_id
        msfconsole -x "sessions -i $session_id"
        ;;
      "Kill session")
        echo "Enter the session ID:"
        read session_id
        msfconsole -x "sessions -k $session_id"
        ;;
      "Exit")
        break
        ;;
      *)
        echo "Invalid choice. Please select a valid option."
        ;;
    esac
  done
}

# Define the exit function
function exit() {
  echo "Exiting the Hacker Toolbox."
  exit 0
}

# Create a log file
log_file="/tmp/hacker_toolbox.log"
exec &> >(tee -a $log_file)

# Load the configuration file
config_file="/etc/hacker_toolbox.conf"
if [ -f $config_file ]; then
  . $config_file
fi

# Start the main loop
while true; do

  # Display the menu options
  echo -e "1. Scan a website"
  echo -e "2. Whois lookup"
  echo -e "3. Nmap scan"
  echo -e "4. Gobuster scan"
  echo -e "5. Metasploit console"
  echo -e "6. Update tools"
  echo -e "7. Install additional tools"
  echo -e "8. Help"
  echo -e "9. Clear screen"
  echo -e "10. Search for exploits"
  echo -e "11. Generate a payload"
  echo -e "12. Manage Metasploit sessions"
  echo -e "13. Exit"

  # Read the user's choice
  read choice

  # Execute the selected option
  case $choice in
    1)
      scan
      ;;
    2)
      whois
      ;;
    3)
      nmap
      ;;
    4)
      gobuster
      ;;
    5)
      msf
      ;;
    6)
      update
      ;;
    7)
      install
      ;;
    8)
      help
      ;;
    9)
      clear
      ;;
    10)
      search
      ;;
    11)
      payload
      ;;
    12)
      sessions
      ;;
    13)
      exit
      ;;
    *)
      echo "Invalid choice. Please select a valid option."
      ;;
  esac

done
