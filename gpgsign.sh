#!/bin/bash
newkeygen () {
    gpg --full-generate-key;
}
    
read -p "press: 1 To generate new GPG keys. 2 To show existing keys and sign commit: " input

case $input in
    1)
        newkeygen
        gpg --list-secret-keys --keyid-format LONG
        read -p "enter key id of gpg key you want to use: " keyid
        git config --global user.signingkey $keyid
        echo "you can copy following public key to paste on GitHub's gpg key"
        gpg --armor --export $keyid;;
    2)
        gpgkey=$(gpg --list-secret-keys --keyid-format LONG)
        gpgkeysize=${#gpgkey}
        if [ $gpgkeysize ]
        then
            echo "available gpg keys:"
        else
            echo "You do not have any existing gpg key, please generate: "
            newkeygen
        fi
        gpg --list-secret-keys --keyid-format LONG
        read -p "enter key id of gpg key you want to use: " keyid
        git config --global user.signingkey $keyid
        echo "you can copy following public key to paste on GitHub's gpg key"
        gpg --armor --export $keyid;;
esac