#!/bin/bash

rm --force pld2sobp
wget --quiet https://github.com/DataMedSci/pymchelper/releases/download/v1.10.4/pld2sobp
chmod +x pld2sobp
mkdir --parents debpkg/usr/bin
mv pld2sobp debpkg/usr/bin

dpkg-deb --root-owner-group --build debpkg pymchelper.deb