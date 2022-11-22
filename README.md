# ReconX 1.0
#Recon The World!
<h4>What ReconX?<h4>
**ReconX**  If An Automation Script For Bug Bounty Hunter This tool allows you to gather some information that should help you identify what to do next and where to look and save your time !

#Usage
Usage: ReconX [OPTIONS] [PATH to domain/domainfile] [Scan flag]
Example Usage
 ./recon_x.sh -dl ~/user/domains_file.txt -a

Flags:
   -dl, --domain-list                Add your domain file
   -d, --domain                      Add your domain
   -a,  --all                        Run All scans
   -s, --subdomain                   Run Subdomain enumration
   -h, --help                        show usage
```

#Installation 
```
git clone https://github.com/YazeedOliwah/reconX.git
cd reconX 
chmod +x install.sh
./install.sh
```

#Features 

- Subdomain enum
- Port scan
- Filter Subdomain and screenshot
- Filter Intrested sub and ports
- Collect ip from shodan  
- Find Admin Panels
- Identify Technology
- Parameter Discovery
- Wayback history 
- Filter php,jsp,aspx,js file from wayback 
- Filter & Scan js file 
- Collect Api-Endpoint
- Vulnerability Scan
- Notify system
