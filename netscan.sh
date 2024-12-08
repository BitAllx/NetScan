#!/bin/bash

#Colours
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

# Ctrl + C
trap ctrl_c SIGINT

function ctrl_c(){
  echo -e "${red}\n\n[!] Saliendo...\n${end}"
  if [ -f "arp.tmp" ]; then
    rm arp.tmp
  fi
  tput cnorm; exit 1
}

arp_scan="$(which arp-scan)"
fping="$(which fping)"

if [ ! "$arp_scan" ] || [ ! "$fping" ]; then
  echo -e "\n${red}[!] Herramientas necesarias no instaladas${end}"
  echo -ne "\n${yellow}[*]${end} ${gray}¿Quiéres instalarlas?${end}${purple} [n/y]:${end}${green} "; read confirm; echo -ne "${end}"

  if [[ "$confirm" == "y" ]]; then
    if [ "$(id -u)" -ne "0" ]; then
      echo -e "\n${red}[!] Para proceder con la instalación debes de ser root${end}"
      exit 1
    else
      apt install arp\-scan fping
      exit 0
    fi
  else
    exit 0
  fi
fi

function helpPanel(){ 
  echo -e "\n${yellow}[+]${end}${purple} Uso:${end}"
  echo -e "\n\t${green}$0${end} ${turquoise}-s${end} ${gray}'scan-mode'${end} | ${turquoise}-h${end}"
  
  echo -e "\n${yellow}[+]${end}${purple} Opciones:${end}"
  echo -e "\n\t${turquoise}-s${end}    ${gray}Selecciona el modo de escaneo.${end}"
  echo -e "\n\t\t${green}arpScan${end}     ${gray}Escaneo utilizando ARP.${end}"
  echo -e "\t\t${green}pingScan${end}    ${gray}Escaneo utilizando ping.${end}"
  echo -e "\n\t${turquoise}-h${end}    ${gray}Muestra este panel de ayuda.${end}"
  
  echo -e "\n${yellow}[+]${end}${purple} Autor: ${end}${green}Jorge Arana Fedriani${end}\n"
}

function scan(){
  if [[ "$modeScan" == "arpScan" ]] || [[ "$modeScan" == "pingScan" ]] ; then
    clear
    tput civis
    echo -ne "${blue}Iniciando${end}${green} $modeScan${end}"
    echo -ne "${red}  --------  ${end}"
    echo -ne "${turquoise}NetScan${end}${blue} on fire!!${end}"; echo
    sleep 1

    if [[ "$modeScan" == "arpScan" ]]; then
      ifaces="$(ip a | grep "[1-9]: " | awk '{print $2}' | sed 's/://g')"
      echo -e "\n${yellow}[+]${end}${purple} Interfaces disponibles:${end}\n"
      for line in $ifaces; do
        echo -e "\t${red} - ${end}${blue}$line${end}"
      done
      tput cnorm
      echo -ne "\n${yellow}[+]${end}${purple} Proporciona la interfaz a usar: ${end}"; echo -ne "${blue}"; read iface; echo -ne "${end}"
      tput civis
      clear
      echo -e "${purple}Escaneando la red de la interfaz ${end}${blue}$iface...${end}\n"
      arp\-scan -I $iface --localnet --ignoredups > arp.tmp
      cat arp.tmp | awk 'NR > 2' | sed '/^$/q' | sed '${/./!d}' | awk '{print $1,$2}' | while read ip mac; do
        echo -e "${blue}$ip${end}${red} --- ${end}${green}$mac${end}"
      done; echo
      rm arp.tmp
    elif [[ "$modeScan" == "pingScan" ]]; then
      ifaces="$(ip a | grep "[1-9]: " | awk '{print $2}' | sed 's/://g')"
      echo -e "\n${yellow}[+]${end}${purple} Interfaces disponibles:${end}\n"
      for line in $ifaces; do
        echo -e "\t${red} - ${end}${blue}$line${end}"
      done
      tput cnorm
      echo -ne "\n${yellow}[+]${end}${purple} Proporciona la interfaz a usar: ${end}"; echo -ne "${blue}"; read iface; echo -ne "${end}"
      tput civis
      clear
      subip="$(ip a show "$iface" | grep "inet " | awk '{print $2}')"
      echo -e "${purple}Escaneando la red de la interfaz ${end}${blue}$iface...${end}\n"
      fping -agq $subip | while read ip; do
        echo -e "${red} - ${end}${blue}$ip${end}"
      done
    fi
  else
    echo -e "\n${red}[!] Error al indicar el modo de escaneo: $modeScan no existe${end}"
    helpPanel; exit 1
  fi
}

let parameter_counter=0

while getopts 's:h' arg; do
  case $arg in
    s) modeScan=$OPTARG; scan; let parameter_counter+=1 ;;
    h) helpPanel; let parameter_counter+=1 ;;
  esac
done

if [ "$parameter_counter" -eq 0 ]; then
  helpPanel
fi

tput cnorm
