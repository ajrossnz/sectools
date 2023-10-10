#!/usr/bin/python3
#convert nmap output to html

import sys
import os
import xml.etree.ElementTree as ET

# Ensure a filename was passed as argument
if len(sys.argv) != 2:
    print("Usage: python3 reportgen.py afilename.xml")
    sys.exit(1)

# Check if the script is run as root
if os.geteuid() != 0:
    print("This script must be run as root.")
    sys.exit(1)

# Get the input filename from the first command line argument
input_filename = sys.argv[1]

# Determine the output filename by replacing .xml with .html
output_filename = input_filename.replace('.xml', '.html')

try:
    # Parse the XML file
    tree = ET.parse(input_filename)
    root = tree.getroot()
except ET.ParseError as e:
    print(f"Failed to parse {input_filename}: {e}")
    sys.exit(1)

# Open the output file
with open(output_filename, 'w') as file:
    # Write a basic HTML header
    file.write("<html><body>\n")

    # Iterate through the XML elements and write them to the HTML file
    for host in root.iter('host'):
        file.write("<h2>Host</h2>\n")

        for address in host.iter('address'):
            file.write(f"<p>Address: {address.get('addr')}</p>\n")

        for ports in host.iter('ports'):
            for port in ports.iter('port'):
                file.write(f"<p>Port: {port.get('portid')}, "
                           f"Protocol: {port.get('protocol')}, "
                           f"Service: {port.find('service').get('name')}</p>\n")

    # Write the HTML footer
    file.write("</body></html>\n")

#print(f"HTML report has been generated and saved as {output_filename}")
