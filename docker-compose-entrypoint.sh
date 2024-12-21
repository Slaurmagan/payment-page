#!/bin/bash
set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

if [ "$RAILS_ENV" == "development" ]; then
  bundle check || bundle install # зависимости проверяются при старте, можно не билдить каждый раз
fi

exec bundle exec "$@"
