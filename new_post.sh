#!/bin/bash
# new-hugo-post.sh
# Description: Interactive script to create a new Hugo blog post with optional Page Bundle support

echo "=== Hugo New Post Creator ==="
echo

# Get post title
read -p "Enter the post title (e.g., My First Blog Post): " title

# Generate slug (lowercase and replace spaces with hyphens)
slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

# Ask whether to create a folder (Page Bundle)
read -p "Create as a folder with index.md (page bundle)? (y/n): " pageBundle

# Get category and tags
read -p "Enter category (optional): " category
read -p "Enter tags (comma-separated, optional): " tags

# Determine file path
if [[ "$pageBundle" == "y" ]]; then
  filePath="content/posts/${slug}/index.md"
else
  filePath="content/posts/${slug}.md"
fi

echo
echo "File to be created: $filePath"

# Confirm creation
read -p "Proceed with creation? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "Operation cancelled."
  exit 0
fi

# Run Hugo command
if [[ "$pageBundle" == "y" ]]; then
  hugo new "posts/${slug}/index.md"
else
  hugo new "posts/${slug}.md"
fi

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