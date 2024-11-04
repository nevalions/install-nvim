#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Step 0: Check and install prerequisites
echo "Checking for required tools..."

# Check for curl
if ! command_exists curl; then
    echo "curl not found. Installing curl..."
    sudo apt update && sudo apt install -y curl
fi

# Check for unzip 
if ! command_exists unzip; then 
echo "unzip not found. Installing unzip..." 
sudo apt update && sudo apt install -y unzip 
fi

# Check for git 
if ! command_exists git; then
echo "git not found. Installing git..."
sudo apt update && sudo apt install -y git 
fi

# Step 1: Create fonts directory
mkdir -p ~/.local/share/fonts

# Step 2: Download JetBrains Mono Nerd Font
echo "Downloading JetBrains Mono Nerd Font..."
curl -Lo ~/.local/share/fonts/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip

# Step 3: Unzip the font
echo "Unzipping JetBrains Mono Nerd Font..."
unzip ~/.local/share/fonts/JetBrainsMono.zip -d ~/.local/share/fonts

# Step 4: Refresh the font cache
echo "Refreshing font cache..."
fc-cache -fv

# Step 5: Verify the font installation
echo "Verifying font installation..."
fc-list | grep "JetBrainsMono"

# Step 6: Update package list and install necessary packages with apt
echo "Updating package list..."
sudo apt update

echo "Installing packages with apt..."
sudo apt install -y neovim nodejs npm ripgrep git xclip python3-pip fzf

# Additional Debian/Ubuntu tools (substitute `lazygit`, `gdu`, `bottom` if not in official repos)
echo "Installing lazygit, gdu, and bottom from third-party repos..."

# Install lazygit
sudo add-apt-repository ppa:lazygit-team/release -y
sudo apt update && sudo apt install -y lazygit

# Install gdu
sudo wget -qO /usr/local/bin/gdu https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64
sudo chmod +x /usr/local/bin/gdu

# Install bottom (system monitoring tool)
sudo wget -qO- https://github.com/ClementTsang/bottom/releases/latest/download/bottom_x86_64-unknown-linux-musl.tar.gz | tar xvz -C /usr/local/bin --strip-components 1 btm

# Step 7: Clean existing Neovim configurations
echo "Removing existing Neovim configuration..."
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# Step 8: Clone new Neovim configuration from GitHub
echo "Cloning Neovim configuration..."
git clone https://github.com/nevalions/nvim.git ~/.config/nvim

# Step 9: Launch Neovim
echo "Launching Neovim..."
nvim
