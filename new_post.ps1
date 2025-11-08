# new-hugo-post.ps1
# Description: Interactive script to create a new Hugo blog post with optional Page Bundle support

Write-Host "=== Hugo New Post Creator ===`n"

# Get post title
$title = Read-Host "Enter the post title (e.g., My First Blog Post)"

# Generate slug (replace spaces with hyphens and convert to lowercase)
$slug = $title -replace '\s+', '-'
$slug = $slug.ToLower()

# Ask whether to create a folder (page bundle)
$pageBundle = Read-Host "Create as a folder with index.md (page bundle)? (y/n)"

# Get category and tags
$category = Read-Host "Enter category (optional, leave blank to skip)"
$tags = Read-Host "Enter tags (comma-separated, optional)"

# Determine file path
if ($pageBundle -eq "y") {
	$filePath = "content/posts/$slug/index.md"
}
else {
	$filePath = "content/posts/$slug.md"
}

Write-Host "`nFile to be created: $filePath"

# Confirm action
$confirm = Read-Host "Proceed with creation? (y/n)"
if ($confirm -ne "y") {
	Write-Host "Operation cancelled."
	exit
}

# Run Hugo command
if ($pageBundle -eq "y") {
	hugo new "posts/$slug/index.md"
}
else {
	hugo new "posts/$slug.md"
}

# Optionally write front matter
if (Test-Path $filePath) {
	$frontMatter = @"
---
title: "$title"
date: $(Get-Date -Format "yyyy-MM-ddTHH:mm:sszzz")
categories: [$category]
tags: [$tags]
draft: true
---
"@
	Set-Content -Path $filePath -Value $frontMatter -Encoding UTF8
	Write-Host "`nPost created successfully: $filePath"
}
else {
	Write-Host "`nFailed to create the file. Please check your Hugo setup."
}