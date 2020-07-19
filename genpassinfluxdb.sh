#!/bin/sh

if [ -f influx_passwords.env ]
then
	echo "The file influx_passwords.env is already present, so password are ready for you "
    echo "and with a good chance the db is already initialised, otherwise just start the stack."
    echo " "
    echo "If you really want to generate new passwords, and know what you are doing (can't be"
    echo "used to reset them, as these variables are only get read during the initialisation of "
    echo "fresh db), delete the influx_passwords.env."
    exit 1
fi
    
# generate 2 passwords based on basic tools and urandom
ADMINPASS=`cat /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | fold -w 40 | head -n 1`
USERPASS=`cat /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | fold -w 40 | head -n 1`

echo "INFLUXDB_ADMIN_PASSWORD=$ADMINPASS" > influx_passwords.env
echo "INFLUXDB_USER_PASSWORD=$USERPASS" >> influx_passwords.env

# tell the user what the generated passwords are
echo "The influx_passwords.env was populated with the following passwords:"
echo " "
echo "User: admin Password: $ADMINPASS"
echo "User: user Password: $USERPASS"
echo " "
echo "In ioBroker set in the influxdb history plugin the following settings to connect:"
echo " "
echo "host: influxdb"
echo "port: 8086"
echo "user: user"
echo "password: $USERPASS"
echo "database: iobroker"
echo " "
