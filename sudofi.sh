#!/bin/bash

echo "=== sudofi - SUbDOmain FInder ==="
echo "By Atul Tiwari - Linkedin:- @hackeratul | www.grayhat.in"
echo

# Get user input
read -p "Enter the website to find subdomains: " target_website

# Send a request to crt.sh API to find subdomains
subdomains=$(curl -s "https://crt.sh/?q=%25.$target_website&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u)

# Filter subdomains based on provided options
while getopts ":d:" opt; do
  case $opt in
    d)
      domain="$OPTARG"
      subdomains=$(echo "$subdomains" | grep "$domain")
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

# Print the found subdomains
echo -e "\nSubdomains of $target_website:\n"
echo "$subdomains"
