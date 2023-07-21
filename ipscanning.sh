#!/bin/bash

color_code="\e[32m" 
reset_code="\x1b[0m"

figlet_text="N M A P     S C A N !"

echo -e "${color_code}"
figlet "${figlet_text}"
echo -e "${reset_code}"

read -p "Enter your IP : " IP
read -p "Enter your Port : " port

while true; do
    echo -e "Select a Scan \n 1 for Aggresive Scan \n 2 for Syn Scan \n 3 for TCP Scan  \n 4 for normal scan \n 5 for Vulnerability scan \n 6 for Advanced  Scan "
    read -p "Enter Your choice : " st
    echo "" 

    if [ $st -gt 6 ]; then
        echo "Invalid choice. Please select a valid task."
        continue
    fi

    echo "You entered : $IP"
    #echo "" 
    echo "You entered : $port "
    #echo "" 
    echo "You choose: $st"
    #echo "" 

    read -p "Is this information correct? (y/n) " confirm

    if [[ $confirm == [Yy]* ]]; then
        echo "Continuing the script..."

        if [ $st -eq 1  ]
        then
            echo "Scanning Please WAIT...."
            #nmap -A $IP -p $port  > /dev/null && xsltproc /usr/share/nmap/nmap.xsl ~/output.xml > ~/output.html
            #timestamp=$(date +%Y%m%d%H%M%S) && nmap -A $IP -p $port -oX output_$timestamp.xml $IP && xsltproc output_$timestamp.xml -o output_$timestamp.html	
           timestamp=$(date +%Y%m%d%H%M%S) && nmap -A $IP -p $port -oX output_$timestamp.xml > nmap_$timestamp.log && xsltproc output_$timestamp.xml -o output_$timestamp.html && echo "Your output has been stored in the following location: $(pwd)/nmap_$timestamp.log and $(pwd)/output_$timestamp.html" 

        elif [ $st -eq 2 ]
        then    
            echo "Scanning Please WAIT...."
            timestamp=$(date +%Y%m%d%H%M%S) && nmap -sS -O -sV $IP -p $port -oX output_$timestamp.xml > nmap_$timestamp.log && xsltproc output_$timestamp.xml -o output_$timestamp.html && echo "Your output has been stored in the following location: $(pwd)/nmap_$timestamp.log and $(pwd)/output_$timestamp.html" 
        elif [ $st -eq 3 ]
        then
            echo "Scanning Please WAIT...."
            timestamp=$(date +%Y%m%d%H%M%S) &&  nmap -sT -O -sV $IP -p $port -oX output_$timestamp.xml > nmap_$timestamp.log && xsltproc output_$timestamp.xml -o output_$timestamp.html && echo "Your output has been stored in the following location: $(pwd)/nmap_$timestamp.log and $(pwd)/output_$timestamp.html"  
        elif [ $st -eq 4  ]
        then 
            echo "Scanning Please WAIT...."
            timestamp=$(date +%Y%m%d%H%M%S) && nmap $IP -oX output_$timestamp.xml > nmap_$timestamp.log && xsltproc output_$timestamp.xml -o output_$timestamp.html && echo "Your output has been stored in the following location: $(pwd)/nmap_$timestamp.log and $(pwd)/output_$timestamp.html" 
        elif [ $st -eq 5 ]
        then 
            echo "Scanning Please WAIT...."
            timestamp=$(date +%Y%m%d%H%M%S) && nmap -p $port --script vuln $IP -oX output_$timestamp.xml > nmap_$timestamp.log && xsltproc output_$timestamp.xml -o output_$timestamp.html && echo "Your output has been stored in the following location: $(pwd)/nmap_$timestamp.log and $(pwd)/output_$timestamp.html" 
         elif [ $st -eq 6 ]
        then 
            echo "Scanning Please WAIT...."
            timestamp=$(date +%Y%m%d%H%M%S) && nmap -T4 -A -p $port $IP -oX output_$timestamp.xml > nmap_$timestamp.log && xsltproc output_$timestamp.xml -o output_$timestamp.html && echo "Your output has been stored in the following location: $(pwd)/nmap_$timestamp.log and $(pwd)/output_$timestamp.html" 
            #nmap -p $port --script vuln $IP | grep open
        fi 
        break
    else
        echo "Please re-enter your information."
        echo "" 
        #echo "" 
        read -p "Enter your IP : " IP
        read -p "Enter your Port : " port
    fi    
done
