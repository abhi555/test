import os
import shutil
from datetime import datetime

# === CONFIGURATION ===
source_folder = "CSV_INPUTS"
google_drive_base_path = "/path/to/your/Google Drive"  # <-- Change this!

# === GET TODAY'S DATE IN "MMM DD" FORMAT ===
today_str = datetime.now().strftime("%b %d")  # e.g., "Apr 18"

# === CREATE DESTINATION FOLDER ===
destination_folder = os.path.join(google_drive_base_path, today_str, "input")
os.makedirs(destination_folder, exist_ok=True)

# === COPY FILES FROM SOURCE TO DESTINATION ===
for filename in os.listdir(source_folder):
    src_file = os.path.join(source_folder, filename)
    dest_file = os.path.join(destination_folder, filename)

    if os.path.isfile(src_file):
        shutil.copy2(src_file, dest_file)

print(f"Files copied to {destination_folder}")