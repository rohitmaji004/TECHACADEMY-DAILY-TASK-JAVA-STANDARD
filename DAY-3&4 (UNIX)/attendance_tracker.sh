#!/bin/bash

declare -A attendance

get_attendance() {
    echo "Enter number of students:"
    read count

    for (( i=1; i<=count; i++ ))
    do
        echo -n "Enter name of student $i: "
        read name

        while true; do
            echo -n "Enter attendance (P - Present, A - Absent, L - Late) for $name: "
            read status
            case $status in
                P|p|A|a|L|l)
                    attendance[$name]="${status^^}"  # Convert to uppercase
                    break
                    ;;
                *)
                    echo "Invalid input. Please enter only P, A, or L."
                    ;;
            esac
        done
    done
}

print_report() {
    echo ""
    echo "=============================="
    echo "|     Attendance Report      |"
    echo "=============================="
    printf "| %-20s | %-7s |\n" "Student Name" "Status"
    echo "------------------------------"
    for name in "${!attendance[@]}"
    do
        printf "| %-20s | %-7s |\n" "$name" "${attendance[$name]}"
    done
    echo "=============================="
}

# Main Execution
get_attendance
print_report
