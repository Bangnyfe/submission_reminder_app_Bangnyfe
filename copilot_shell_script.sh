#!/bin/bash

# Prompt for new assignment name
read -p "Enter the new assignment name: " new_assign

# Update the ASSIGNMENT value in config/config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=${new_assign}/" ./config/config.env

echo "Assignment updated to '${new_assign}' in config/config.env"

# Re-run the app
echo "Running the reminder application..."
./startup.sh
