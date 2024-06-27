#!/bin/bash

sql_directory="/path/to/sql/scripts"

# Define connection information
db_host="your_database_host"
db_port="your_database_port"
db_name="your_database_name"
db_user="your_database_user"
db_password="your_database_password"

# Loop through each SQL script in the directory
for script in "$sql_directory"/*.sql; do
    # Check if the item is a file
    if [ -f "$script" ]; then
        echo "Running script: $script"
        # Execute the SQL script using psql (assuming PostgreSQL)
        PGPASSWORD="$db_password" psql -h "$db_host" -p "$db_port" -U "$db_user" -d "$db_name" -f "$script"
    fi
done

