#!/bin/bash
# Run via `update-brew --clean` rather than directly, so it always runs
# after a fresh `brew bundle` apply.
set -uo pipefail

echo "--- Starting Homebrew Ghost Package Cleanup ---"

# 1. Identify and remove Casks (GUI apps) manually deleted from /Applications
echo "Checking for missing GUI applications..."
for cask in $(brew list --cask); do
  # Extract the expected .app path from brew info
  app_path=$(brew info --cask "$cask" | grep -oE "/Applications/[^ ]+\.app" | head -1)

  # If a path was found but the directory does not exist on disk
  if [[ -n "$app_path" && ! -d "$app_path" ]]; then
    echo "Found ghost cask: $cask (Expected at $app_path)"
    brew uninstall --cask --force "$cask"
  fi
done

# 2. Remove orphaned dependencies (formulae no longer needed by any installed app)
echo "Removing orphaned dependencies..."
brew autoremove

# 3. Clear the download cache and remove old versions
echo "Cleaning up Homebrew cache and old versions..."
brew cleanup --prune=all

# 4. Verify health and link consistency
echo "Running brew doctor for final verification..."
brew doctor

echo "--- Cleanup Complete ---"
