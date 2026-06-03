#!/bin/bash
# split_diff.sh — Splits a unified diff into category-specific patches
# Usage: split_diff.sh <input_patch> <output_directory>
#
# This script reads a combined patch file and splits it into separate files
# based on file path patterns. Each output file contains only the diff hunks
# for files matching that category.

set -euo pipefail

INPUT_PATCH="${1:?Usage: split_diff.sh <input_patch> <output_dir>}"
OUTPUT_DIR="${2:?Usage: split_diff.sh <input_patch> <output_dir>}"

mkdir -p "$OUTPUT_DIR"

# Category patterns — each line is: category_name|grep_pattern (extended regex on paths)
# Patterns are matched against the "diff --git a/PATH b/PATH" lines
declare -A CATEGORIES
CATEGORIES=(
  [build_config]="build\.gradle|settings\.gradle|gradle\.properties|\.properties$|application\.yml|application\.groovy|Config\.groovy|DataSource\.groovy|BuildConfig\.groovy|resources\.groovy|BootStrap\.groovy|UrlMappings\.groovy|Dockerfile|docker-compose|Makefile|\.config\.(js|ts|mjs)|package\.json|pom\.xml|go\.mod|Cargo\.toml|requirements\.txt|setup\.py|setup\.cfg|pyproject\.toml|\.env|FilterConfig|LayoutConfig|web\.xml|setenv"
  [controllers]="controllers/"
  [services]="services/"
  [domain]="domain/|models/|entities/"
  [views]="views/|taglib/|templates/|assets/|static/|web-app/"
  [src_infra]="src/main/|src/lib/|server-conf/|scripts/|logback|log4j|\.sh$"
  [tests]="test/|spec/|Test\.groovy|Spec\.groovy|_test\.go|\.test\.(js|ts|tsx)|\.spec\.(js|ts|tsx)"
)

echo "Splitting: $INPUT_PATCH"
echo "Output dir: $OUTPUT_DIR"
echo ""

# Get all diff boundaries (line numbers where "diff --git" appears)
BOUNDARIES=$(grep -n "^diff --git " "$INPUT_PATCH" | cut -d: -f1)
TOTAL_LINES=$(wc -l < "$INPUT_PATCH")

# Convert to array
readarray -t BOUND_ARRAY <<< "$BOUNDARIES"
BOUND_COUNT=${#BOUND_ARRAY[@]}

# For each category, extract matching hunks
for CATEGORY in "${!CATEGORIES[@]}"; do
  PATTERN="${CATEGORIES[$CATEGORY]}"
  OUTFILE="$OUTPUT_DIR/split_${CATEGORY}.patch"
  
  # Clear output file
  > "$OUTFILE"
  
  MATCH_COUNT=0
  
  for ((i=0; i<BOUND_COUNT; i++)); do
    START=${BOUND_ARRAY[$i]}
    
    # End is either next boundary - 1 or end of file
    if ((i + 1 < BOUND_COUNT)); then
      END=$((BOUND_ARRAY[i+1] - 1))
    else
      END=$TOTAL_LINES
    fi
    
    # Get the diff header line
    HEADER=$(sed -n "${START}p" "$INPUT_PATCH")
    
    # Check if this file matches the category pattern
    if echo "$HEADER" | grep -qEi "$PATTERN"; then
      sed -n "${START},${END}p" "$INPUT_PATCH" >> "$OUTFILE"
      echo "" >> "$OUTFILE"
      MATCH_COUNT=$((MATCH_COUNT + 1))
    fi
  done
  
  if [ $MATCH_COUNT -gt 0 ]; then
    echo "  ✅ $CATEGORY: $MATCH_COUNT file(s) → $OUTFILE"
  else
    rm -f "$OUTFILE"
    echo "  ⏭️  $CATEGORY: no matching files, skipped"
  fi
done

echo ""
echo "Done. Split patches saved to: $OUTPUT_DIR"
