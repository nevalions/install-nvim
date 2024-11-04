#!/bin/bash

# Get the current user's home directory 
USER_HOME=$(eval echo "~$USER")

# Step 0: Check and install prerequisites
echo "Checking for required tools..."

# Update the package list if necessary
sudo pacman -Sy --needed

# Check for curl
if ! command_exists curl; then
    echo "curl not found. Installing curl..."
    sudo pacman -S --needed curl
fi

# Check for unzip
if ! command_exists unzip; then
    echo "unzip not found. Installing unzip..."
    sudo pacman -S --needed unzip
fi

# Check for git 
if ! command_exists git; then 
    echo "git not found. Installing git..." 
    sudo pacman -S --needed git 
fi


# Step 1: Create fonts directory
mkdir -p ~/.local/share/fonts

# Step 2: Check if JetBrains Mono Nerd Font is already installed
if fc-list | grep -i "JetBrainsMono" >/dev/null 2>&1; then
    echo "JetBrains Mono Nerd Font is already installed."
else
    echo "JetBrains Mono Nerd Font not found. Installing..."

    # Step 2: Create fonts directory
    mkdir -p ~/.local/share/fonts

    # Step 3: Download JetBrains Mono Nerd Font
    echo "Downloading JetBrains Mono Nerd Font..."
    curl -Lo ~/.local/share/fonts/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip

    # Step 4: Unzip the font
    echo "Unzipping JetBrains Mono Nerd Font..."
    unzip -o ~/.local/share/fonts/JetBrainsMono.zip -d ~/.local/share/fonts

    # Step 5: Refresh the font cache
    echo "Refreshing font cache..."
    fc-cache -fv

    # Step 6: Verify the font installation
    echo "Verifying font installation..." fc-list | grep -i "JetBrainsMono" || echo "JetBrains Mono Nerd Font not found in system fonts."
fi

# Step 6: Updating repositories list
echo " Updating repositories list with pacman..."
sudo pacman -Syu

# Step 7: Install necessary packages
echo "Installing packages with pacman..."
sudo pacman -S --needed neovim nodejs npm ripgrep lazygit gdu bottom python xclip fzf

# Step 8: Clean existing Neovim configurations 
echo "Removing existing Neovim configuration..." 
rm -rf "$USER_HOME/.config/nvim" "$USER_HOME/.local/share/nvim" "$USER_HOME/.local/state/nvim" "$USER_HOME/.cache/nvim" 

# Step 9: Clone new Neovim configuration from GitHub 
echo "Cloning Neovim configuration..." 
git clone git@github.com:nevalions/nvim.git "$USER_HOME/.config/nvim"

# Step 10: Launch Neovim
echo "Launching Neovim..."
nvim
