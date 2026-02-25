#!/bin/bash
set -e
echo "Hello world"
name="souvik"
echo $name
# date=$(date)
# echo "today's date is $date"

#inputs
user="alu"
# read -p "Enter your name: " user
echo "Hello $user"

#conditions
AGE="33"
# read -p "Enter Your Age: " AGE
if [ "$AGE" -gt 21 ]; then
    echo "Man"
elif [ "$AGE" -eq 21 ]; then
    echo "Boy"
else
    echo "Child"
fi

#file testing
if [ -f "test.html" ]; then
    echo "file is there"
else
    echo "file NA"
fi
# -d -> to check directory | -e -> file exit or not
# -r,-w,-x -> file can be reable or writeable or executable
if [ -r "test.html" ]; then
    echo "Yes"
else
    echo "No"
fi
# -s -> to check the file is empty or not
# -e -> to check the file is exist or not

#practice
DIR="backup"
DIR2="backup.log"

if [ ! -d "$DIR" ] || [ -d "$DIR2" ]; then
    mkdir "$DIR"
    echo "Directory created"
    #create file 
    touch "$DIR/logs.sh"
    echo "file create"
    #delete file/create
    rm -rf "$DIR2"
    echo "directory deleted"
fi

#practice
if [ ! -s "$DIR/logs.sh" ]; then
    {
        echo "user: $(whoami)"
        echo "Hostname: $(hostname)"
        echo "Date: $(date)"
        echo "Disk Usage: "
        df -h
    } > "$DIR/logs.sh"
    echo "file was empty so edited"
else
    echo "file was not empty"
fi

#loops
#for loop
# for i in 1 2 3 4 5; do
#     echo $i
# done
#better way
# for i in {1..5}; do
#     echo $i
# done
#while
# while [ "$count" -lt 5 ]; do
#     echo "$count"
#     count=$((count + 1))
# done

# c=0

# while [ "$c" -lt 5 ]; do
#     echo "$c"
#     c=$((c++))
# done

# count=0

# while (( count < 5 )); do
#     echo "$count"
#     ((count++))
# done

#functions
# great(){
#     echo "yo boy"
# }
# great

# add(){
#     read -p "Enter n1: " n1
#     read -p "Enter n2: " n2

#     result=$(( n1 + n2 ))
#     echo "Result: $result"
# }

# add

# if [ ! -d "$DIR/temp.sh" ]; then
#     touch "$DIR/temp.sh"
#     echo "File created"
#     {
#         echo "date: $(date)"
#         echo "Hostname: $(hostname)"
#     }
#     echo "data added"
#     fun(){
#         if [ ! $1 -eq "user" ]; then
#             echo "user: $(whoami)"
#     }

#     fun
# fi

#exit code (0)
# ls test.html
# status=$?

# if [ $status -eq 0 ]; then
#     echo "sucess"
# else
#     echo "fails"
# fi

arg(){
    if [ -f "$DIR/logs.sh" ]; then
        echo "file is present"
        echo "1st arg: $#"
        echo "PWD: $PWD"
    fi
}

arg one two theree


