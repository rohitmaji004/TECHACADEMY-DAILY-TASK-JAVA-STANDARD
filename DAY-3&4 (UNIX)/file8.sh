is_prime() {
    num=$1
    if [ "$num" -le 1 ]; then
        echo "Not Prime"
        return
    fi
    for ((i = 2; i <= num / 2; i++)); do
        if [ $((num % i)) -eq 0 ]; then
            echo "Not Prime"
            return
        fi
    done
    echo "Prime"
}
is_palindrome() {
    num=$1
    original=$num
    reverse=0

    while [ $num -gt 0 ]; do
        digit=$((num % 10))
        reverse=$((reverse * 10 + digit))
        num=$((num / 10))
    done

    if [ "$original" -eq "$reverse" ]; then
        echo "Palindrome"
    else
        echo "Not Palindrome"
    fi
}

# Main menu
echo "==============================="
echo "Choose what you want to check:"
echo "1. Find Odd or Even numbers"
echo "2. Find Prime numbers"
echo "3. Find Palindromic numbers"
echo "==============================="
echo "Enter your choice (1, 2 or 3):"
read choice

echo "Enter the limit (check from 1 to this number):"
read limit

case $choice in
    1)
        echo "----- Odd or Even from 1 to $limit -----"
        for ((n = 1; n <= limit; n++)); do
            if [ $((n % 2)) -eq 0 ]; then
                echo "$n is Even"
            else
                echo "$n is Odd"
            fi
        done
        ;;
    2)
        echo "----- Prime numbers from 1 to $limit -----"
        for ((n = 1; n <= limit; n++)); do
            result=$(is_prime $n)
            if [ "$result" == "Prime" ]; then
                echo "$n is Prime"
            fi
        done
        ;;
    3)
        echo "----- Palindromic numbers from 1 to $limit -----"
        for ((n = 1; n <= limit; n++)); do
            result=$(is_palindrome $n)
            if [ "$result" == "Palindrome" ]; then
                echo "$n is a Palindrome"
            fi
        done
        ;;
    *)
        echo "Invalid choice. Please run the script again and choose 1, 2 or 3."
        ;;
esac
