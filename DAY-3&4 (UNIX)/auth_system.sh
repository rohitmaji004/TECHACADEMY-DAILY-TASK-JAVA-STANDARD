#!/bin/bash

# Predefined users (username:password:role)
users=(
  "admin:admin123:Admin"
  "guest:guest123:Guest"
  "john:john123:Member"
)

# Function to validate user login
login() {
  echo -n "Username: "
  read username
  echo -n "Password: "
  read -s password
  echo ""

  for user in "${users[@]}"; do
    IFS=':' read -r u p r <<< "$user"
    if [[ "$u" == "$username" && "$p" == "$password" ]]; then
      echo "Login successful!"
      role="$r"
      return 0
    fi
  done

  echo "Invalid username or password."
  return 1
}

# Function to handle role-based access
handle_role() {
  case "$role" in
    Admin)
      echo "Welcome Admin! You have full access."
      ;;
    Guest)
      echo "Welcome Guest! You have limited access."
      ;;
    Member)
      echo "Welcome Member! You have standard access."
      ;;
    *)
      echo "Unknown role."
      ;;
  esac
}

# Main
attempts=0
max_attempts=3

while (( attempts < max_attempts )); do
  login
  if [[ $? -eq 0 ]]; then
    handle_role
    exit 0
  fi
  ((attempts++))
  echo "Attempts remaining: $((max_attempts - attempts))"
done

echo "Too many failed attempts. Exiting."
exit 1
