# Don't forget to install brew tap Homebrew/bundle

# specify a directory to install
cask_args appdir: '/Applications'
# install packages
tap "homebrew/bundle"
tap "homebrew/cask" || true
tap "homebrew/cask-fonts"
tap "homebrew/cask-versions"
tap "homebrew/core"

brew "zsh"
brew "autojump"
brew "bash-completion"
brew "gh"
brew "git"
brew "htop"
brew "mas"
brew "nvm"
brew "node"
brew "speedtest-cli"
brew "tree"
brew "wget"
brew "zsh-syntax-highlighting"
brew "romkatv/powerlevel10k/powerlevel10k"

cask "docker" unless system 'which docker'
cask "droplr"
cask "font-fira-code"
cask "font-meslo-lg"
cask "google-chrome" unless system '[ -d "/Applications/Google Chrome.app" ]'
cask "iterm2"
cask "microsoft-auto-update"
cask "microsoft-edge"
cask "rectangle"
cask "skype"
cask "slack"
cask "spotify" unless system '[ -d "/Applications/Spotify.app" ]'
cask "vanilla"
cask "visual-studio-code" unless system '[ -d "/Applications/Visual Studio Code.app" ]'
cask "whatsapp" unless system '[ -d "/Applications/WhatsApp.app" ]'
cask "zoomus"

mas 'Parallel Desktops', id: 1085114709
mas 'Times', id: 1048770312
mas 'HP Smart', id: 1474276998
