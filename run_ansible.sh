#! /bin/bash

set -e

# Add -vvvv to run in verbose mode
ansible-playbook rpi-plexserver.yaml -i hosts -vv