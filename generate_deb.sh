#!/bin/bash

# Print commands and their arguments as they are executed
set -x

#SCRIPTS_NAMES = ('convertmc' 'runmc' 'pld2sobp' 'mcscripter')
SCRIPTS_NAMES=('convertmc' 'runmc')

VERSION='1.10.7'

# we need smaller size, Github Pages has limit 100 MB
for SCRIPT in "${SCRIPTS_NAMES[@]}"
do
    BIN_DIR=pymchelper-${SCRIPT}/usr/bin
    rm --recursive --force ${BIN_DIR}
    mkdir --parents ${BIN_DIR}
    wget --quiet https://github.com/DataMedSci/pymchelper/releases/download/v${VERSION}/${SCRIPT} --output-file=${BIN_DIR}/${SCRIPT}
    chmod +x ${BIN_DIR}/${SCRIPT}

    # for debian <= 7 no compression and old format
    dpkg-deb --root-owner-group -Znone --deb-format=0.939000 --build pymchelper-${SCRIPT} pymchelper-${SCRIPT}-old.deb

    # for all versions use newest format of deb packages
    dpkg-deb --root-owner-group --build pymchelper-${SCRIPT} pymchelper-${SCRIPT}.deb
done

# for debian <= 7 no compression and old format
dpkg-deb --root-owner-group -Znone --deb-format=0.939000 --build pymchelper pymchelper-old.deb
# for all versions use newest format of deb packages
dpkg-deb --root-owner-group --build pymchelper pymchelper.deb

ls -alh *deb