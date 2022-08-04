import os
import argparse

def folder_userguide(aixlib_dir):
	for root, dirs, files in os.walk(aixlib_dir):
		if root[root.rfind(os.sep)+1:] == "UsersGuide":
			for file in files:
				if file == "package.order":
					order_file = root+os.sep+file
					f = open(order_file, "r")
					lines = f.readlines()
					f.close()
					new_order_file = open (order_file, "w")
					for line in lines:
						if line.strip("\n") != "UsersGuide":
							new_order_file.write(line)
							print(line)
					new_order_file.close()
			
	

if  __name__ == '__main__':
	parser = argparse.ArgumentParser(description="Set Github Environment Variables")
	check_test_group = parser.add_argument_group("Arguments to set Environment Variables")
	check_test_group.add_argument("-ad", "--aixlib-dir", default="AixLib", help="path to the aixlib scripts")
	args = parser.parse_args()
	folder_userguide(args.aixlib_dir)