import os
import ovh 
import re
client = ovh.Client()

file = open('ingress_svc-IP.txt') 
content = file.readlines()
file.close()

# Make sure content[1] is an IP address
if('pending' in content[1]):
    exit("The IP address is not yet known")


configFile = open('config.md') 
configContent = configFile.readlines()
configFile.close()
domainName = ''.join(re.findall( r'[a-z]+.', configContent[1] ))
currentSubDomain = ''.join(re.findall( r'[a-z]+.', configContent[3] ))

# content[1] has special characters that won't be accepted, so need to extract IP address only
newIP = re.findall( r'[0-9]+(?:\.[0-9]+){3}', content[1] )

record_id = client.get('/domain/zone/'+domainName+'/record', 
    fieldType='A', 
    subDomain=currentSubDomain,
)

result_change = client.put('/domain/zone/'+domainName+'/record/'+str(record_id[0]), 
    subDomain=currentSubDomain, 
    target=newIP[0],
)

client.post('/domain/zone/'+domainName+'/refresh')