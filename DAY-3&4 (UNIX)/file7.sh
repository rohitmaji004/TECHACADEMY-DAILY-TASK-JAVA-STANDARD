echo "Enter numbers separated by space:"
read -a numbers

echo "----- Checking each input -----"

for num in "${numbers[@]}"; do
    if [[ "$num" =~ ^[0-9]+$ ]]; then
        echo "$num is a valid positive number"
        # Optional: you can add checks here (odd/even, prime, etc.)
        if [ $((num % 2)) -eq 0 ]; then
            echo " → $num is Even"
        else
            echo " → $num is Odd"
        fi
    else
        echo "$num is INVALID (not a positive integer)"
    fi
    echo "-----------------------------"
done
