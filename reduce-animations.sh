#!/bin/bash

# NSGlobalDomain
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false
defaults write NSGlobalDomain QLPanelAnimationDuration -float 0
defaults write NSGlobalDomain NSScrollViewRubberbanding -bool false
defaults write NSGlobalDomain NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write NSGlobalDomain NSToolbarFullScreenAnimationDuration -float 0
defaults write NSGlobalDomain NSBrowserColumnAnimationSpeedMultiplier -float 0
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Accessibility (needs Full Disk Access for the terminal)
defaults write com.apple.universalaccess reduceMotion -bool true
# defaults write com.apple.universalaccess reduceTransparency -bool true

# Dock
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock mineffect -string "scale"

# Mission Control / Spaces
defaults write com.apple.dock expose-animation-duration -float 0
defaults write com.apple.dock workspaces-edge-delay -float 0

# Launchpad (removed in macOS 26)
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0
defaults write com.apple.dock springboard-page-duration -float 0

# Finder
defaults write com.apple.finder DisableAllAnimations -bool true

# Mail
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Restart affected processes
killall Dock Finder SystemUIServer
