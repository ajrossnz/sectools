# sectools
## Various security tools for my own use that I can share ##

**st-dnsenum.sh** - a very fast and very good DNS enumeration service from Security Trails. This *very* basic script just displays a curl output after you enter a domain name as argv[1]. For example: ./st-dnsenum.sh domain.com. You will need a free ST API key: https://securitytrails.com/corp/api

**haveibeenpwned.sh** - MyPwnedChecker - looks up the haveibeenpwned API against an input file of email addresses. You need to purchase an API key from haveibeenpwned 

**xmltojson.py** a nasty python script to take the XML output results of the well known Linux sslscan tool and convert them to JSON format.

**xmltohtml.py** a nasty python script to take the XML output results of NMAP and turn them into a prettier HTML output.

### other stuff ###
** monitor.sh **  simple bash script to monitor for a 200/300 response from a website. If not, it shows an error count. 10 second delay between probes.
