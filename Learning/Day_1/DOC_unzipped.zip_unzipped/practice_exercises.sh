#!/bin/bash

################################################################################
# Practice Exercises Script
# Purpose: Hands-on exercises for learning shell commands and permissions
################################################################################

echo "========================================="
echo "  SHELL COMMANDS PRACTICE EXERCISES"
echo "========================================="
echo ""

# Create a practice directory
PRACTICE_DIR="$HOME/shell_practice"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit

echo "Created practice directory: $PRACTICE_DIR"
echo ""

# Exercise 1: File Creation and Permissions
echo "--- Exercise 1: File Permissions ---"
echo "Creating test files..."

# Create different types of files
touch readonly.txt
touch readwrite.txt
touch executable.sh

echo "Setting different permissions..."
chmod 444 readonly.txt      # Read-only for everyone
chmod 644 readwrite.txt     # Read-write for owner, read for others
chmod 755 executable.sh     # Executable script

echo "Current permissions:"
ls -l *.txt *.sh

echo ""
echo "Try these commands to see permissions in action:"
echo "  cat readonly.txt           # Should work"
echo "  echo 'test' > readonly.txt # Should fail (read-only)"
echo "  chmod 644 readonly.txt     # Make it writable"
echo "  echo 'test' > readonly.txt # Now should work"
echo ""

# Exercise 2: Directory Permissions
echo "--- Exercise 2: Directory Permissions ---"
mkdir test_dir
mkdir private_dir
chmod 755 test_dir          # Normal directory
chmod 700 private_dir       # Private directory (owner only)

echo "Created directories with different permissions:"
ls -ld test_dir private_dir
echo ""

# Exercise 3: Create a sample script
echo "--- Exercise 3: Creating an Executable Script ---"
cat > hello.sh << 'EOF'
#!/bin/bash
echo "Hello from a bash script!"
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
EOF

chmod +x hello.sh
echo "Created executable script: hello.sh"
echo "Run it with: ./hello.sh"
echo ""

# Exercise 4: File ownership info
echo "--- Exercise 4: Understanding Ownership ---"
echo "Your user information:"
echo "  Username: $(whoami)"
echo "  User ID: $(id -u)"
echo "  Groups: $(groups)"
echo ""

# Exercise 5: Practice with variables
echo "--- Exercise 5: Variables and Command Substitution ---"
cat > variables_demo.sh << 'EOF'
#!/bin/bash

# Simple variables
NAME="Student"
COURSE="Shell Scripting"

echo "Welcome, $NAME!"
echo "You are learning: $COURSE"

# Command substitution
CURRENT_DATE=$(date +%Y-%m-%d)
CURRENT_TIME=$(date +%H:%M:%S)
USER_COUNT=$(who | wc -l)

echo ""
echo "System Information:"
echo "  Date: $CURRENT_DATE"
echo "  Time: $CURRENT_TIME"
echo "  Logged in users: $USER_COUNT"

# Arithmetic
NUM1=10
NUM2=5
SUM=$((NUM1 + NUM2))
echo ""
echo "Math: $NUM1 + $NUM2 = $SUM"
EOF

chmod +x variables_demo.sh
echo "Created: variables_demo.sh"
echo "Run it with: ./variables_demo.sh"
echo ""

# Exercise 6: Conditional logic
echo "--- Exercise 6: Conditionals ---"
cat > conditional_demo.sh << 'EOF'
#!/bin/bash

echo "Enter a number:"
read NUMBER

if [ $NUMBER -gt 10 ]; then
    echo "$NUMBER is greater than 10"
elif [ $NUMBER -eq 10 ]; then
    echo "$NUMBER is equal to 10"
else
    echo "$NUMBER is less than 10"
fi

# Check if file exists
if [ -f "readonly.txt" ]; then
    echo "readonly.txt exists!"
else
    echo "readonly.txt not found"
fi
EOF

chmod +x conditional_demo.sh
echo "Created: conditional_demo.sh"
echo "Run it with: ./conditional_demo.sh"
echo ""

# Exercise 7: Loops
echo "--- Exercise 7: Loops ---"
cat > loop_demo.sh << 'EOF'
#!/bin/bash

# For loop - counting
echo "Counting from 1 to 5:"
for i in 1 2 3 4 5; do
    echo "  Number: $i"
done

echo ""

# For loop - files
echo "Files in current directory:"
for file in *; do
    echo "  - $file"
done

echo ""

# While loop
echo "Countdown:"
count=5
while [ $count -gt 0 ]; do
    echo "  $count..."
    sleep 1
    count=$((count - 1))
done
echo "  Blast off! 🚀"
EOF

chmod +x loop_demo.sh
echo "Created: loop_demo.sh"
echo "Run it with: ./loop_demo.sh"
echo ""

# Exercise 8: Functions
echo "--- Exercise 8: Functions ---"
cat > function_demo.sh << 'EOF'
#!/bin/bash

# Simple function
greet() {
    echo "Hello, $1!"
}

# Function with return value
add() {
    result=$(($1 + $2))
    echo $result
}

# Function with file operations
create_backup() {
    if [ -f "$1" ]; then
        cp "$1" "$1.backup"
        echo "Backup created: $1.backup"
    else
        echo "File $1 not found"
    fi
}

# Using functions
greet "Alice"
greet "Bob"

echo ""
SUM=$(add 15 27)
echo "15 + 27 = $SUM"

echo ""
create_backup "hello.sh"
EOF

chmod +x function_demo.sh
echo "Created: function_demo.sh"
echo "Run it with: ./function_demo.sh"
echo ""

# Summary
echo "========================================="
echo "  EXERCISES CREATED SUCCESSFULLY!"
echo "========================================="
echo ""
echo "Practice directory: $PRACTICE_DIR"
echo ""
echo "Available scripts:"
ls -1 *.sh
echo ""
echo "Next steps:"
echo "  1. cd $PRACTICE_DIR"
echo "  2. Try running each script"
echo "  3. Read and modify the scripts"
echo "  4. Experiment with permissions using chmod"
echo "  5. Check the learning guide: ~/SHELL_LEARNING_GUIDE.md"
echo ""
echo "Happy learning! 🎓"
