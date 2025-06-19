# submission_reminder_app_Bangnyfe
# 📬 Submission Reminder App

This application helps identify students who need to be reminded of pending submissions for a specific assignment. It reads through the lines in the submissions.txt file, then displays those students who have the 'not submitted'.
The application also allows the user to update the assignment name in order to check for other pendning assignments.
---

The steps to run the application are as follows:
# 1. Create the environment
./create_environment.sh

# 2. Run the startup script in the created directory
cd submissions_reminder_{UserName}
./startup.sh

# 3. Run the copilot script to change the current assignment and check for other pending submissions
./copilot_shell_script.sh
