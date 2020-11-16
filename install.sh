#!/bin/bash

if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "Installing programs..."
brew update
brew bundle

echo "Creating symlink for zsh dotfile"
ln -s $(pwd)/.dotfiles/zsh/.zshrc ~/.zshrc

echo "Creating folder structure"
mkdir ~/projects && cd projects

echo "Cloning Ookla Projects..."
echo "........................."
echo "Enterprise"
gh repo clone serinus42/downdetector-services-dashboard ~/projects/downdetector-services-dashboard

echo "........................."
echo "Core"
gh repo clone serinus42/nl.allestoringen ~/projects/nl.allestoringen

echo "Starting Docker"
open -a Docker

echo "Setting up Enterprise"

cd ~/projects/downdetector-services-dashboard

docker-compose build
docker-compose run --rm load_settings
docker-compose run --rm syncdb
docker-compose run --rm migrate
docker-compose run --rm loaddata

docker stop $(docker ps -a -q)

docker-compose run --rm setup_enterprise

echo "Setting up core"

cd ~/projects/nl.allestoringen

docker-compose build
docker-compose run --rm syncdb
docker-compose run --rm migrate
docker-compose run --rm loaddata

docker stop $(docker ps -a -q)