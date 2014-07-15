runuser -l postgres -c "initdb -D /var/lib/pgsql/data/"
runuser -l postgres -c "pg_ctl -D /var/lib/pgsql/data/ -l logfile start"
sleep 5
runuser -l postgres -c "createuser -h 127.0.0.1 -p 5432 -U postgres -S -D -R rhqadmin"
runuser -l postgres -c "createdb -h 127.0.0.1 -p 5432 -U postgres -O rhqadmin rhq"

sed -i -e 's/jboss.bind.address=/jboss.bind.address=0.0.0.0/' /rhq-server-4.12.0/bin/rhq-server.properties
sed -i -e 's/#rhq.storage.seeds=/rhq.storage.seeds=localhost/' /rhq-server-4.12.0/bin/rhq-storage.properties
sed -i -e 's/#rhq.storage.hostname=/rhq.storage.hostname=localhost/' /rhq-server-4.12.0/bin/rhq-storage.properties

/rhq-server-4.12.0/bin/rhqctl install

/rhq-server-4.12.0/bin/rhqctl start

echo "Waiting for server to initialize"
until $(grep -R "Server started" /rhq-server-4.12.0/logs/ > /dev/null)
do
   printf '.'
   sleep 5
done
echo "done."

/rhq-server-4.12.0/bin/rhqctl stop 
#runuser -l postgres -c "pg_ctl -m fast stop"

