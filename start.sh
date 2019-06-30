#!/bin/sh
PORT=$1
ENVIRONMENT=$2

export RAILS_ENV=$2

DEFAULT_ROOT_PATH=/
export ROOT_PATH=${ROOT_PATH:-$DEFAULT_ROOT_PATH}

echo "Setup DB without a migration"
#Check, whether Database exist or migration is needed
rails db:version || rails db:create && rails db:migrate

if [ $ENVIRONMENT == 'development' ]; then
        echo "Bundle install"
        bundle install
fi

echo "Clearing Temp-Files"
rm -f /app/tmp/pids/server.pid

#Start Server
bundle exec rails s -p $PORT -b '0.0.0.0' -e $ENVIRONMENT
