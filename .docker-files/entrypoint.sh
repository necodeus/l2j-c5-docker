#!/bin/bash

#########################
## Login Server Config ##
#########################

cd /server/login

CONFIG_FILE="/server/login/config/loginserver.properties"
sed -i 's/ForceGGAuth=True/ForceGGAuth=False/g' $CONFIG_FILE
sed -i 's/ExternalHostname=.*/ExternalHostname=127.0.0.1/g' $CONFIG_FILE
sed -i 's/InternalHostname=.*/InternalHostname=127.0.0.1/g' $CONFIG_FILE
sed -i 's/AcceptNewGameServer = False/AcceptNewGameServer = True/g' $CONFIG_FILE
sed -i 's/ShowLicence = True/ShowLicence = False/g' $CONFIG_FILE
sed -i 's/URL=jdbc:mysql:\/\/localhost\/l2jdb/URL=jdbc:mysql:\/\/db\/l2jdb/g' $CONFIG_FILE
sed -i '/^Password=/c\Password=root' $CONFIG_FILE

echo "Registering the Game Server..." | tee -a /server/login/log/stdout.log
rm -f /server/gameserver/config/hexid.txt
rm -f "/server/login/hexid(server 0).txt"
echo "0" | /server/login/RegisterGameServer.sh | tee -a /server/login/log/stdout.log
cp "/server/login/hexid(server 0).txt" "/server/gameserver/config/hexid.txt"

########################
## Game Server Config ##
########################

cd /server/gameserver

CONFIG_FILE="/server/gameserver/config/server.properties"
sed -i 's/ExternalHostname=.*/ExternalHostname=127.0.0.1/g' $CONFIG_FILE
sed -i 's/InternalHostname=.*/InternalHostname=127.0.0.1/g' $CONFIG_FILE
sed -i 's/URL=jdbc:mysql:\/\/localhost\/l2jdb/URL=jdbc:mysql:\/\/db\/l2jdb/g' $CONFIG_FILE
sed -i '/^Password=/c\Password=root' $CONFIG_FILE

####################
## Database Setup ##
####################

echo "Waiting for database to be ready..." | tee -a /server/login/log/stdout.log

while ! nc -z db 3306; do
  sleep 1
done

DB_IP=$(getent hosts db | awk '{ print $1 }')
echo "Database is ready! IP: $DB_IP" | tee -a /server/login/log/stdout.log

echo "Updating SQL files..." | tee -a /server/login/log/stdout.log
find "/server/sql" -type f -name "*.sql" -print0 | while IFS= read -r -d '' file; do
  sed -i 's/TYPE=MyISAM/ENGINE=MyISAM/g' "$file"
done

echo "Reinitializing the Database..." | tee -a /server/login/log/stdout.log
expect /server/tools/auto_installer.exp >/dev/null 2>&1

/usr/bin/supervisord -c /etc/supervisord.conf
