#!/bin/bash

# Fix for read-only file system error in wsl

# source: https://github.com/microsoft/WSL/issues/6220#issuecomment-929661798
sudo e2fsck /dev/sdb -y
sudo d2fsck /dev/sdb -p
