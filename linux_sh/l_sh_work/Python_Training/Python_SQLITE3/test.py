#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sqlite3 as sq

db_files = "kernelinfo.db"
# db_files = "emptyinfo.db"

def main():
	with sq.connect(db_files) as dbfiles:
		sqbd = dbfiles.cursor()
		
		sqbd.execute("SELECT * FROM info")
		for result in sqbd:
			print(result[0],"\t",result[1],"\t",result[2],"\t",result[3],"\t",result[4])
		
		sqbd.execute("SELECT COUNT(*) FROM info")
		count = sqbd.fetchone()[0]
		print("count =",count)
		

if __name__ == '__main__':
	main()
