#!/bin/bash
# new-hugo-post.sh
# Description: Interactive script to create a new Hugo blog post

echo "=== Hugo New Post Creator ==="
echo

# Get post title
read -p "Enter the post title (e.g., My First Blog Post): " title

# Generate slug (lowercase and replace spaces with hyphens)
slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

# Get category and tags
read -p "Enter category (optional): " category
read -p "Enter tags (comma-separated, optional): " tags

# Define target file path
filePath="content/posts/${slug}.md"
echo
echo "File to be created: $filePath"

# Confirm creation
read -p "Proceed with creation? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "Operation cancelled."
  exit 0
fi

# Run Hugo command
hugo new "posts/${slug}.md"

# Write front matter if file exists
if [[ -f "$filePath" ]]; then
  cat > "$filePath" <<EOF
---
title: "$title"
date: $(date '+%Y-%m-%dT%H:%M:%S%:z')
categories: [$category]
tags: [$tags]
draft: true
---
EOF
  echo
  echo "Post created successfully: $filePath"
else
  echo
  echo "Failed to create the file. Please check your Hugo setup."
fi
