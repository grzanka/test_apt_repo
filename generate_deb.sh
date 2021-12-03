#!/bin/bash

wget --quiet https://github.com/DataMedSci/pymchelper/releases/download/v1.10.4/pld2sobp
mv pld2sobp debpkg/

dpkg-deb -b debpkg pymchelper.deb