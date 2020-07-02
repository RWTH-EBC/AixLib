
import time

def time_counter():
	print("test")
	value = False
	Counter = 0
	while value == False:
		print("This is printed immediately.")
		time.sleep(2.4)
		print("This is printed after 2.4 seconds.")
		Counter = Counter +1
		if Counter > 5:
			value = True
	print("fertig")




if  __name__ == '__main__':
	time_counter()