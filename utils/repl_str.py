import os

def replace_first_occurrence_in_files(directory, string_to_replace, replacement_string):
    for filename in os.listdir(directory):
        filepath = os.path.join(directory, filename)
        # Check if the item is a file
        if os.path.isfile(filepath):
            # Open the file in read mode
            with open(filepath, 'r') as file:
                contents = file.read()
            # Replace the first occurrence of the string
            new_contents = contents.replace(string_to_replace, replacement_string, 1)
            # Write the updated contents back to the file
            with open(filepath, 'w') as file:
                file.write(new_contents)
            print(f"First occurrence of string replaced in file: {filename}")

directory = "/home/centos/stage_ddl_sql"

# Define the string to be replaced and the replacement string
string_to_replace = "SET default_tablespace = '';"
replacement_string = "SET default_tablespace = rfph_data_00;"


# Call the function to replace the first occurrence in each file
replace_first_occurrence_in_files(directory, string_to_replace, replacement_string)

