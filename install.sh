#!/bin/bash



if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if test ! $(which zsh); then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "To install the programs, press ENTER"
read -s -n 1 shouldInstallPrograms  # -s: do not echo input character. -n 1: read only 1 character (separate with space)

# double brackets to test, single equals sign, empty string for just 'enter' in this case...
# if [[ ... ]] is followed by semicolon and 'then' keyword
if [[ $shouldInstallPrograms = "" ]]; then
  echo "Installing programs..."
  brew update
  brew bundle
fi


# Removing any existing zsh config file before symlinking it
rm -rf ~/.zshrc

echo "Creating symlink for zsh dotfile"
ln -s $(pwd)/.dotfiles/zsh/.zshrc ~/.zshrc

echo "Creating folder structure"
mkdir ~/projects && cd projects

echo "Do you want to login to github-cli?"
read -s -n 1 shouldLoginToGithub

if [[ $shouldLoginToGithub = "" ]]; then
    gh auth login
fi


echo "Clone Ookla projects?"

read -s -n 1 shouldCloneOoklaProjects

if [[ $shouldCloneOoklaProjects = "" ]]; then
  echo "Cloning Ookla Projects..."
  echo "........................."
  echo "Enterprise"
  gh repo clone serinus42/downdetector-services-dashboard ~/projects/downdetector-services-dashboard

  echo "Core"
  gh repo clone serinus42/nl.allestoringen ~/projects/nl.allestoringen

  echo "Starting Docker"
  open -a Docker
fi

echo "Set up docker containers?"

read -s -n 1 shouldSetupDockerContainer

if [[ $shouldSetupDockerContainer = "" ]]; then
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
fi
