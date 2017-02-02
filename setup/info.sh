echo " "
echo " ===================="
echo " = = =  Notes:  = = ="
echo " ===================="
echo " "

echo " === eth1 ip (VB host only network ip) ==="
    ip=`ip a show eth1 | grep inet | cut -c10- | cut -d' ' -f1,8- | head -n 1`
    echo $ip
echo " "
echo "User: testadmin@domain.tld"
echo "Password: changeme"
echo " "
echo " Please note that you need to change your hosts file to point to the host ip"
echo " you can now open http://doportal"
