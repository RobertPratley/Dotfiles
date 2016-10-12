SRC="$HOME/src"
mkdir -p $SRC && cd $SRC

git clone --recursive https://github.com/RobertPratley/Dotfiles.git

echo "Setting up Mac..."


# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Set macOS preferences
source .macos