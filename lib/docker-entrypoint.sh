#!/bin/bash

set -e

bundle exec rake db:migrate || bundle exec rake db:setup

exec bundle exec "$@"
