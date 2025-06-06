declare -A student_ids
declare -A attendance_status
present_list=()
absent_list=()
leave_list=()
report_file="attendance_report.txt"
current_date=$(date +"%Y-%m-%d")
function input_students() {
    read -p "Enter number of students: " total_students
    echo -e "\nEnter student name and ID:"
    for (( i=1; i<=total_students; i++ ))
    do
        read -p "Student $i Name: " name
        read -p "Student $i ID: " id
        student_ids["$name"]="$id"
    done
}
function take_attendance() {
    echo -e "\n--- Taking Attendance for $current_date ---"
    for name in "${!student_ids[@]}"
    do
        echo "Student: $name (ID: ${student_ids[$name]})"
        read -p "Enter status for $name (P=Present, A=Absent, L=Leave): " status
        case "$status" in
            [Pp]) attendance_status["$name"]="Present" ;;
            [Aa]) attendance_status["$name"]="Absent" ;;
            [Ll]) attendance_status["$name"]="Leave" ;;
            *) 
                echo "Invalid input. Marking as Absent by default."
                attendance_status["$name"]="Absent"
                ;;
        esac
        echo
    done
}

function categorize_attendance() {
    present_list=()
    absent_list=()
    leave_list=()

    for name in "${!student_ids[@]}"
    do
        status="${attendance_status[$name]}"
        case "$status" in
            "Present") present_list+=("$name") ;;
            "Absent")  absent_list+=("$name") ;;
            "Leave")   leave_list+=("$name") ;;
        esac
    done
}

function generate_report() {
    {
    echo "=========== ATTENDANCE SUMMARY ==========="
    echo "Date: $current_date"
    echo "Total Students: ${#student_ids[@]}"
    echo "Present: ${#present_list[@]}"
    echo "Absent: ${#absent_list[@]}"
    echo "On Leave: ${#leave_list[@]}"

    echo -e "\n PRESENT STUDENTS:"
    for name in "${present_list[@]}"; do
        echo " - $name (ID: ${student_ids[$name]})"
    done

    echo -e "\n ABSENT STUDENTS:"
    for name in "${absent_list[@]}"; do
        echo " - $name (ID: ${student_ids[$name]})"
    done

    echo -e "\n STUDENTS ON LEAVE:"
    for name in "${leave_list[@]}"; do
        echo " - $name (ID: ${student_ids[$name]})"
    done

    echo "=========================================="
    } | tee -a "$report_file"
}
function main() {
    > "$report_file"  
    input_students
    take_attendance
    categorize_attendance
    generate_report
}

main
