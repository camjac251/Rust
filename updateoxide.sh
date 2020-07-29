#!/bin/bash
# First time, run: sudo apt -y install curl python3 unzip

# Edit Below this line
# Server & steamcmd root paths. Don't use trailing slashes "/"
serverPath="/home/rustserver/serverfiles"
steamcmdPath="/usr/games"
# Edit above this line

oxideVersionLatest=$(curl -s 'https://umod.org/games/rust/latest.json' | python3 -c "import sys, json; print(json.load(sys.stdin)['version'])")
oxideLatestURL=$(curl -s 'https://umod.org/games/rust/latest.json' | python3 -c "import sys, json; print(json.load(sys.stdin)['snapshot_url'])")
oxideVersionInstalled=$(cat oxide.version)
echo "Checking for oxide updates"
if [ "$oxideVersionLatest" != "$oxideVersionInstalled" ] || [ -z "$oxideVersionInstalled" ]
then
    echo "New Oxide Update Found. Version ["$oxideVersionLatest"]"
    echo "$oxideVersionLatest" > oxide.version
    echo "Updating Oxide"
    curl -L "$oxideLatestURL" --output oxide.zip >/dev/null 2>&1
    unzip -o oxide.zip -d /home/container/ >/dev/null 2>&1
    rm oxide.zip >/dev/null 2>&1
    echo "Oxide has been updated"
else
    echo "No update is available"
fi