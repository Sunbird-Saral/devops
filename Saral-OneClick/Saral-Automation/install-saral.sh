#!/bin/bash

# Function to install dependencies for AWS
install_aws_dependencies() {
    echo "Installing Using AWS..."
    # Add commands to install AWS dependencies
cd AWS || exit

# Run Terraform commands

sudo snap install helm --classic
sudo snap install aws-cli --classic


terraform init
terraform plan
terraform apply -auto-approve


#install saral app

cd ../helm || exit

helm install saral-ingress ./saral-ingress-chart

helm install saral-backend ./saral-backend-chart    
    
}

# Function to install dependencies for GCP
install_gcp_dependencies() {
    echo "Installing Using GCP..."
    # Add commands to install GCP dependencies
cd GCP || exit

# Run Terraform commands
sudo snap install aws-cli --classic
sudo snap install helm --classic

terraform init
terraform plan
terraform apply -auto-approve


#install saral app
cd ../helm || exit

helm install saral-ingress ./saral-ingress-chart

helm install saral-backend ./saral-backend-chart
    
}

# Function to install dependencies for Azure
install_azure_dependencies() {
    echo "Installing Using Azure..."
    # Add commands to install Azure dependencies
cd Azure || exit

# Run Terraform commands

sudo snap install aws-cli --classic
sudo snap install helm --classic

terraform init
terraform plan
terraform apply -auto-approve


#install saral app
cd ../helm || exit

helm install saral-ingress ./saral-ingress-chart

helm install saral-backend ./saral-backend-chart
    
}

# Main script
echo "Welcome to Cloud Provider Installation Script"

# Prompt user to choose a cloud provider
echo "Choose your cloud provider:"
echo "1. AWS"
echo "2. GCP"
echo "3. Azure"
read -p "Enter your choice [1-3]: " choice

case $choice in
    1)
        install_aws_dependencies
        ;;
    2)
        install_gcp_dependencies
        ;;
    3)
        install_azure_dependencies
        ;;
    *)
        echo "Invalid choice. Please enter a number between 1 and 3."
        ;;
esac

