#!/bin/bash
serveur='127.0.0.0.1'
baseCommande ='swift -A http://'+$serveur+':6007/auth/v1.0/ -U demo:demo -K DEMO_PASS '
stat = $baseCommande+'stat '
post = $baseCommande+'post '
delete = $baseCommande+'delete '
upload = $baseCommande+'upload '
auth = $baseCommande+'auth '
list = $baseCommande+'list '
copy= $baseCommande+'copy '
download = $baseCommande+'download '
### simulation


$post+'test'
