#!/bin/bash

# Path to the assets directory and Dart file
ASSETS_DIR="assets/images"
DART_FILE="lib/data/app_resources.dart"

# Check if assets directory exists
if [ ! -d "$ASSETS_DIR" ]; then
    echo "Error: Directory $ASSETS_DIR does not exist"
    exit 1
fi

# Check if Dart file exists
if [ ! -f "$DART_FILE" ]; then
    echo "Error: File $DART_FILE does not exist"
    exit 1
fi

# Find all image files recursively and format them for Dart list
IMAGE_LIST=$(find "$ASSETS_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" \) | \
             sed "s|$ASSETS_DIR/||g" | \
             awk '{printf("\047%s\047,", $0)}' | \
             sed 's/,$//')

# Create temporary file
TMP_FILE=$(mktemp)

# Process the file: first remove old list, then add new one
perl -0777 -pe '
    # Удаляем старый список flameImages
    s/\s*static final List<String> flameImages = \[[\s\S]*?\];\n//g;
    
    # Добавляем новый список после открывающей скобки класса
    s/(abstract class AppResources \{)/$1\n  static final List<String> flameImages = ['"$IMAGE_LIST"'];\n/;
' "$DART_FILE" > "$TMP_FILE"

mv "$TMP_FILE" "$DART_FILE"

echo "Successfully updated flameImages list in $DART_FILE"