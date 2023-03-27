#!/bin/sh

# Add the mapping variable
mapping=(
  "nvim:$HOME/.config/nvim"
)

# Function to get the mapped target for a given file
get_mapped_target() {
  for entry in "${mapping[@]}"; do
    local source="${entry%%:*}"
    local target="${entry#*:}"
    if [ "$1" == "$source" ]; then
      echo "$target"
      return
    fi
  done
  echo ""
}

for name in *; do
  mapped_target=$(get_mapped_target "$name")

  # Check if a mapped target exists, otherwise use the default target
  if [ -n "$mapped_target" ]; then
    target="$mapped_target"
  else
    target="$HOME/.$name"
  fi

  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      echo "WARNING: $target exists but is not a symlink."
    fi
  else
    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'LICENSE' ] && [ "$name" != 'Brewfile' ]; then
      echo "Creating $target"
      ln -s "$PWD/$name" "$target"
    fi
  fi
done
