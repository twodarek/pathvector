#!/bin/bash

set -e

echo "format: 1" > manifest.txt
echo "primaryRpm: $(ls pathvector*linux-amd64.rpm)" >> manifest.txt
for f in pathvector*linux-amd64.rpm; do echo "$f-sha1: $(sha1sum $f | cut -d " " -f 1)"; done >> manifest.txt
#TODO(twodarek): Download bgpq4 and other deps here, add them to manifest.txt, and add them to the below zip command

wget https://kojipkgs.fedoraproject.org//packages/bgpq4/1.15/4.fc43/x86_64/bgpq4-1.15-4.fc43.x86_64.rpm
ls bgpq4*.rpm >> manifest.txt
for f in bgpq4*.rpm; do echo "$f-sha1: $(sha1sum $f | cut -d " " -f 1)"; done >> manifest.txt

wget https://kojipkgs.fedoraproject.org//packages/bird2/2.15.1/1.el7/x86_64/bird2-2.15.1-1.el7.x86_64.rpm
ls bird2*.rpm >> manifest.txt
for f in bird2*.rpm; do echo "$f-sha1: $(sha1sum $f | cut -d " " -f 1)"; done >> manifest.txt

zip pathvector-"$(git describe --tags "$(git rev-list --tags --max-count=1)" | cut -c2-)"-arista-amd64.swix manifest.txt pathvector*linux-amd64.rpm
