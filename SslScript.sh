rm -rf /opt/sslcert/$2_processmaker_net.conf
cp /opt/sslcert/template.conf /opt/sslcert/$2_processmaker_net.conf
sed -i "/server_name template.processmaker.net;/c\server_name $2.processmaker.net;" /opt/sslcert/$2_processmaker_net.conf
if [[ -z "$3" ]];
then
    sed -i "/proxy_pass              http:\/\/10.100.100.100;/c\proxy_pass              http:\/\/$1;" /opt/sslcert/$2_processmaker_net.conf
else
    sed -i "/proxy_pass              http:\/\/10.100.100.100;/c\proxy_pass              http:\/\/$1:$3;" /opt/sslcert/$2_processmaker_net.conf
fi
mv /opt/sslcert/$2_processmaker_net.conf /etc/nginx/conf.d/
if ! nginx -t ; then exit 1 ; fi
if ! nginx -s reload ; then exit 1 ; fi
certbot --nginx -d $2.processmaker.net -m devops@processmaker.net  --agree-tos <<EOF
n
1
EOF
exit 0