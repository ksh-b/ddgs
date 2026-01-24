#!/bin/bash
# DDGS Testing Scripts - Run tests for the DDGS library

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🎯 DDGS Testing Suite${NC}\n"

# Function to display menu
show_menu() {
    echo -e "${YELLOW}Select a test to run:${NC}\n"
    echo "1. Run Unit Tests (test/unit)"
    echo "2. Run Integration Tests (test/integration)"
    echo "3. Run Platform Compatibility Tests"
    echo "4. Run All Tests"
    echo "5. Generate Coverage Report"
    echo "0. Exit"
    echo ""
    read -p "Enter your choice (0-5): " choice
}

# Function to run unit tests
run_unit_tests() {
    echo -e "\n${BLUE}Running unit tests...${NC}\n"
    dart test test/unit
    echo -e "\n${GREEN}✅ Unit tests complete!${NC}\n"
}

# Function to run integration tests
run_integration_tests() {
    echo -e "\n${BLUE}Running integration tests (Live API - may be slow)...${NC}\n"
    # We use --run-skipped because integration tests are skipped by default
    dart test test/integration --run-skipped
    echo -e "\n${GREEN}✅ Integration tests complete!${NC}\n"
}

# Function to run platform tests
run_platform_tests() {
    echo -e "\n${BLUE}Running platform verification...${NC}\n"
    dart test test/unit/platform_test.dart
    echo -e "\n${GREEN}✅ Platform verification complete!${NC}\n"
}

# Function to run all tests
run_all_tests() {
    echo -e "\n${BLUE}Running ALL tests...${NC}\n"
    
    echo -e "${YELLOW}Step 1: Unit Tests${NC}"
    dart test test/unit
    
    echo -e "\n${YELLOW}Step 2: Platform Tests${NC}"
    dart test test/unit/platform_test.dart

    echo -e "\n${YELLOW}Step 3: Integration Tests${NC}"
    dart test test/integration --run-skipped
    
    echo -e "\n${GREEN}✅ All tests complete!${NC}\n"
}

# Main loop
while true; do
    show_menu
    
    case $choice in
        1)
            run_unit_tests
            ;;
        2)
            run_integration_tests
            ;;
        3)
            run_platform_tests
            ;;
        4)
            run_all_tests
            ;;
        5)
            echo -e "\n${BLUE}Generating coverage...${NC}\n"
            dart test --coverage=coverage test/unit
            echo -e "\n${GREEN}✅ Coverage generated in coverage/ directory${NC}\n"
            ;;
        0)
            echo -e "\n${GREEN}Goodbye!${NC}\n"
            exit 0
            ;;
        *)
            echo -e "\n${YELLOW}Invalid choice.${NC}\n"
            ;;
    esac
done
