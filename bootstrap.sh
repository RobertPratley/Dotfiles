files=".bash_profile .aliases .bash_prompt .hushlogin .inputrc .macos"
for file in $files; do
	printf ">> Creating symlink to $file in home directory\n"
	ln -s $HOME/src/Dotfiles/$file $HOME/$file
done
printf ">> Symlinks complete.\n—\n—\n—\nSetting up Mac...\n"

printf "Installing Command Line Tools\n"
xcode-select --install

printf "Installing Homebrew...\n"

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

printf ">> Done.\n—\n—\n—\nInstalling binaries and casks...\n"

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle -v

brew cask cleanup
brew cleanup

printf ">> Done.\n—\n—\n—\nSetting Mac preferences...\n"

# Set macOS preferences
source .macos
printf ">> Done.\n—\n—\n—\nThe following applications have preferences to be synced."

# Preference files to be symli""nked from an external directory
declare -a appprefs=("Alfred" "Github Desktop" "Glyphs" "Sublime Text")

# Print list to terminal
for app in "${appprefs[@]}"; do printf "$app"; done
printf "Install the above, open, quit, and set up Google Drive to continue. When complete, type 'y': "
read drivesetup
[[ "$drivesetup" == 'y' ]] && printf "Syncing application preferences...\n"

# Symlink application preferences form Google Drive/Configs to /Library/Application support/

# declare application names (as located in ~/Library/Application Preferences/)
declare -a apps=("Alfred 3" "Github for Mac" "Sublime Text 3")

for item in "${apps[@]}"; do rm -r ~/Library/Application\ Support/"$item" && ln -sf ~/Google\ Drive/Configs/"$item" ~/Library/Application\ Support/ && printf "$item preferences symlinked\n"; done

#rm -r ~/Library/Application\ Support/Alfred\ 3/ && ln -sf ~/Google\ Drive/Configs/Alfred\ 3/ ~/Library/Application\ Support/
#rm -r ~/Library/Application\ Support/Github\ for\ Mac/ && ln -sf ~/Google\ Drive/Configs/Github\ for\ Mac/ ~/Library/Application\ Support/
# rm -r ~/Library/Application\ Support/Glyphs && ln -sf ~/Google\ Drive/Configs/Glyphs ~/Library/Application\ Support/
#rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/ && ln -sf ~/Google\ Drive/Configs/Sublime\ Text\ 3/ ~/Library/Application\ Support/

# symlink glyphs scripts to ~/src
# ln -sf ~/Google\ Drive/Configs/Glyphs/Scripts/* ~/src/Glyphs\ Scripts/