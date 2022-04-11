import os
import glob

def folder_userguide(aixlib_dir):
	#file = (glob.glob(ibpsa_dir))
	for root, dirs, files in os.walk(aixlib_dir): 
		#print(root[root.rfind(os.sep)+1:])
		#g = root.split(os.sep)
		#print(dirs)
		if root[root.rfind(os.sep)+1:] == "UsersGuide":
			for file in files:
				if file == "package.order":
					#print(file)
					#print(root+os.sep+file)
					order_file = root+os.sep+file
					print(order_file)
					f = open(order_file, "r") 
					lines = f.readlines()
					f.close()
					new_order_file = open (order_file,"w")
					
					for line in lines:
						#print(line)
						#if line.find("UsersGuide") > -1 :
						if line.strip("\n") != 	"UsersGuide":
							new_order_file.write(line)
							print(line)
					new_order_file.close()
			
	

if  __name__ == '__main__':
	
	aixlib_dir = "AixLib"
	
	folder_userguide(aixlib_dir)