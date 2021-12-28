#!/bin/bash

# Print commands and their arguments as they are executed
set -x

# this script is partially based on https://stackoverflow.com/questions/51504367/gpg-agent-forwarding-inappropriate-ioctl-for-device

echo "Creating .gnupg directory"
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
touch ~/.gnupg/gpg.conf

echo "use-agent" >> ~/.gnupg/gpg.conf
echo "pinentry-mode loopback" >> ~/.gnupg/gpg.conf
touch ~/.gnupg/gpg-agent.conf
echo "allow-loopback-pinentry" >> ~/.gnupg/gpg-agent.conf

echo "Reloading GPG agent"
echo RELOADAGENT | gpg-connect-agent

echo "Generating GPG key"
gpg --batch --passphrase '' --quick-gen-key "Name_test (Testing) <email_test@xxx.com>" ed25519 cert 1y

echo "Extracting GPG key id"
# show-only-fpr-mbox : For each user-id which has a valid mail address print only the fingerprint followed by the mail address.
fpr=$(gpg --list-options show-only-fpr-mbox --list-secret-keys | sed -r -n '$!d;s@^([^[:space:]]+).*@\1@g;p')
touch public_key_id.txt
echo $fpr >> public_key_id.txt

echo "Adding key to GPG store"
gpg --batch --pinentry-mode=loopback --passphrase '' --quick-add-key $fpr ed25519 sign 1y
gpg --batch --pinentry-mode=loopback --passphrase '' --quick-add-key $fpr ed25519 auth 1y
gpg --batch --pinentry-mode=loopback --passphrase '' --quick-add-key $fpr cv25519 encrypt 1y

# --export will export all keys from all keyrings
# --armor is needed to create ASCII armored output as the default is to create the binary OpenPGP format.
gpg --export --armor --output public.gpg

# to export all private keys use:
# gpg --export-secret-keys --armor --output private_key.gpg
