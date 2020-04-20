#!/bin/bash

# 1. 
# type "sudo visudo"
# and add this line to sudoers to enable password-less sudo for this script
# lukas ALL=(root) NOPASSWD: /home/lukas/dotfiles/start_services.sh

# 2.
# open windows "Task Scheduler Library" (Aufgabenplanung)
# and add another task with the following properties:
# trigger: At log on (Bei Anmeldung)
# action: Start a program
#   C:\Windows\System32\bash.exe
# add arguments:
#   -c "sudo ~/dotfiles/start_services.sh"

service apache2 start
service postgresql start
