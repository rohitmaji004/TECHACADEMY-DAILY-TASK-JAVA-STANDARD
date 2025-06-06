#!/bin/bash

myFunction() {
  echo "Hello, world!"
}

myFunction

#!/bin/bash

myFunction() {
  echo "Hello, $1!"
}

myFunction "John"

#!/bin/bash

add_number() {
  echo $(($1 + $2))
}

sum=$(add_number 5 7)
echo "Sum: $sum"
