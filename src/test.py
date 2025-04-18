# List of field names
fields = ["field1", "field2", "field3", "field4"]  # Example field names

# Folder containing the files
folder_path = "/path/to/your/folder"  # Change this to your actual folder path

# Iterate through the field names and check if corresponding files exist
for field in fields:
    file_path = os.path.join(folder_path, f"{field}.csv")
    if os.path.exists(file_path):
        print(f"{field}: intended")
    else:
        print(f"{field}: no drift")