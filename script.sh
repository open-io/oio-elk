#!/bin/bash
serveur="127.0.0.1"
basecommande="swift -A http://$serveur:6007/auth/v1.0/ -U demo:demo -K DEMO_PASS"
stat="$basecommande stat"
post="$basecommande post"
delete="$basecommande delete"
upload="$basecommande upload"
auth="$basecommande auth"
list="$basecommande list"
copy="$basecommande copy"
download="$basecommande download"

### simulation




for (( c=1; c<=100; c++ ))
do
   #create a container with a random name
   id=`cat /dev/urandom | tr -dc '0-9' | fold -w 256 | head -n 1 | sed -e 's/^0*//' | head --bytes 3`
   repo="repo-$id"
   $post $repo

   # upload file /etc/network/interfaces
   file="file1.txt"
   $upload $repo $file
   echo "[UPLOAD] $file --> $repo"

   #upload file /etc/hosts
   file="file2.txt"
   $upload $repo $file
   echo "[UPLOAD] $file --> $repo"

   file="file2.txt"
   $download $repo $file
   echo "[DOWNLOAD] $file --> $repo"

   #delete one file  among uploaded
   $delete $repo $file
   echo "[DELETE] $file --> $repo"

done

#print stat, auth and list

$list
$stat
$auth
