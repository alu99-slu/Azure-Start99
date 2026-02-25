# Shell Commands & Bash Scripting Learning Guide

## Part 1: Basic Shell Commands (30 minutes)

### Navigation Commands
```bash
pwd                 # Print Working Directory - shows where you are
ls                  # List files and directories
ls -l               # Long format (shows permissions, owner, size, date)
ls -la              # Long format + hidden files (starting with .)
ls -lh              # Long format + human-readable sizes (KB, MB, GB)
cd /path/to/dir     # Change Directory
cd ..               # Go up one directory
cd ~                # Go to home directory
cd -                # Go to previous directory
```

### File & Directory Operations
```bash
mkdir dirname       # Make Directory
mkdir -p a/b/c      # Create nested directories
touch filename      # Create empty file or update timestamp
cp source dest      # Copy file
cp -r source dest   # Copy directory recursively
mv old new          # Move or rename file/directory
rm filename         # Remove file
rm -r dirname       # Remove directory recursively
rm -rf dirname      # Force remove (be careful!)
```

### Viewing File Contents
```bash
cat filename        # Display entire file
less filename       # View file page by page (q to quit)
head filename       # Show first 10 lines
head -n 5 filename  # Show first 5 lines
tail filename       # Show last 10 lines
tail -f filename    # Follow file (watch for new lines)
```

### File Information
```bash
file filename       # Determine file type
wc filename         # Word count (lines, words, characters)
wc -l filename      # Count lines only
du -sh dirname      # Disk usage - directory size
df -h               # Disk free - filesystem usage
```

### Searching
```bash
grep "pattern" file          # Search for pattern in file
grep -r "pattern" dir        # Recursive search in directory
grep -i "pattern" file       # Case-insensitive search
find /path -name "*.txt"     # Find files by name
find /path -type f           # Find all files
find /path -type d           # Find all directories
```

---

## Part 2: File Permissions (45 minutes)

### Understanding Permissions

Every file/directory has:
- **Owner** (user who owns it)
- **Group** (group that owns it)
- **Others** (everyone else)

Each has three permission types:
- **r** (read) = 4
- **w** (write) = 2
- **x** (execute) = 1

### Reading Permission String
```
-rwxr-xr--
│└┬┘└┬┘└┬┘
│ │  │  └── Others: r-- (read only) = 4
│ │  └───── Group: r-x (read + execute) = 5
│ └──────── Owner: rwx (all permissions) = 7
└────────── File type: - (regular file), d (directory), l (link)
```

### chmod - Change Mode (Permissions)

**Numeric Method:**
```bash
chmod 755 script.sh    # rwxr-xr-x (owner: all, group/others: read+execute)
chmod 644 file.txt     # rw-r--r-- (owner: read+write, others: read only)
chmod 600 secret.txt   # rw------- (owner: read+write, no one else)
chmod 777 file.sh      # rwxrwxrwx (all permissions for everyone - avoid!)
```

**Symbolic Method:**
```bash
chmod u+x script.sh    # Add execute for user (owner)
chmod g-w file.txt     # Remove write for group
chmod o+r file.txt     # Add read for others
chmod a+x script.sh    # Add execute for all (a=all, u=user, g=group, o=others)
chmod u=rwx,g=rx,o=r   # Set exact permissions
```

### chown - Change Owner
```bash
chown user file.txt           # Change owner
chown user:group file.txt     # Change owner and group
chown -R user:group dir/      # Recursively change ownership
```

### chgrp - Change Group
```bash
chgrp groupname file.txt      # Change group
chgrp -R groupname dir/       # Recursively change group
```

### Checking Current User/Group
```bash
whoami                # Show current username
id                    # Show user ID, group IDs
groups                # Show groups you belong to
ls -l file.txt        # See owner and group of file
```

---

## Part 3: Bash Scripting Basics (45 minutes)

### Script Structure

```bash
#!/bin/bash
# This is the shebang - tells system to use bash

# Comments start with #
echo "Hello, World!"    # Print to screen
```

### Variables
```bash
NAME="Alice"            # No spaces around =
AGE=25
echo "Name: $NAME"      # Access with $
echo "Age: ${AGE}"      # Curly braces for clarity

# Command output to variable
CURRENT_DATE=$(date)
USER_COUNT=$(who | wc -l)
```

### User Input
```bash
read -p "Enter your name: " USERNAME
echo "Hello, $USERNAME!"
```

### Conditionals
```bash
if [ $AGE -gt 18 ]; then
    echo "Adult"
elif [ $AGE -eq 18 ]; then
    echo "Just turned 18"
else
    echo "Minor"
fi

# Comparison operators:
# -eq (equal), -ne (not equal)
# -gt (greater than), -ge (greater or equal)
# -lt (less than), -le (less or equal)

# File tests:
if [ -f "file.txt" ]; then
    echo "File exists"
fi

# -f (file exists), -d (directory exists)
# -r (readable), -w (writable), -x (executable)
```

### Loops
```bash
# For loop
for i in 1 2 3 4 5; do
    echo "Number: $i"
done

for file in *.txt; do
    echo "Processing $file"
done

# While loop
count=0
while [ $count -lt 5 ]; do
    echo "Count: $count"
    count=$((count + 1))
done
```

### Functions
```bash
greet() {
    echo "Hello, $1!"    # $1 is first argument
}

greet "Alice"
greet "Bob"
```

### Special Variables
```bash
$0    # Script name
$1-$9 # Arguments 1-9
$@    # All arguments
$#    # Number of arguments
$?    # Exit status of last command
$$    # Process ID of script
```

---

## Practice Exercises

### Exercise 1: File Permissions Practice
```bash
# Create a test file
touch testfile.txt
ls -l testfile.txt

# Make it read-only for everyone
chmod 444 testfile.txt

# Try to edit it (should fail)
echo "test" > testfile.txt

# Make it writable again
chmod 644 testfile.txt

# Create a script and make it executable
echo '#!/bin/bash' > hello.sh
echo 'echo "Hello!"' >> hello.sh
chmod +x hello.sh
./hello.sh

-----------------------------> Done
```

### Exercise 2: Simple System Info Script
Create a script that displays:
- Current user
- Current directory
- Date and time
- Number of logged-in users
- Disk usage

-----------------------------> Done

### Exercise 3: Interactive Script
Create a script that:
- Asks for user's name
- Asks for favorite color
- Creates a file named "username_color.txt"
- Writes a greeting to the file

---

## Common Patterns

### Error Handling
```bash
#!/bin/bash

if [ ! -f "input.txt" ]; then
    echo "Error: input.txt not found!"
    exit 1
fi

# Continue with script...
```

### Making Scripts Portable
```bash
#!/usr/bin/env bash    # More portable than #!/bin/bash
```

### Debugging
```bash
bash -x script.sh      # Run with debugging (shows each command)
set -x                 # Enable debugging in script
set +x                 # Disable debugging
```

---

## Quick Reference Card

| Command | Purpose |
|---------|---------|
| `ls -la` | List all files with details |
| `chmod 755` | Make file executable |
| `./script.sh` | Run script |
| `$VAR` | Access variable |
| `$(command)` | Command substitution |
| `[ condition ]` | Test condition |
| `>` | Redirect output (overwrite) |
| `>>` | Redirect output (append) |
| `|` | Pipe (send output to next command) |

---

## Tips

1. Always test scripts in a safe environment first
2. Use meaningful variable names
3. Add comments to explain complex logic
4. Check exit codes: `if [ $? -eq 0 ]; then` (0 = success)
5. Quote variables to handle spaces: `"$VAR"` not `$VAR`
6. Use `shellcheck` tool to validate scripts
7. Start with `set -e` to exit on any error
8. Use `chmod +x` to make scripts executable

---

## Resources for Further Learning

- `man bash` - Bash manual
- `man chmod` - chmod manual
- `help [command]` - Built-in command help
- ShellCheck (shellcheck.net) - Online script validator
