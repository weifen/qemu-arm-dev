#!/usr/bin/python
import re
import sys
import glob
import json

search_dict = json.loads(sys.argv[1])
files = glob.glob(sys.argv[2])


for f in files:
	print("------" + f+ "-----")
	lines = []
	found = None
	for line in open(f, 'r'):
		items = search_dict.keys()
		if(not found):
			for item in items:
				if (re.search(item, line)):
					found = search_dict[item]
					break
		else:
	  		if (found == 'f'):
	  			if (re.search('}',line)):
	  				print(line)
	   				found = None
	   	if (found):
	   		print(line.strip())
	   		if (found == 'sl'):
	   			found = None
           

