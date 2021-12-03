#!/bin/bash

rm --force pld2sobp
wget --quiet https://github.com/DataMedSci/pymchelper/releases/download/v1.10.4/pld2sobp
wget --quiet https://github.com/DataMedSci/pymchelper/releases/download/v1.10.4/convertmc
wget --quiet https://github.com/DataMedSci/pymchelper/releases/download/v1.10.4/runmc
wget --quiet https://github.com/DataMedSci/pymchelper/releases/download/v1.10.4/mcscripter
chmod +x pld2sobp
chmod +x convertmc
chmod +x runmc
chmod +x mcscripter
mkdir --parents debpkg/usr/bin
mv pld2sobp debpkg/usr/bin
mv convertmc debpkg/usr/bin
mv runmc debpkg/usr/bin
mv mcscripter debpkg/usr/bin

# for debian <= 7 no compression and old format
dpkg-deb --root-owner-group -Znone --deb-format=0.939000 --build debpkg pymchelper_old.deb

# for all versions use newest format of deb packages
dpkg-deb --root-owner-group --build debpkg pymchelper.deb