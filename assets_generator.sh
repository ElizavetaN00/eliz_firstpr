#!/bin/bash

# Define the target directory and output file
ASSETS_DIR="assets/images"
OUTPUT_FILE="lib/generated/assets_flame_images.dart"

# Check if the directory exists
if [ ! -d "$ASSETS_DIR" ]; then
  echo "Error: Directory $ASSETS_DIR does not exist."
  exit 1
fi

# Parse arguments
FULLPATH=true # Default to fullpath
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --fullpath)
      FULLPATH=$2
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Start creating the Dart file
echo "Generating $OUTPUT_FILE..."
echo "// This file is auto-generated. Do not edit manually." > "$OUTPUT_FILE"
echo "class AssetsFlameImages {" >> "$OUTPUT_FILE"
echo "  AssetsFlameImages._();" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Create a list to hold all variable names
VARIABLE_LIST=()

# Function to process files and generate entries
generate_assets() {
  local dir_path="$1"
  local prefix="${2:-}"

  # Iterate over files and directories
  for file in "$dir_path"/*; do
    # If it's a file, generate a constant for the asset
    if [ -f "$file" ]; then
      local file_name=$(basename "$file")
      local relative_path="${file#assets/images/}"
      local asset_name=$(echo "${prefix}$(basename "${relative_path%.*}")" | sed -E 's/[^a-zA-Z0-9]/_/g' | sed -E 's/^[^a-zA-Z]/f\0/')
      
      echo "  static const $asset_name = 'assets/images/$relative_path';" >> "$OUTPUT_FILE"
      VARIABLE_LIST+=("$asset_name")
    # If it's a directory, recursively process its files
    elif [ -d "$file" ]; then
      local dir_name=$(basename "$file")
      local sanitized_prefix=$(echo "$dir_name" | sed -E 's/[^a-zA-Z0-9]/_/g' | sed -E 's/^[^a-zA-Z]/f\0/')
      generate_assets "$file" "${prefix}${sanitized_prefix}_"
    fi
  done
}

# Generate assets starting from the root directory
generate_assets "$ASSETS_DIR"

# Add the list of all variables at the end of the Dart file
echo "" >> "$OUTPUT_FILE"
echo "  static const List<String> all = [" >> "$OUTPUT_FILE"
for variable in "${VARIABLE_LIST[@]}"; do
  echo "    $variable," >> "$OUTPUT_FILE"
done
echo "  ];" >> "$OUTPUT_FILE"

# Finish the Dart file
echo "}" >> "$OUTPUT_FILE"

echo "Asset generation completed: $OUTPUT_FILE"
