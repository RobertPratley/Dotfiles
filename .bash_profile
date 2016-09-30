export PS1='\[\e[33m\]\w:\[\e[m\] $\[\e[m\] '
export CLICOLOR=1
echo 'Weclome Rob.'
# Make Tab autocomplete regardless of filename case
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias c='clear'
alias s='subl'
alias ..='cd ..'
alias ...='cd ../../'
# Recursively remove .DS_Store files
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"
