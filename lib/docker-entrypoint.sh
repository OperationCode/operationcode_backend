#!/bin/bash

set -e

exec bundle exec rake db:migrate
