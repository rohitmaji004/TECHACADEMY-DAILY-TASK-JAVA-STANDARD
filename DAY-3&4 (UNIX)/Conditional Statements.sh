

age=20  

if [ $age -ge 18 ]; then
    echo "Adult"
elif [ $age -gt 12 ]; then
    echo "Teenager"
else
    echo "Child"
fi
