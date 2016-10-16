echo ">> Creating src/Dotfiles folder in home directory...\n"
src="$HOME/src/Dotfiles"
mkdir -p $src && cd $src
echo ">> Done.\n—\n—\n—\n>> Cloning dotfiles from github...\n"
git clone https://github.com/RobertPratley/Dotfiles.git .
echo ">> Done.\n—\n—\n—\n"

files=".aliases .bash_prompt .hushlogin .inputrc .macos"
for file in $files; do
	echo ">> Creating symlink to $file in home directory\n"
	ln -s $src/$file $HOME/$file
done
echo ">> Symlinks complete.\n—\n—\n—\nSetting up Mac...\n"


echo "Installing Homebrew...\n"

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo ">> Done.\n—\n—\n—\nInstalling binaries and casks...\n"

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle -v

brew cask cleanup
brew cleanup

echo ">> Done.\n—\n—\n—\nSetting Mac preferences...\n"

# Set macOS preferences
source .macos
echo ">> Done.\n—\n—\n—\nThe following applications have preferences to be synced."

# Preference files to be symlinked from an external directory
declare -a appprefs=("Alfred" "Glyphs" "Sublime Text")

# Print list to terminal
for app in "${appprefs[@]}"; do echo "$app"; done
echo "Install the above and set up Google Drive to continue. When complete, type 'y': "
read drivesetup
[[ "$drivesetup" == 'y' ]] && echo "Syncing application preferences...\n"

# Symlink application preferences form Google Drive/Configs to /Library/Application support/

rm -r ~/Library/Application\ Support/Alfred\ 3/ && ln -sf ~/Google\ Drive/Configs/Alfred\ 3 ~/Library/Application\ Support/
# rm -r ~/Library/Application\ Support/Glyphs && ln -sf ~/Google\ Drive/Configs/Glyphs ~/Library/Application\ Support/
rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/ && ln -sf ~/Google\ Drive/Configs/Sublime\ Text\ 3 ~/Library/Application\ Support/