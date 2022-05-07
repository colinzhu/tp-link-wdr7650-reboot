#TP-link WDR7650 router IP address
ip=192.168.1.2

# Password can be retrieved from F10 in Chrome / Edge when try to login to the router
resp=$(curl http://${ip}/ --data-raw '{"method":"do","login":{"password":"xxxxxxxxx"}}' | grep -o stok.*)
echo $resp

# to extract the token
c1='stok":"'
c2='"}'
token=${resp#*${c1}}
echo $token
token=${token%${c2}}
echo $token

# construct the url
url=http://${ip}/stok=${token}/ds
echo $url

# submit reboot command to the above url
curl "$url" -i --data-raw '{"hyfi":{"reboot_all":null},"method":"do"}'

# write to log file
echo done
echo $(date)--done >> log-reboot.log