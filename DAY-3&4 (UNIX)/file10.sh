#!/bin/bash

# Declare user groups
declare -A admins
declare -A members
guests=("Rohit" "Jeet" "Yash")

# Admin and Member credentials
admins["admin1"]="admin12"
admins["root"]="toor"
members["john"]="john123"
members["emma"]="emma456"

# Login state variables
logged_in=false
logged_user=""
logged_role=""

# Function to authenticate Admin or Member
function authenticate_user() {
    local -n user_group=$1  # Pass associative array by reference
    local role=$2
    read -p "Enter username: " username
    read -sp "Enter password: " password
    echo

    if [[ ${user_group[$username]} == "$password" ]]; then
        echo "✅ Authentication successful! Welcome, $username."
        logged_in=true
        logged_user="$username"
        logged_role="$role"
    else
        echo "❌ Invalid credentials. Access denied."
    fi
}

# Function to check guest
function check_guest() {
    read -p "Enter your name: " guest_name
    for g in "${guests[@]}"; do
        if [[ "$g" == "$guest_name" ]]; then
            echo "✅ Welcome, $guest_name! You are logged in as a guest."
            logged_in=true
            logged_user="$guest_name"
            logged_role="Guest"
            return
        fi
    done
    echo "❌ Guest not recognized. Access denied."
}

# Logout function
function logout_user() {
    if $logged_in; then
        echo "👋 Logging out $logged_user ($logged_role)..."
        logged_in=false
        logged_user=""
        logged_role=""
    else
        echo "⚠️ No user is currently logged in."
    fi
}

# Main loop
while true; do
    echo -e "\n==== USER AUTHENTICATION SYSTEM ===="
    if $logged_in; then
        echo "👤 Logged in as: $logged_user ($logged_role)"
        echo "1. Logout"
        echo "2. Exit"
        read -p "Choose an option [1-2]: " choice

        case $choice in
            1)
                logout_user
                ;;
            2)
                echo "Exiting... Goodbye!"
                break
                ;;
            *)
                echo "⚠️ Invalid option. Please choose 1 or 2."
                ;;
        esac

    else
        echo "1. Admin Login"
        echo "2. Member Login"
        echo "3. Guest Access"
        echo "4. Exit"
        read -p "Choose an option [1-4]: " choice

        case $choice in
            1)
                echo -e "\n--- Admin Login ---"
                authenticate_user admins "Admin"
                ;;
            2)
                echo -e "\n--- Member Login ---"
                authenticate_user members "Member"
                ;;
            3)
                echo -e "\n--- Guest Access ---"
                check_guest
                ;;
            4)
                echo "Exiting... Goodbye!"
                break
                ;;
            *)
                echo "⚠️ Invalid option. Please choose between 1 and 4."
                ;;
        esac
    fi
done
