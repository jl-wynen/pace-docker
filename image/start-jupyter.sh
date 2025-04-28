#!/usr/bin/env bash

set -e

project_dir=$1
venv_dir="$HOME/project_venv"

# Include uv in PATH
PATH=$PATH:"$HOME/.local/bin"

echo "Project dir: $project_dir"
# To ensure that uv picks up the project's Python version:
cd "$project_dir"

if [ ! -e "$venv_dir" ]; then
  echo "Creating venv for Python"
  if [ "$PYTHON_VERSION" ]; then
    uv_python_arg="-p $PYTHON_VERSION"
  else
    uv_python_arg=""
  fi
  # shellcheck disable=SC2086
  uv venv $uv_python_arg "$venv_dir"
fi

# shellcheck disable=SC2086
uv pip install \
  -e "$project_dir" \
  $PYTHON_DEPENDENCIES \
  jupyter \
  --compile-bytecode \
  --no-progress \
  --python "$venv_dir/bin/python"

"$venv_dir/bin/python" -m jupyter lab --no-browser
