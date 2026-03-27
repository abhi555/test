#!/bin/bash

# Check if both URL and Name were provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <URL> <video_name>"
    exit 1
fi

URL="$1"
NAME="$2"

echo "Step 1: Downloading video..."
# Use %(ext)s so yt-dlp assigns the correct extension (webm, mp4, mkv, etc.)
yt-dlp  --cookies-from-browser chrome "$URL" -o "$NAME.%(ext)s"

# Find the file that was just downloaded 
# (Looks for files starting with your video name, excluding already compressed ones)
ORIG_FILE=$(ls "$NAME".* | grep -v "compressed_" | head -n 1)

if [ -z "$ORIG_FILE" ] || [ ! -f "$ORIG_FILE" ]; then
    echo "Error: Could not find the downloaded file."
    exit 1
fi

echo "Step 2: Compressing $ORIG_FILE..."
# Run ffmpeg (-y automatically overwrites if a compressed file already exists)
if ffmpeg -y -i "$ORIG_FILE" -vf "scale=-2:720" -vcodec libx264 -crf 28 -acodec aac -b:a 128k "compressed_$NAME.mp4"; then
    echo "Success! Deleting original file..."
    rm "$ORIG_FILE"
    echo "Done. Final file is compressed_$NAME.mp4"
else
    echo "Compression failed! The original file was not deleted."
    exit 1
fi
