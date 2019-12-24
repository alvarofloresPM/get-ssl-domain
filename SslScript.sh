domain=$(echo "$2" | tr . _)
domain=$(echo "$domain" | tr '[:upper:]' '[:lower:]')
subdomain=$(echo "$2" | tr '[:upper:]' '[:lower:]')
rm -rf /opt/sslcert/$domain.conf
if [[ -f /etc/nginx/conf.d/$domain.conf ]]; then exit 1 ; fi
cp /opt/sslcert/template.conf /opt/sslcert/$domain.conf
if [[ $5 = "false" ]]
then
        cp /opt/sslcert/template.conf /opt/sslcert/$domain.conf ;
else
        cp /opt/sslcert/templatePM4.conf /opt/sslcert/$domain.conf ;
        sed -i "/proxy_pass http:\/\/10.100.100.100:6001\/socket.io\/;/c\proxy_pass $4:\/\/$1:6001\/socket.io\/;" /opt/sslcert/$domain.conf
fi
sed -i "/server_name template.processmaker.net;/c\server_name $subdomain;" /opt/sslcert/$domain.conf
sed -i "/return 301 https://template.processmaker.net\$request_uri;/c\return 301 https://$subdomain\$request_uri;" /opt/sslcert/$domain.conf
sed -i "/proxy_pass              http:\/\/10.100.100.100;/c\proxy_pass              $4:\/\/$1:$3;" /opt/sslcert/$domain.conf

mv /opt/sslcert/$domain.conf /etc/nginx/conf.d/
certbot --nginx -d $subdomain -m devops@processmaker.net  --agree-tos <<EOF
n
2
EOF
if ! [[ $3 = "80" ]] && ! [[ $3 = "443" ]] && ! [[ $3 = "6001" ]] && ! [[ $3 = "22" ]] ; then sed -i "/listen 443 ssl; # managed by Certbot/c\listen 443 ssl; listen $3 ssl; # managed by Certbot" /etc/nginx/conf.d/$domain.conf ; fi
if  [[ $5 = "true" ]] ; then sed -i "/#listen 6001 ssl;/c\listen 6001 ssl;" /etc/nginx/conf.d/$domain.conf ; fi
if ! nginx -t ; then exit 1 ; fi
if ! nginx -s reload ; then exit 1 ; fi
exit 0