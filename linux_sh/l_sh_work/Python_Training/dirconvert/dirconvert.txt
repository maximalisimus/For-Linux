#!/usr/bin/env python3

import sys
import pathlib
import re

def switch(case):
	return {
		"-stdin": 1
	}.get(case, None)

def Enquiry(lis1):
	if len(lis1) == 0:
		return 0
	else:
		return 1

def getRealPath(pathname):
	return str(pathlib.Path(pathname).resolve())
	
def main():
	st_din = False
	directory = ""
	if len(sys.argv) >= 1:
		for count in range(len(sys.argv)):
			if switch(sys.argv[count]) == 1: st_din = True
			else: 
				if Enquiry(sys.argv[count]):
					directory = sys.argv[count]
					st_din = False
	if st_din:
		for line in sys.stdin:
			if Enquiry(line):
				isdir = re.sub("^\s+|\n|\r|\s+$", '', line)
				if pathlib.Path(isdir).exists():
					dirNames = getRealPath(isdir)
					print(dirNames)
				else:
					print("Error!")
					print("Parameter is not the directory <", line, "> !!!")
					print("Please input the working directory !!!")
					print("Exit 1")
	else:
		if Enquiry(directory):
			isdir = re.sub("^\s+|\n|\r|\s+$", '', directory)
			if pathlib.Path(isdir).exists():
				dirNames = getRealPath(isdir)
				print(dirNames)
			else:
				print("Error!")
				print("Parameter is not the directory <", line, "> !!!")
				print("Please input the working directory !!!")
				print("Exit 1")
		else:
			print("Error!")
			print("Parameter is not the directory <", directory, "> !!!")
			print("Please input the working directory !!!")
			print("Exit 1")

if __name__ == "__main__":
	main()
