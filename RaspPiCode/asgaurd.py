import datetime
import time
import json

data_file_name = "data_file.txt"
data_complete_token = "22222336"
print "Welcome to Asguard"
data_list = []
while(1):
	data_file  =  open(data_file_name,"w")
	data = raw_input("").split(" ")
	if(data[0] == "exit"):
			break
	machine_id = data[0]
	if(data[1] == data_complete_token):
			current_time = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
			data_hash = {"timestamp":current_time, "barcode_data":data_list, "machine_id":machine_id}
			data_file.write(json.dumps(data_hash))
			data_list = []
			print "Data Loading Complete\n"
			continue
	data_list.append(data[1])
	

	
