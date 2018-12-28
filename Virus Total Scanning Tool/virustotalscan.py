__author__ = 'John Melody Melissa'
__version__= 'v1.1.0'
import json 
import urllib

"""
Submits single IP entry to VT IP scanner API and returns total AV detected file results
With public API only 4 requests/min are allowed. You will get an email registered to the account
if you repeatedly violate this threshold
"""

#Asks for user input of an IP and converts to a string for passing to virustotal
ipaddress = raw_input('Enter an IP address to scan: \n')
ipaddress = str(ipaddress)

#Virus total API info
url = 'https://www.virustotal.com/vtapi/v2/ip-address/report'
parameters = {'ip': ipaddress,
              'apikey': ''} ##### ENTER YOUR VIRUSTOTAL API KEY HERE #####

#URL encoding, IP submission, and json response storage
response = urllib.urlopen('%s?%s' % (url, urllib.urlencode(parameters))).read()
response_dict = json.loads(response)

#harvest important info from JSON response
positiveResults = 0
totalResults = 0
try:
    for x in response_dict.get("detected_referrer_samples"):
        positiveResults = positiveResults + x.get("positives")
        totalResults = totalResults + x.get("total")
except TypeError: #if no results found program throws a TypeError
    print ("No results")

#convert results to string for output formatting
positiveResults = str(positiveResults)
totalResults = str(totalResults)

#print results
print(positiveResults + '/' + totalResults + ' total AV detection ratio')