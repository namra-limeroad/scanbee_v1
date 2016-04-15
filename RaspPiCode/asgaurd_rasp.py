import datetime
import time
import json

data_file_name = "/var/www/html/data_file.json"
data_complete_token = "200633410"
print "Welcome to Asguard"
data_list = []
while(1):
	data_file  =  open(data_file_name,"w")
	data = raw_input("")
	if(data == data_complete_token):
			current_time = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
			data_hash = {"time_stamp":current_time, "barcode_data":data_list}
			data_file.write(json.dumps(data_hash))
			data_list = []
			print "Data Loading Complete\n"
			continue
	data_list.append(data)
	

	
