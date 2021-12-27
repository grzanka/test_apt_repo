#!/bin/bash

# Print commands and their arguments as they are executed
set -x

#SCRIPTS_NAMES = ('convertmc' 'runmc' 'pld2sobp' 'mcscripter')
SCRIPTS_NAMES=('convertmc' 'runmc')

# we need smaller size, Github Pages has limit 100 MB
for SCRIPT in "${SCRIPTS_NAMES[@]}"
do
    BIN_DIR=pymchelper-${SCRIPT}/usr/bin
    rm --recursive --force ${BIN_DIR}
    mkdir --parents ${BIN_DIR}

    # download latest release, exit in case of failure
    wget --quiet https://github.com/DataMedSci/pymchelper/releases/latest/download/${SCRIPT} --output-document=${BIN_DIR}/${SCRIPT} || exit 1;
    chmod +x ${BIN_DIR}/${SCRIPT}

    VERSION=`${BIN_DIR}/${SCRIPT} --version`
    # adjust version
    sed -i "s/Version\:.*/Version\: ${VERSION}/g" pymchelper-${SCRIPT}/DEBIAN/control

    # for debian <= 7 no compression and old format, exit in case of failure
    dpkg-deb --root-owner-group -Znone --deb-format=0.939000 --build pymchelper-${SCRIPT} pymchelper-${SCRIPT}-old.deb || exit 1;

    # for all versions use newest format of deb packages, exit in case of failure
    dpkg-deb --root-owner-group --build pymchelper-${SCRIPT} pymchelper-${SCRIPT}.deb || exit 1;
done

# adjust version, use version of latest script from the loop above
sed -i "s/Version\:.*/Version\: ${VERSION}/g" pymchelper/DEBIAN/control
sed -i "s/\(=dummy\)/\(=${VERSION}\)/g" pymchelper/DEBIAN/control

# for debian <= 7 no compression and old format, exit in case of failure
dpkg-deb --root-owner-group -Znone --deb-format=0.939000 --build pymchelper pymchelper-old.deb || exit 1;
# for all versions use newest format of deb packages, exit in case of failure
dpkg-deb --root-owner-group --build pymchelper pymchelper.deb || exit 1;

ls -alh *deb