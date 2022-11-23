#!/bin/bash
color(){
  RED="\e[31m"
  CYAN="\e[36m"
  ENDCOLOR="\e[0m"
  BLINK="\e[5m"
  BOLD="\e[1m"
  GREEN="\e[32m"
  Yellow="\e[33m"

}


Logo(){
  cat <<"EOF"

         _                         _
       _==/          i     i          \==
     /XX/            |\___/|            \XX\
   /XXXX\            |XXXXX|            /XXXX\
  |XXXXXX\_         _XXXXXXX_         _/XXXXXX|
 XXXXXXXXXXXxxxxxxxXXXXXXXXXXXxxxxxxxXXXXXXXXXXX
 |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|
  XXXXXXXXXXXXX 💀 The_Rec0n_X 💀 XXXXXXXXXXXXXXX
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


#check root 
# if [ $EUID -ne 0 ]
#  then echo -e "${RED} Run it as a Root..! ${ENDCOLOR}";
#  exit
# fi


folders(){
    mkdir -p ~/tools
    mv admin.txt ~/tools
}

golanguage(){
    echo -e "${GREEN}starting intall Go-lang ....${ENDCOLOR}\n"
    goversion=$(curl -ks -L https://go.dev/VERSION?m=text)
    wget https://go.dev/dl/$goversion.linux-amd64.tar.gz -q
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $goversion.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    echo "export PATH=$PATH:/usr/local/go/bin" >> .bashrc
    if command -v go &> /dev/null; then
        echo -e " ${GREEN}Go installed done ${ENDCOLOR}"
    else
        echo -e " ${Yellow}There's a proplem , try to install it  manually ${ENDCOLOR}"
    fi
    rm -rf $goversion.linux-amd64.tar.gz
}



tools(){
    echo -e "${GREEN}starting intall tools ....${ENDCOLOR}\n"
    sudo apt install git > /dev/null 2>&1
    echo -e "- Installing Sublister"
    git clone https://github.com/aboul3la/Sublist3r.git -q ~/tools/Sublist3r
    cd ~/tools/Sublist3r && sudo pip3 install -r requirements.txt > /dev/null 2>&1
    if [ -s ~/tools/Sublist3r/sublister.py ]; then
        echo -e " ${GREEN}Done install Sublist3r  ${ENDCOLOR}"
    else
        echo -e " ${Yellow}FAILED install Sublist3r  ${ENDCOLOR}"
    fi
 
    echo -e "- Installing anew"
    go install github.com/tomnomnom/anew@latest > /dev/null 2>&1
    if [ -f ~/go/bin/anew ]; then
        echo -e " ${GREEN}Done install anew ${ENDCOLOR}"
    else
        echo -e " ${Yellow}Failed install anew  ${ENDCOLOR}"
    fi
    
    echo -e "- Installing naabu"
    go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest > /dev/null 2>&1
    if [ -f ~/go/bin/naabu ]; then
        echo -e " ${GREEN}done install naabu  ${ENDCOLOR}"
    else
        echo -e " ${Yellow}failed install naabu ${ENDCOLOR}"
    fi
    

    echo -e "\n- Installing aquatone"
    wget -q https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip  > /dev/null 2>&1
    unzip aquatone_linux_amd64_1.7.0.zip > /dev/null 2>&1
    mv aquatone /usr/bin/ > /dev/null 2>&1
    rm -rf aquatone* LICENSE.txt README.md
    if command -v aquatone &> /dev/null; then
        echo -e " ${GREEN}done install aquatone ${ENDCOLOR}"
    else
        echo -e " ${Yellow}failed install aquaton ${ENDCOLOR}"
    fi

    echo -e "\n- Installing assetfinder"
    go install github.com/tomnomnom/assetfinder@latest > /dev/null 2>&1
    if [ -f ~/go/bin/assetfinder ]; then
        echo -e " ${GREEN}done install assetfinder  ${ENDCOLOR}"
    else
        echo -e " ${Yellow}failed install assetfinder  ${ENDCOLOR}"
    fi

    echo -e "\n- Installing gau"
    go install github.com/lc/gau/v2/cmd/gau@latest > /dev/null 2>&1
    if [ -f ~/go/bin/gau ]; then
        echo -e " ${GREEN}done install gau ${ENDCOLOR}"
    else
        echo -e " ${Yellow}failed install gau ${ENDCOLOR}"
    fi

    echo -e "\n- Installing notify"
    go install -v github.com/projectdiscovery/notify/cmd/notify@latest > /dev/null 2>&1
    if [ -f ~/go/bin/notify ]; then
        echo -e " ${GREEN}done install notify ${ENDCOLOR}"
    else
        echo -e " ${Yellow}failed install notify ${ENDCOLOR}"
    fi

    echo -e "\n- Installing nuclei"
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest > /dev/null 2>&1
    if [ -f ~/go/bin/nuclei ]; then
        echo -e " ${GREEN}done install nuclei ${ENDCOLOR}"
    else
        echo -e " ${Yellow}failed install nuclei ${ENDCOLOR}"
    fi

    echo -e "\n- Installing subfinder"
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest > /dev/null 2>&1
    if [ -f ~/go/bin/subfinder ]; then
        echo -e " ${GREEN}done install subfinder ${ENDCOLOR}"
    else
        echo -e " ${Yellow}failed install subfinder ${ENDCOLOR}"
    fi
    
    echo -e "- Installing uncover"
    go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest > /dev/null 2>&1
    if [ -f ~/go/bin/uncover ]; then
        echo -e " ${GREEN}done install uncover ${ENDCOLOR}"
    else
        echo -e " ${Yellow}failed install uncover ${ENDCOLOR}"
    fi

    echo -e "\n- Installing httpx"
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest > /dev/null 2>&1
    if [ -f ~/go/bin/httpx ]; then
        echo -e " ${GREEN}done install httpx ${ENDCOLOR}"
    else
        echo -e " ${Yellow}failed install httpx ${ENDCOLOR}"
    fi
    echo -e "\n- Installing webanalyze"
    go install -v github.com/rverton/webanalyze/cmd/webanalyze@latest  > /dev/null 2>&1
    if [ -f ~/go/bin/webanalyze ]; then
        echo -e " ${GREEN}done install httpx ${ENDCOLOR}"
    else
        echo -e " ${Yellow}failed install httpx ${ENDCOLOR}"
    fi



    echo -e "\n- Installing amass"
    go install -v github.com/OWASP/Amass/v3/...@master > /dev/null 2>&1
    if [ -f ~/go/bin/amass ]; then
        echo -e " ${GREEN}done install amass ${ENDCOLOR}"
    else
        echo -e " ${Yellow}failed install amass ${ENDCOLOR}"
    fi

}

all(){
    folders
    golanguage
    tools
    echo -e "\n${GREEN}Finished all thing ${ENDCOLOR}"
    sudo cp ~/go/bin/* /usr/local/bin/ > /dev/null 2>&1
    nuclei -update-templates > /dev/null 2>&1
    webanalyze -update  > /dev/null 2>&1

    echo -e "edit notify config in:${GREEN}$HOME/.config/notify/provider-config.yaml ${ENDCOLOR} "
    echo -e "edit uncover config in:${GREEN}$HOME/.config/uncover/provider-config.yaml ${ENDCOLOR}"
    echo -e "Thanks For installing , if You have bug or Error you can DM at Twitter: ${CYAN} @Yazeed_oliwah${ENDCOLOR} "
}

while true
do
    all
    exit
done
