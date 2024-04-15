#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

wordlist=$1
metodo=$2
hash=$3
count=
crack=0

trap ctrl_c INT
function ctrl_c(){
	echo -e "\n\n${yellowColour}[*]${endColour}${blueColour} Saliendo...\n${endColour}"
	exit 0
}

if [ $# -ne 3 ]; then
    echo -e "${yellowColour}[+]${endColour}${blueColour}Uso: $0 wordlist.txt metodo hash${endColour}"
    echo -e "${yellowColour}[+]${endColour}${blueColour}los metodos disponibles son: sha256sum, sha512sum ${endColour}"
    exit 1
fi

if [ "$metodo" != "sha256sum" ] && [ "$metodo" != "sha512sum" ]; then
    echo -e "${yellowColour}[+]${endColour}${blueColour} Método no permitido, solo se permiten los siguientes métodos: \n sha256sum\tsha512sum${endColour}"
    exit 1
fi
while read -r line; do
    #echo -e "${yellowColour}[+]${endColour}${blueColour} Probando con:${endColour}${greenColour} $line${endColour}"
    hashd=$(echo "$line" | $2 | awk '{print $1}')
    #echo -e "${yellowColour}[+]${endColour}${blueColour} Probando el hash de $line:${endColour}${greenColour} $hash${endColour}"
    let count+=1
	if [ "$hashd" == "$hash" ]; then
		echo -e "${yellowColour}[+]${endColour}${blueColour} El hash hallado y crackeado es:${endColour}${yellowColour} $line${endColour}"
		echo -e "${yellowColour}[+]${endColour}${blueColour} Intento numero:${endColour}${greenColour} $count${endColour}"
		exit 0	
		crack=$line	
	fi
done < $1
if [ $crack == 0 ]; then
	echo -e "${yellowColour}[+]${endColour}${blueColour} No se pudo crackear el hash ${yellowColour}:(${endColour}"
fi
