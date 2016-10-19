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
brew bundle

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

# declare application names (as located in ~/Library/Application Preferences/)
declare -a apps("Alfred\ 3/" "Github\ for\ Mac/" "Sublime\ Text\ 3/")

for item in "${apps[@]}"; do rm -r ~/Library/Application\ Support/$item && ln -sf ~/Google\ Drive/Configs/$item ~/Library/Application\ Support/ && echo "$app preferences symlinked" | sed 's/[\/]//g'; done

#rm -r ~/Library/Application\ Support/Alfred\ 3/ && ln -sf ~/Google\ Drive/Configs/Alfred\ 3/ ~/Library/Application\ Support/
#rm -r ~/Library/Application\ Support/Github\ for\ Mac/ && ln -sf ~/Google\ Drive/Configs/Github\ for\ Mac/ ~/Library/Application\ Support/
# rm -r ~/Library/Application\ Support/Glyphs && ln -sf ~/Google\ Drive/Configs/Glyphs ~/Library/Application\ Support/
#rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/ && ln -sf ~/Google\ Drive/Configs/Sublime\ Text\ 3/ ~/Library/Application\ Support/

# symlink glyphs scripts to ~/src
# ln -sf ~/Google\ Drive/Configs/Glyphs/Scripts/* ~/src/Glyphs\ Scripts/