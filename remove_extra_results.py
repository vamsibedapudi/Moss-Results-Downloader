#!/usr/bin/env python3
import sys
from bs4 import BeautifulSoup
import json

index_html_file =  sys.argv[1]
resutls_to_save = int(sys.argv[2])

with open(index_html_file, 'r') as file:
	index_html = file.read()
soup = BeautifulSoup(index_html, "html5lib")

for result_elem in soup.findAll('tr')[(resutls_to_save+1):] :
	result_elem.decompose()

file = open(index_html_file, "w")
file.write(str(soup))
file.close()
