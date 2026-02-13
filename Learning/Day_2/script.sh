#!/bin/bash
#practice 2
if [ -f "teshfile.sh" ]; then
    {
        echo "Current user: $(whoami)"
        echo "Current directory: $(pwd)"
        echo "Date: $(date)"
        echo "Number of logged-in users: $(who | wc -l)"
    } > "teshfile.sh"
else
    echo "file was empty"
fi

#practice 3

# read -p "Enter user's name:" Name
# read -p "Fav colour:" Col
# if [ ! -s "username_color.txt" ]; then
#     {
#         echo "Hello $Name"
#         echo "Your Fab color is $Col"
#         touch username_color.txt
#     } > "username_color.txt"
#     echo "file created -> username_color.txt"
# else
#     echo "file already exists -> username_color.txt"
# fi

#practice 
# mkdir test_dir
# mkdir private_dir
# chmod 755 test_dir
# chmod 600 private_dir

# echo "created dir with diff permissions"
# ls -ld test_dir private_dir
echo ""

#pratice
echo "Run it with: ./username_color"

