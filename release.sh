#!/bin/bash

# XcodeBuildMCP iOS Template Release Script
# Usage: ./release.sh [major|minor|patch]

set -e

# Default to patch version bump
VERSION_TYPE=${1:-patch}

# Check if we're in the right directory
if [[ ! -f "MyProject.xcworkspace/contents.xcworkspacedata" ]]; then
  echo "Error: Must be run from the iOS template root directory"
  exit 1
fi

# Check for uncommitted changes
if [[ -n $(git status -s) ]]; then
  echo "Error: You have uncommitted changes. Please commit or stash them first."
  exit 1
fi

# Ensure we're on main branch
CURRENT_BRANCH=$(git branch --show-current)
if [[ "$CURRENT_BRANCH" != "main" ]]; then
  echo "Error: Releases must be created from the main branch. Current branch: $CURRENT_BRANCH"
  exit 1
fi

# Fetch latest tags
git fetch --tags

# Get the latest tag or default to v0.0.0
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
echo "Latest tag: $LATEST_TAG"

# Remove the 'v' prefix for version calculation
CURRENT_VERSION=${LATEST_TAG#v}

# Split version into components
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# Increment version based on type
case $VERSION_TYPE in
  major)
    NEW_VERSION="$((MAJOR + 1)).0.0"
    ;;
  minor)
    NEW_VERSION="$MAJOR.$((MINOR + 1)).0"
    ;;
  patch)
    NEW_VERSION="$MAJOR.$MINOR.$((PATCH + 1))"
    ;;
  *)
    echo "Error: Invalid version type. Use major, minor, or patch"
    exit 1
    ;;
esac

NEW_TAG="v$NEW_VERSION"
echo "New version will be: $NEW_TAG"

# Create release notes file
RELEASE_NOTES="release-notes-$NEW_VERSION.md"
cat > "$RELEASE_NOTES" << EOF
# Release $NEW_TAG

## What's Changed
- 

## Full Changelog
https://github.com/cameroncooke/XcodeBuildMCP-iOS-Template/compare/$LATEST_TAG...$NEW_TAG
EOF

echo "Created release notes file: $RELEASE_NOTES"
echo "Please edit the release notes and then press Enter to continue..."
read -r

# Read the release notes
RELEASE_BODY=$(cat "$RELEASE_NOTES")

# Create and push the tag
git tag -a "$NEW_TAG" -m "Release $NEW_TAG"
git push origin "$NEW_TAG"

# Create the GitHub release with the template as a zip file
echo "Creating GitHub release..."

# Create a temporary directory for the release
TEMP_DIR=$(mktemp -d)
RELEASE_NAME="XcodeBuildMCP-iOS-Template-$NEW_VERSION"

# Copy all template files to temp directory
cp -r . "$TEMP_DIR/$RELEASE_NAME"

# Remove git directory and release script from the template
rm -rf "$TEMP_DIR/$RELEASE_NAME/.git"
rm -f "$TEMP_DIR/$RELEASE_NAME/release.sh"
rm -f "$TEMP_DIR/$RELEASE_NAME/$RELEASE_NOTES"

# Create zip file
cd "$TEMP_DIR"
zip -r "$RELEASE_NAME.zip" "$RELEASE_NAME"

# Move zip to original directory
mv "$RELEASE_NAME.zip" "$OLDPWD/"
cd "$OLDPWD"

# Clean up temp directory
rm -rf "$TEMP_DIR"

# Create GitHub release using gh CLI
gh release create "$NEW_TAG" \
  --title "Release $NEW_TAG" \
  --notes "$RELEASE_BODY" \
  "$RELEASE_NAME.zip"

# Clean up
rm -f "$RELEASE_NOTES"
rm -f "$RELEASE_NAME.zip"

echo "✅ Release $NEW_TAG created successfully!"
echo ""
echo "The release includes:"
echo "- Tag: $NEW_TAG"
echo "- Asset: $RELEASE_NAME.zip"
echo ""
echo "View the release at: https://github.com/cameroncooke/XcodeBuildMCP-iOS-Template/releases/tag/$NEW_TAG"