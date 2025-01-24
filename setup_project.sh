#!/bin/bash

# Setup Script to Install Dependencies, Clone Repo, and Generate main.sh

# Function to check and install required dependencies
install_dependencies() {
  echo "Installing required dependencies..."
  
  # Update package list
  sudo apt update
  
  # Install git, curl, jq, and any other dependencies
  sudo apt install -y git curl jq
  
  # Check if Node.js is needed
  echo "Do you need Node.js for this project? (yes/no)"
  read -r install_node
  if [[ $install_node == "yes" ]]; then
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt install -y nodejs
  fi
  
  # Check if Python is needed
  echo "Do you need Python for this project? (yes/no)"
  read -r install_python
  if [[ $install_python == "yes" ]]; then
    sudo apt install -y python3 python3-pip
  fi

  echo "Dependencies installed successfully!"
}

# Function to clone the repository
clone_repository() {
  echo "Enter the repository URL to clone:"
  read -r repo_url
  echo "Enter the directory where the repo should be cloned (default: current directory):"
  read -r clone_dir
  
  # Use current directory if no directory is specified
  if [[ -z $clone_dir ]]; then
    clone_dir="."
  fi

  # Clone the repository
  echo "Cloning repository..."
  git clone "$repo_url" "$clone_dir" || { echo "Failed to clone repository."; exit 1; }
  
  # Navigate to the repository directory
  repo_name=$(basename "$repo_url" .git)
  cd "$clone_dir/$repo_name" || exit
  echo "Repository cloned into $clone_dir/$repo_name"
}

# Function to generate main.sh
generate_main_script() {
  echo "Generating main.sh script..."
  
  # Create main.sh with executable permissions
  cat <<'EOF' > main.sh
#!/bin/bash

# Main Script for Project Execution

echo "Starting the project..."

# Add your project-specific commands below
# Example: Run a Python script
# python3 script.py

# Example: Start a Node.js application
# node app.js

echo "Project executed successfully!"
EOF

  chmod +x main.sh
  echo "main.sh script created successfully!"
}

# Main script execution
echo "Starting project setup..."

install_dependencies
clone_repository
generate_main_script

echo "Setup completed! You can now run ./main.sh to execute your project."
