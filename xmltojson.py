#!/usr/bin/python3
# Converts the SSLSCAN XML output to JSON
# Nasty script by Alistair Ross - June 2023

import sys
import json
import xmltodict
import re

# Ensure a filename was passed as argument
if len(sys.argv) != 2:
    print("Usage: python3 convert.py afilename.xml")
    sys.exit(1)

# Get the input filename from the first command line argument
input_filename = sys.argv[1]

# Determine the output filename by replacing .xml with .json
output_filename = input_filename.replace('.xml', '.json')

with open(input_filename, 'r') as f:
    xml_string = f.read()

# Check if <host> tag exists and closing </host> tags are missing after </hostname> and add them
if "<host>" in xml_string and re.search(r'(?<=</hostname>)(?!<\/host>)', xml_string):
    xml_string = re.sub(r'(?<=</hostname>)', '</host>', xml_string)

json_data = json.dumps(xmltodict.parse(xml_string))

with open(output_filename, 'w') as f:
    f.write(json_data)

print(f"JSON data has been generated and saved as {output_filename}")
