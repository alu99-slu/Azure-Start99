#!/bin/bash

echo "Hi, How are you?"
: '
Name='Souvik'

read -p "Enter age: " Age
echo "Name : $Name"
echo "Age : $Age"
echo ""

#revise
if [ $Age -lt 18 ]; then
    echo "Souvik is not Adult"
else
    echo "Souvik is Adult"
fi
'

if [ ! -f "test.txt" ]; then
    touch "test.txt"
    echo "new directory created"
else
    echo "directory alredy exist"
fi

# rm -rf "test.txt"
echo "$PWD"

if [ ! -s "test.txt" ]; then
    # {
    #     for i in 1 2 3 4 5; do
    #         echo $i
    #     done
    # } > "test.txt"
    {
        count=0
        while [ $count -lt 5 ]; do
            echo "Count: $count"
            count=$((count + 1))
        done  
    } > "test.txt"
    echo "file was empty so edited"
else
    echo "file was not empty"
fi

fun(){
    echo "fun1, $1"
    echo "$(whoami)"
    echo "$$" #process id fo the script
}

fun "Deep"