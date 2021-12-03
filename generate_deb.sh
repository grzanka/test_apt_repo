#!/bin/bash

rm --force pld2sobp
wget --quiet https://github.com/DataMedSci/pymchelper/releases/download/v1.10.4/pld2sobp
chmod +x pld2sobp
mkdir --parents debpkg/usr/bin
mv pld2sobp debpkg/usr/bin

# for debian <= 7 no compression and old format
dpkg-deb --root-owner-group -Znone --deb-format=0.939000 --build debpkg pymchelper_old.deb

# for all versions use newest format of deb packages
dpkg-deb --root-owner-group --build debpkg pymchelper.deb