#!/bin/bash

# HEALTH CHECK
echo "#### Running check #### "
python ./manage.py check
# Updates Catalog 
echo "#### Running migrate! ####"
python ./manage.py migrate
echo "#### Running update catalog! ####"
python ./manage.py updatecatalog
echo "#### Running collectstatic! ####"
python ./manage.py collectstatic --noinput

# Transfer static data
mv /var/www/gutendex/static-root /share-static-files/nginx

# Confirm that data has been transferred
if [ -e "/share-static-files/nginx" ]; then
    # Delete original data
    rm -r /var/www/gutendex/static-root/*
fi

echo "#### Running Server! ####"
python ./manage.py runserver --insecure 0.0.0.0:8000 




# Later Cron
# # Sets a cron to update database
# echo "0 0 * * * /usr/local/bin/python /app/manage.py" > /etc/cron.d/mycronjob

# # Give execution rights on the cron job
# chmod 0644 /etc/cron.d/mycronjob

# # Apply the cron job
# crontab /etc/cron.d/mycronjob

# # Start the cron daemon in the foreground (for containers)
# cron -f

