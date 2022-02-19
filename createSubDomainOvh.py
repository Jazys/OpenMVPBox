#!/usr/bin/python

import sys
import json
import ovh
import time
import requests

URL="https://automate.omvpb.ovh/webhook/733c905d-5469-4ed6-8561-85b33ba17754"

if len(sys.argv)!= 7:
  print ("Il manque des arguments, vous devez entrer application_key, application_secret, consumer_api, nom de domaine, sous-domaine et ip")
  PARAMS = {'code':1}
  r = requests.get(url = URL, params =PARAMS )
else:
  try:
   client = ovh.Client(
       endpoint='ovh-eu',               # Endpoint of API OVH Europe (List of available endpoints)
       application_key=sys.argv[1],    # Application Key
       application_secret=sys.argv[2], # Application Secret
       consumer_key=sys.argv[3],       # Consumer Key
   )

   result = client.post('/domain/zone/'+sys.argv[4]+'/record', 
       fieldType='A',
       subDomain=sys.argv[5], 
       target=sys.argv[6],
       ttl=60, )
   print ("Creation avec succès")
   time.sleep(10)
   result = client.post('/domain/zone/'+sys.argv[4]+'/refresh')
   print ("Refresh avec succès")
   PARAMS = {'code':0}
   r = requests.get(url = URL, params =PARAMS )
  except Exception as ex:
   print(ex)
   PARAMS = {'code':str(ex)}
   r = requests.get(url = URL, params =PARAMS )

