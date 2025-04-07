#!/bin/bash

# Define color codes for terminal output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Define the required screenshot paths
declare -a REQUIRED_SCREENSHOTS=(
    # Docker screenshots
    "screenshots/docker/containers.png"
    "screenshots/docker/images.png"
    "screenshots/docker/compose.png"
    "screenshots/docker/network.png"
    
    # Backend screenshots
    "screenshots/backend/get_tutorials.png"
    "screenshots/backend/post_tutorial.png"
    "screenshots/backend/get_single_tutorial.png"
    "screenshots/backend/mongodb_connection.png"
    
    # Frontend screenshots
    "screenshots/frontend/home_page.png"
    "screenshots/frontend/add_tutorial.png"
    "screenshots/frontend/tutorial_details.png"
    "screenshots/frontend/edit_tutorial.png"
    
    # Nginx screenshots
    "screenshots/nginx/config.png"
    "screenshots/nginx/logs.png"
    
    # Verification screenshots
    "screenshots/database_verification.png"
)

# Function to count completed screenshots
count_completed() {
    local count=0
    for screenshot in "${REQUIRED_SCREENSHOTS[@]}"; do
        if [ -f "$screenshot" ]; then
            ((count++))
        fi
    done
    echo $count
}

# Function to create a progress bar
progress_bar() {
    local completed=$1
    local total=$2
    local percentage=$((completed * 100 / total))
    local bar_length=50
    local filled_length=$((percentage * bar_length / 100))
    
    printf "${BLUE}["
    for ((i=0; i<bar_length; i++)); do
        if [ $i -lt $filled_length ]; then
            printf "="
        else
            printf " "
        fi
    done
    printf "] ${percentage}%%${NC}\n"
}

# Main function to check and display screenshot status
check_screenshots() {
    clear
    echo -e "${BLUE}===================================================${NC}"
    echo -e "${BLUE}        MEAN Stack Assessment Screenshot Tracker${NC}"
    echo -e "${BLUE}===================================================${NC}"
    echo ""
    
    local completed=$(count_completed)
    local total=${#REQUIRED_SCREENSHOTS[@]}
    
    echo -e "${YELLOW}Progress:${NC}"
    progress_bar $completed $total
    echo -e "Completed: ${GREEN}$completed${NC} / ${YELLOW}$total${NC}"
    echo ""
    
    echo -e "${YELLOW}Screenshot Status:${NC}"
    echo ""
    
    # Process Docker screenshots
    echo -e "${BLUE}Docker Screenshots:${NC}"
    check_category "screenshots/docker/"
    
    # Process Backend screenshots
    echo -e "\n${BLUE}Backend Screenshots:${NC}"
    check_category "screenshots/backend/"
    
    # Process Frontend screenshots
    echo -e "\n${BLUE}Frontend Screenshots:${NC}"
    check_category "screenshots/frontend/"
    
    # Process Nginx screenshots
    echo -e "\n${BLUE}Nginx Screenshots:${NC}"
    check_category "screenshots/nginx/"
    
    # Process Verification screenshots
    echo -e "\n${BLUE}Verification Screenshots:${NC}"
    check_category "screenshots/database_verification.png"
    
    echo ""
    echo -e "${BLUE}===================================================${NC}"
    
    if [ $completed -eq $total ]; then
        echo -e "${GREEN}All screenshots completed! You're ready for submission.${NC}"
    else
        echo -e "${YELLOW}Next steps:${NC}"
        echo "1. Capture the remaining screenshots"
        echo "2. Run this script again to update progress"
        echo "3. Check CHECKLIST.md for detailed screenshot instructions"
    fi
    
    echo -e "${BLUE}===================================================${NC}"
}

# Function to check screenshots in a specific category
check_category() {
    local category=$1
    
    for screenshot in "${REQUIRED_SCREENSHOTS[@]}"; do
        if [[ $screenshot == $category* ]]; then
            if [ -f "$screenshot" ]; then
                echo -e "  [${GREEN}✓${NC}] $(basename "$screenshot")"
            else
                echo -e "  [${RED}✗${NC}] $(basename "$screenshot")"
            fi
        fi
    done
}

# Run the check
check_screenshots

echo ""
echo -e "${YELLOW}Usage:${NC}"
echo "Run this script anytime to check your progress:"
echo "  ./screenshot_tracker.sh"
echo ""

