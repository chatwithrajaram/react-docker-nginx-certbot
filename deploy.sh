#!/bin/bash
function install_asdf(){
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
    echo '/root/.asdf/asdf.sh' >> ~/.bashrc
    chmod +x /root/.asdf/asdf.sh
    source ~/.bashrc
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs 16.15.1
    asdf global nodejs 16.15.1
    node -v
    npm -v
}

function generate_build(){
    echo "Preparing to build..."
    datetime=$(date +%Y-%m-%d-%H-%M-%S)
    cd ./app
    rm -rf node_modules
    npm install
    npm run build
    cd ..
    tar -cjf backup-build-$datetime.tar.bz2 data/nginx/html
    rm -rf ./data/nginx/html/build
    mv ./app/build ./data/nginx/html/build
    echo "Build generated!"
    rm -rf ./app/node_modules
}
if ! [ -x "$(command -v asdf)" ]; then
  echo 'Error: asdf not installed.' >&2
  echo "Instaliing packages..."
  rm -rf ~/.asdf
  install_asdf;
fi

generate_build
docker-compose restart nginx