#!/bin/bash


s3bucket="bhavyasais3bucket/logs"
name="bhavya"

#---------------install apache----------------------
  sudo apt install apache2 -y
        echo "Apache is installed"


sudo systemctl unmask apache2

if [ `service apache2 status | grep running | wc -l` == 1 ]
then
        echo "Apache2 is running"
else
                sudo service apache2 start
        echo "apache2 has started"

fi

#------------------Check if apache is enabled---------
if [ `service apache2 status | grep enabled | wc -l` == 1 ]
then
        echo "Apache2 has already been enabled"
else
                sudo systemctl enable apache2
        echo "Apache2 is enabled"
fi

timestamp=$(date '+%d%m%Y-%H%M%S')

#------------------Converting to tar file ----------------------

cd /var/log/apache2/
tar -cvf /tmp/${bhavya}-httpd-logs-${timestamp}.tar *.log

sudo apt-get install awscli -y

aws s3 \
cp /tmp/${bhavya}-httpd-logs-${timestamp}.tar \
s3://${s3bucket}/${bhavya}-httpd-logs-${timestamp}.tar

if [ -e /var/www/html/inventory.html ]
then
        echo "Inventory is existing"
else
        touch /var/www/html/inventory.html
        echo "<b>Log Type &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date Created &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type &nbsp;&nbsp;$
fi
echo "<br>httpd-logs &nbsp;&nbsp;&nbsp;&nbsp; ${timestamp} &nbsp;&nbsp;&nbsp;&nbsp; tar &nbsp;&nbsp;&nbsp;&nbsp; `du -h $
if [ -e /etc/cron.d/automation ]
then
        echo "Cron job exists"
else
        touch /etc/cron.d/automation
        echo "0 0 * * * root /root/Automation_Project/automation.sh" > /etc/cron.d/automation
        echo "Cron job is added"
fi
