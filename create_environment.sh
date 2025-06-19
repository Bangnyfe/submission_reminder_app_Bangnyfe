#!/bin/bash
# Prompt the user to enter their username
read -p "Enter your name: " user_name
sub_dir="submissions_reminder_${user_name}"

# Creating submissions_reminder_${user_name} directory
echo "Creating a directory for the user"
mkdir -p $sub_dir/{app,modules,assets,config}

# Creating the required files with thier content inside the directory
cat > "$sub_dir/app/reminder.sh" << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

cat > "$sub_dir/modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

cat > "$sub_dir/assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Burnice, Git, submitted
Lycaon, Shell Navigation, submitted
Nicole, Shell Basics, not submitted
Harumasa, Git, not submitted
Yixuan, Shell Navigation, submitted
EOF

cat > "$sub_dir/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
echo "The necessary files have been created in their respective sub-directories"

echo "5 more student records have been added to submissions.txt"

# Creating startup.sh inside the directory
cat <<'EOF'> "$sub_dir/startup.sh"
#!/bin/bash
./app/reminder.sh
EOF

# Making all .sh files executable
find . -type f -name "*.sh" -exec chmod +x {} \;

echo "Environment has successfully been created for the user"
