#!/bin/bash
function install_asdf(){
    git clone git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
    echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
    source ~/.bashrc
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs 16.15.1
    asdf global nodejs 16.15.1
    node -v
    npm -v
}