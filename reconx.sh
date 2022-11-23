color(){
  RED="\e[31m"
  CYAN="\e[36m"
  ENDCOLOR="\e[0m"
  BLINK="\e[5m"
  BOLD="\e[1m"
  GREEN="\e[32m"
  YELLOW="\e[33m"

}

Logo(){
  cat <<"EOF"

         _                             _
       _==/          i     i          \==
     /XX/            |\___/|            \XX\
   /XXXX\            |XXXXX|            /XXXX\
  |XXXXXX\_         _XXXXXXX_         _/XXXXXX|
 XXXXXXXXXXXxxxxxxxXXXXXXXXXXXxxxxxxxXXXXXXXXXXX
 |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|
  XXXXXXXXXXXXX 💀 The_Rec0n_X 💀 XXXXXXXXXXXXXX
 |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|
 XXXXXX/^^^^\XXXXXXXXXXXXXXXXXXXXX/^^^^^\XXXXXX
  |XXX|       \XXX/^^\XXXXX/^^\XXX/       |XXX|
    \XX\       \X/    \XXX/    \X/       /XX/
       :\       :      \X/      :       /:
                        !
            🗲 Automated Recon Tool 🗲
EOF
}
Logo
color
echo -e "            Devloped by:${RED}${BLINK}Bl4cK_V1ru5${ENDCOLOR}"
echo -e "            Twitter: ${CYAN}@Yazeed_oliwah${ENDCOLOR}"

#############Create Files###########


file(){
  echo -e "\e[94mEnter the organisation name (E.g.,Facebook): \e[0m"
  read company
  mkdir  -p $company
  cd $company
  mkdir  -p Subdomains/ 
  cd Subdomains
  mkdir  -p Technology/ Subdomains/ Shodan/ API_EndPoint/  Screen-Shoot/ Nuclei/ Wayback_URLS/ nabuu/ Trash/ Wayback-file/ 
  cd ../
}

subdomain() {
  echo -e "${GREEN} Starting Subdomain-Enumeration: ${ENDCOLOR}"  
  amass enum -passive -norecursive -noalts -df $domain -o  Subdomains/Trash/amass.txt &>/dev/null
  echo -e "\e[36m     \_amass count: \e[32m$(cat Subdomains/Trash/amass.txt | tr '[:upper:]' '[:lower:]'| anew | wc -l)\e[0m"  
  subfinder -dL $domain -o Subdomains/Trash/subfinder.txt &>/dev/null
  echo -e "\e[36m      \_subfinder count: \e[32m$(cat  Subdomains/Trash/subfinder.txt | tr '[:upper:]' '[:lower:]'| anew | wc -l)\e[0m"
  cat $domain | assetfinder --subs-only >> Subdomains/Trash/assetfinder.txt &>/dev/null
  echo -e "\e[36m       \_assetfinder count: \e[32m$(cat  Subdomains/Trash/assetfinder.txt | tr '[:upper:]' '[:lower:]'| anew | wc -l)\e[0m"
  for x in $(cat $domain)
  do
  python3 $HOME/tools/Sublist3r/sublist3r.py -d $x | grep -oP  "(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]" >> Subdomains/Trash/sublist3r.txt &>/dev/null
  done
  echo -e "\e[36m        \_sublist3r count: \e[32m$(cat  Subdomains/Trash/sublist3r.txt | tr '[:upper:]' '[:lower:]'| anew | wc -l)\e[0m"
  echo -e "${GREEN} Started Filtering Subdomains: ${ENDCOLOR}"

  for x in $(cat $domain)
  do
  cat Subdomains/Trash/* | grep -i $x | anew >> Subdomains/Trash/final-result
  done
  cat Subdomains/Trash/final-result | sort -u >> Subdomains/Subdomains/Final_Subdomains.txt
  echo -e "\e[36mFinal Subdomains count: \e[32m$(cat Subdomains/Subdomains/Final_Subdomains.txt | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  cat Subdomains/Subdomains/Final_Subdomains.txt | httpx -o Subdomains/Subdomains/livesub.txt &>/dev/null
  echo -e "\e[36mFinal live Subdomains count: \e[32m$(cat Subdomains/Subdomains/livesub.txt | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  echo -e "${GREEN} Starting Filter Intresting subs: ${ENDCOLOR}"
  cat Subdomains/Subdomains/livesub.txt | grep -E "auth|corp|sign_in|sign_up|ldap|idp|dev|api|admin|login|signup|jira|gitlab|signin|ftp|ssh|git|jenkins|kibana|administration|administrator|administrative|grafana|vpn|jfroge" >> Subdomains/Subdomains/intrested_live_sub.txt
  echo -e "\e[36m          \_Final Intresting live subs count: \e[32m$(cat Subdomains/Subdomains/intrested_live_sub.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  cat Subdomains/Subdomains/Final_Subdomains.txt | grep -E "auth|corp|sign_in|sign_up|ldap|idp|dev|api|admin|login|signup|jira|gitlab|signin|ftp|ssh|git|jenkins|kibana|administration|administrator|administrative|grafana|vpn|jfroge" >> Subdomains/Subdomains/intrested_sub.txt
  echo -e "\e[36m          \_Final Intresting subs count: \e[32m$(cat Subdomains/Subdomains/intrested_sub.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  echo -e "${GREEN} Starting Find Admin Panels: ${ENDCOLOR} "
  cat Subdomains/Subdomains/Final_Subdomains.txt | httpx  -sc -mc 200,302,401 -path `cat $HOME/tools/admin.txt` >> Subdomains/Subdomains/adminpanel.txt &>/dev/null
  echo -e "\e[36m          \_Final Admin Panel count: \e[32m$(cat Subdomains/Subdomains/adminpanel.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  sleep 10
  echo -e "${GREEN} Starting Screenshot... ${ENDCOLOR}"
  cat Subdomains/Subdomains/livesub.txt | aquatone -out Subdomains/Screen-Shoot/livesub &>/dev/null
  cat Subdomains/Subdomains/adminpanel.txt | aquatone -out Subdomains/Screen-Shoot/adminsub &>/dev/null
  echo -e "${YELLOW} Finish Subdomain Enum ${ENDCOLOR}" 
  echo -e " Finish Subdomain Enum " | notify &>/dev/null


}

shodan(){
  echo -e "${GREEN} Starting Collecting Ip From Shodan: ${ENDCOLOR}"
  for x in $(cat $domain)
  do
  echo 'ssl:''"'$x'"' | uncover -v -o Subdomains/Trash/ip1.txt &>/dev/null
  echo 'ssl.cert.subject.CN''"'$x'"' | uncover -v -o Subdomains/Trash/ip2.txt &>/dev/null
  done
  cat Subdomains/Trash/ip1.txt Subdomains/Trash/ip2.txt >> Subdomains/Shodan/ip.txt
  echo -e "\e[36m          \_Final Ip count: \e[32m$(cat Subdomains/Shodan/ip.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  echo -e "${GREEN} Starting Filter Ips: ${ENDCOLOR}"
  cat Subdomains/Shodan/ip.txt | httpx -o Subdomains/Shodan/liveip.txt &>/dev/null
  echo -e "\e[36m          \_Final  Filter Ip count: \e[32m$(cat Subdomains/Shodan/liveip.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  echo -e "${GREEN} Starting Scan Ports For Ips:  ${ENDCOLOR}"
  naabu  -list Subdomains/Shodan/ip.txt  -exclude-ports 80,443 -o Subdomains/Shodan/port_ip.txt &>/dev/null
  echo -e "\e[36m          \_Final Ports count: \e[32m$(cat  Subdomains/Shodan/port_ip.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  echo -e "${GREEN} Starting Filter Ports: ${ENDCOLOR}"
  cat Subdomains/Shodan/port_ip.txt | httpx -o Subdomains/Shodan/live_port_ip.txt &>/dev/null
  echo -e "\e[36m          \_Final Live Ports count: \e[32m$(cat  Subdomains/Shodan/live_port_ip.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  echo -e " ${YELLOW} Finished collecting ip from shodan ${ENDCOLOR}"
  echo -e " Finished collecting ip from shodan " | notify &>/dev/null


  

}
portscan(){
    echo -e "${GREEN} Start Port Scan: ${ENDCOLOR}"
    naabu  -list Subdomains/Subdomains/Final_Subdomains.txt  -exclude-ports 80,443 -o Subdomains/nabuu/port.txt &>/dev/null
    echo -e "\e[36m            \_Final Ports count: \e[32m$(cat  Subdomains/nabuu/port.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
    echo -e "${GREEN} Start Filter Port : ${ENDCOLOR}"
    cat Subdomains/nabuu/port.txt | httpx -o Subdomains/nabuu/liveport.txt &>/dev/null
    echo -e "\e[36m             \_Final Live Ports count: \e[32m$(cat  Subdomains/nabuu/liveport.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
    echo  -e " ${GREEN} Start Filter Intresting Ports: ${ENDCOLOR}"
    cat Subdomains/nabuu/port.txt | grep -E ":8443|:8089|:8080|:81|:444|:4444|:3000|:5000|:555|:90001" >> Subdomains/nabuu/intersed_port.txt
    echo -e "\e[36m              \_Final Intresting Ports count: \e[32m$(cat  Subdomains/nabuu/intersed_port.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
    cat Subdomains/nabuu/liveport.txt | grep -E ":8443|:8089|:8080|:81|:444|:4444|:3000|:5000|:555|:90001" >> Subdomains/nabuu/intersed_liveport.txt
    echo -e "\e[36m               \_Final Intresting Live Ports count: \e[32m$(cat  Subdomains/nabuu/intersed_liveport.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
    echo -e "${GREEN} Starting Find Admin Panels: ${ENDCOLOR}"
    cat Subdomains/nabuu/port.txt | httpx -sc -mc 200,302,401 -path `cat $HOME/tools/admin.txt` >>  Subdomains/nabuu/adminpanel.txt &>/dev/null
    echo -e "\e[36m                \_Final Admin Panel count: \e[32m$(cat Subdomains/nabuu/adminpanel.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
    sleep 10
    echo -e "${GREEN} Starting Screenshot... ${ENDCOLOR} "
    cat Subdomains/nabuu/liveport.txt | aquatone -out Subdomains/Screen-Shoot/liveport &>/dev/null
    cat Subdomains/nabuu/adminpanel.txt | aquatone -out Subdomains/Screen-Shoot/adminport &>/dev/null
    echo -e "${YELLOW} Finished Port Scan ${ENDCOLOR}" 
    echo -e " Finished Port Scan " | notify &>/dev/null



}

wapplyzer(){
  echo -e "${GREEN} Starting Identify Technology... ${ENDCOLOR}"
  webanalyze -hosts Subdomains/Subdomains/Final_Subdomains.txt  1>Subdomains/Technology/sub_tech.txt &>/dev/null
  echo -e "\e[36m          \_Final Subs technology count: \e[32m$(cat Subdomains/Technology/sub_tech.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  webanalyze -hosts Subdomains/nabuu/liveport.txt  1>Subdomains/Technology/sub_port_tech.txt  &>/dev/null
  echo -e "\e[36m          \_Final Port technology count: \e[32m$(cat Subdomains/Technology/sub_tech.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  echo -e "${YELLOW} Finished Identify Technology ${ENDCOLOR}" 
  echo " Finished Identify Technology " | notify &>/dev/null


}
waybackurls(){
  echo -e "${GREEN} Wayback Enum: ${ENDCOLOR}"
  cat Subdomains/Subdomains/livesub.txt | gau >> Subdomains/Wayback_URLS/gau.txt
  cat Subdomains/Wayback_URLS/gau.txt >> Subdomains/Wayback_URLS/all.txt
  echo -e "\e[36m       \_Final Wayback_history count: \e[32m$(cat Subdomains/Wayback_URLS/all.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  sleep 5
  #api endpoint 
  echo -e "${GREEN} Starting Collect Api-Endpoint ${ENDCOLOR} "
  cat Subdomains/Wayback_URLS/all.txt | grep -i "/api/" | sort -u >> Subdomains/API_EndPoint/Api-EndPoint.txt
  echo -e "\e[36m       \_Final Api endpoint count: \e[32m$(cat Subdomains/API_EndPoint/Api-EndPoint.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  sleep 5
  echo "${YELLOW} Wayback-archive done ${ENDCOLOR}" 
  echo -e " Wayback-archive done " | notify &>/dev/null


}
js_file(){
  #js files
  echo -e "${GREEN} Stating Collect js,php,jsp,aspx File: ${ENDCOLOR}"
  mkdir -p Subdomains/Wayback-file/Secrets/
  cat Subdomains/Wayback_URLS/all.txt | grep -aEo 'https?://[^ ]+' | sed 's/]$//' | sort -u| grep -aEi "\.(js)" >> Subdomains/Wayback-file/Js-file.txt
  echo -e "\e[36m       \_Final Js file  count: \e[32m$(cat Subdomains/Wayback-file/Js-file.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"

  cat Subdomains/Wayback_URLS/all.txt | grep -aEo 'https?://[^ ]+' | sed 's/]$//' | sort -u| grep -aEi "\.(php)" >> Subdomains/Wayback-file/PHP-file.txt
  echo -e "\e[36m       \_Final PHP file  count: \e[32m$(cat Subdomains/Wayback-file/PHP-file.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"

  cat Subdomains/Wayback_URLS/all.txt | grep -aEo 'https?://[^ ]+' | sed 's/]$//' | sort -u| grep -aEi "\.(aspx)" >> Subdomains/Wayback-file/aspx-file.txt
  echo -e "\e[36m       \_Final aspx file  count: \e[32m$(cat Subdomains/Wayback-file/aspx-file.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"

  cat Subdomains/Wayback_URLS/all.txt | grep -aEo 'https?://[^ ]+' | sed 's/]$//' | sort -u| grep -aEi "\.(jsp)" >> Subdomains/Wayback-file/Jsp-file.txt
  echo -e "\e[36m       \_Final Jsp file  count: \e[32m$(cat Subdomains/Wayback-file/Jsp-file.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"

  echo -e "${GREEN} Start Filter Js file ${ENDCOLOR}"
  cat Subdomains/Wayback-file/Js-file.txt | sort -u | httpx -content-type | grep 'application/javascript' | cut -d' ' -f1 > Subdomains/Wayback-file/javascript-200.txt &>/dev/null
  echo -e "\e[36m      \_Final Filter Js file  count: \e[32m$(cat Subdomains/Wayback-file/javascript-200.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  httpx -l Subdomains/Wayback-file/javascript-200.txt -match-string "js.map" -o Subdomains/Wayback-file/Secrets/javascript-map.txt &>/dev/null
  echo -e "${GREEN}Starting Js Scan ${ENDCOLOR}"
  cat Subdomains/Wayback-file/javascript-200.txt  | nuclei -t $HOME/tools/nuclei-templates/exposures/ -o Subdomains/Wayback-file/Secrets/nuclei-javascript.txt &>/dev/null
  echo -e "\e[36m    \_Final Secret  count: \e[32m$(cat Subdomains/Wayback-file/Secrets/nuclei-javascript.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"

  #after collect key run these comannd on key nuclei -t $HOME/nuclei-templates/token-spray -var token=vt70wYM90ZixRqNPSqYC2FLokqpcZsYqvwc5NS04z6pIibNI63M814r
  echo -e "${YELLOW}Scan Js File Done ${ENDCOLOR} " 
  echo -e " Scan Js File Done " | notify &>/dev/null

  }
vulnscan(){
  mkdir Subdomains/Nuclei/sub 
  mkdir Subdomains/Nuclei/port 
  echo -e "${GREEN} Starting Subdomain Vulnerability Scan: ${ENDCOLOR}"
  cat Subdomains/Subdomains/livesub.txt | nuclei -severity critical -o Subdomains/Nuclei/sub/critical.txt &>/dev/null
  echo -e "\e[36m    \_Final Ciritcal Vuln  count: \e[32m$(cat Subdomains/Nuclei/sub/critical.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  cat Subdomains/Subdomains/livesub.txt | nuclei -severity high -o Subdomains/Nuclei/sub/high.txt &>/dev/null
  echo -e "\e[36m    \_Final high Vuln  count: \e[32m$(cat Subdomains/Nuclei/sub/high.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  cat Subdomains/Subdomains/livesub.txt | nuclei -severity medium -o Subdomains/Nuclei/sub/meduim.txt &>/dev/null
  echo -e "\e[36m    \_Final medium Vuln  count: \e[32m$(cat Subdomains/Nuclei/sub/meduim.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  cat Subdomains/Subdomains/livesub.txt | nuclei -severity low -o Subdomains/Nuclei/sub/low.txt &>/dev/null
  echo -e "\e[36m    \_Final low Vuln  count: \e[32m$(cat Subdomains/Nuclei/sub/low.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  cat Subdomains/Subdomains/livesub.txt | nuclei -severity info -o Subdomains/Nuclei/sub/info.txt &>/dev/null
  echo -e "\e[36m    \_Final info Vuln  count: \e[32m$(cat Subdomains/Nuclei/sub/info.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  echo -e "${YELLOW} scan Sub_Vuln done ${ENDCOLOR} "
  echo -e " scan Sub_Vuln done  " | notify &>/dev/null



  #vuln_ports
  echo -e "${GREEN}Starting Ports vulnerability scan: ${ENDCOLOR}"

  cat Subdomains/nabuu/liveport.txt | nuclei -severity critical -o Subdomains/Nuclei/port/critical.txt &>/dev/null
  echo -e "\e[36m    \_Final Ciritcal Vuln  count: \e[32m$(cat Subdomains/nabuu/liveport.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"

  cat Subdomains/nabuu/liveport.txt | nuclei -severity high -o Subdomains/Nuclei/port/high.txt &>/dev/null
  echo -e "\e[36m    \_Final high Vuln  count: \e[32m$(cat Subdomains/Nuclei/port/high.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"

  cat Subdomains/nabuu/liveport.txt | nuclei -severity medium -o Subdomains/Nuclei/port/meduim.txt &>/dev/null
  echo -e "\e[36m    \_Final medium Vuln  count: \e[32m$(cat Subdomains/Nuclei/port/meduim.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"

  cat Subdomains/nabuu/liveport.txt | nuclei -severity low -o Subdomains/Nuclei/port/low.txt &>/dev/null
  echo -e "\e[36m    \_Final low Vuln  count: \e[32m$(cat Subdomains/Nuclei/port/low.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"

  cat Subdomains/nabuu/liveport.txt | nuclei -severity info -o Subdomains/Nuclei/port/info.txt &>/dev/null
  echo -e "\e[36m    \_Final info Vuln  count: \e[32m$(cat Subdomains/Nuclei/port/info.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"

  echo "${YELLOW} scan Sub_port_Vuln done ${ENDCOLOR} "
  echo " scan Sub_port_Vuln done  " | notify &>/dev/null



  }
parm(){
  echo -e "${GREEN}Start Parameter Discovery:${ENDCOLOR} "
  for x in $(cat Subdomains/Subdomains/Final_Subdomains.txt )
  do
  python3 $HOME/tools/ParamSpider/paramspider.py  --domain $x &>/dev/null
  done
  cat output/* >> Subdomains/Subdomains/parmater.txt
  echo -e "\e[36m    \_Final Parameter  count: \e[32m$(cat Subdomains/Subdomains/parmater.txt  | tr '[:upper:]' '[:lower:]'| anew | grep -v " "|grep -v "@" | grep "\." | wc -l)\e[0m"
  echo "${YELLOW} Parameter Discovery Done${ENDCOLOR} "
  echo -e " Parameter Discovery Done " | notify &>/dev/null

  }

  end(){
    echo -e "Finished all Recon , Hope find ${RED}P1${ENDCOLOR} Bugs.  Happy Hunting 😊 "
  }

all(){
  file
  subdomain
  portscan
  wapplyzer
  shodan
  waybackurls
  js_file
  parm
  vulnscan
  end
  }
subdomains(){
  echo -e "\e[94mEnter the organisation name (E.g.,Facebook): \e[0m"
  read company
  mkdir  -p $company
  cd $company
  mkdir  -p Subdomains/ 
  cd Subdomains
  mkdir  -p Subdomains/ Screen-Shoot/ Trash/
  cd ../
  subdomain
}
usage(){    
    echo -e ""
    echo -e "Usage: RecoX [OPTIONS] [PATH to domain/domainfile] [Scan flag]"
    echo -e "${GREEN}Example Usage${ENDCOLOR}"
    echo -e " ./recon_x.sh -dl ~/user/domains_file.txt -a"
    echo -e ""
    echo -e "${GREEN}Flags:${ENDCOLOR}"
    echo -e "   -dl, --domain-list                Add your domain file                               "
    echo -e "   -d, --domain                      Add your domain                                    "
    echo -e "   -a,  --all                        Run All scans                                      "
    echo -e "   -s, --subdomain                   Run Subdomain enumration                           "
    echo -e "   -h, --help                        show usage                                         "
    exit 0
}
#@> ARGUMENTS
while [ -n "$1" ]; do
    case $1 in
            -dl|--domain-list)
                domain=$2
                shift ;;
            -a|--all)
                all
                shift ;;
            -s|--subdomain)
                subdomains
                shift ;;
            -h|--help)
                usage
                shift ;;
            *)
                usage
    esac
    shift
done
