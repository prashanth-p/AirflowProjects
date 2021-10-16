# This script
# Extracts data from /etc/passwd file into a CSV file.

# The csv data file contains the user name, user id and 
# home directory of each user account defined in /etc/passwd

# Transforms the text delimiter from ":" to ",".
# Loads the data from the CSV file into a table in PostgreSQL database.

logDate() {
    echo "$(date +'%d%b%Y %H:%M:%S')"
}

# Extract phase
echo "$(logDate): Extracting Data..!!"

# extracting the below columns from /etc/passwd
# Column 1: UserName
# Column 3: userid
# Column 6: Home Directtory

cut -d":" -f1,3,6 /etc/passwd > tempFile.txt

echo "$(logDate): extraction of /etc/passwd is completed"
echo "$(logDate): written data to file $(pwd)/tempFile.txt"

# Transformation Phase

echo "$(logDate): Transforming data..!!"
cat tempFile.txt | tr ":" ","  > extractedFile.txt



# Load the data to the target DB
echo "$(logDate): Loading data..!!"
echo "\c template1;\COPY users FROM '$(pwd)/extractedFile.txt' DELIMITERS ',' CSV;" | psql --username=postgres --host=localhost

# View the data in the target DB
# echo '\c template1; \\SELECT * from users;' | psql --username=postgres --host=localhost