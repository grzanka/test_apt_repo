#!/bin/bash

wget --quiet https://github.com/DataMedSci/pymchelper/releases/download/v1.10.4/runmc
mv runmc debpkg

dpkg-deb -b debpkg pymchelper.deb