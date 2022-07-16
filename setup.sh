#!/bin/bash
cwd=$(pwd)
username=$USER

function install_brew {
    echo 'checking if brew is already installed'
    if ! [ -x "$(command -v brew)" ]; then
        echo 'installing brew'
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/$username/.bashrc
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    else
        echo 'brew is already installed'
    fi
}

function install_zsh {
    echo 'installing zsh'
    brew install zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

function install_mackup {
    brew install mackup
}

unameOut="$(uname -s)"

if [ "$unameOut" = "Linux" ]; then
    echo 'running under linux'
    install_brew
    install_zsh
    install_mackup
elif [ "$unameOut" = "Darwin" ]; then
    echo 'running under MacOS'
    install_zsh
    install_mackup
else
    echo 'running under an unsuported OS (probably windows)'
    exit 1
fi