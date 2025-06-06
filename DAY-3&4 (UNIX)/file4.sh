echo "Welcome to the Bash Calculator!"
echo "Enter first number:"
read num1
echo "Enter second number:"
read num2
echo "Choose operation (+, -, *, /):"
read op
case $op in
    +)
        result=$((num1 + num2))
        echo "Result: $num1 + $num2 = $result"
        ;;
    -)
        result=$((num1 - num2))
        echo "Result: $num1 - $num2 = $result"
        ;;
    \*)
        result=$((num1 * num2))
        echo "Result: $num1 * $num2 = $result"
        ;;
    /)
        if [ "$num2" -eq 0 ]; then
            echo "Error: Division by zero is not allowed!"
        else
            result=$((num1 / num2))
            echo "Result: $num1 / $num2 = $result"
        fi
        ;;
    *)
        echo "Invalid operation. Please use +, -, *, or /."
        ;;
esac
