#!/usr/bin/python

import sys
import json
import ovh

if len(sys.argv)!= 7:
  print ("Il manque des arguments, vous devez entrer application_key, application_secret, consumer_api, nom de domaine, sous-domaine et ip")
else:
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
