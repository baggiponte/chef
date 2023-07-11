set shell := ["zsh", "-uc"]
set positional-arguments

# List all available recipes
help:
  @just --list

# Create a git repo if not exists, install dependencies and pre-commit hooks
install:
  #!/usr/bin/env zsh
  set -euo pipefail
  if ! [[ -d .git ]]; then
    git init
  fi

  {{just_executable()}} needs pdm

  pdm install --dev
  pdm run pre-commit install --install-hooks

# Configure GitHub Actions
config repo="pypi":
  #!/usr/bin/env zsh
  set -euo pipefail

  {{just_executable()}} needs gh grep
  {{just_executable()}} check-repository {{repo}}

  if ! gh repo list | grep -qc baggiponte/chef; then
    while true; do
      read -r "No remote repository found. Do you want to create a new repository? (y/n): " REPLY

      case $REPLY in
        [Yy])
          read -r "Do you want to create a private repository? (y/n): " PRIVATE
          case $PRIVATE in
            [Yy])
              gh repo create baggiponte/chef --private --source=. --push
              ;;
            [Nn])
              gh repo create baggiponte/chef --public --source=. --push
              ;;
            *)
              echo "Invalid input. Please enter 'y' or 'n'."
              ;;
          esac
          break
          ;;
        [Nn])
          exit 0
          ;;
        *)
          echo "Invalid input. Please enter 'y' or 'n'."
          ;;
      esac
    done
  elif ! git remote get-url origin 1>/dev/null; then
    while true; do
      read -r "A repo with the same name already exists. Do you want to add it as a remote? (y/n): " REPLY

      case $REPLY in
        [Yy])
          git remote add origin git@github.com:baggiponte/chef
          break
          ;;
        [Nn])
          exit 0
          ;;
        *)
          echo "Invalid input. Please enter 'y' or 'n'."
          ;;
      esac
    done
  fi

  gh secret set PDM_PUBLISH_REPO --body="$(pdm config repository.{{repo}}.url)" --app=actions
  gh secret set PDM_PUBLISH_USERNAME --body="$(pdm config repository.{{repo}}.username)" --app=actions
  gh secret set PDM_PUBLISH_PASSWORD --body="$(pdm config repository.{{repo}}.password)" --app=actions

  if [[ $(gh secret list | grep -c PERSONAL_ACCESS_TOKEN ) -eq 0 ]]; then
    echo "You need to set a PERSONAL_ACCESS_TOKEN secret for the workflow to work.\n"
    echo "This cannot be done automatically, but you can do it manually:\n"
    echo "gh secret set PERSONAL_ACCESS_TOKEN --body=<your token> --app=actions\n"
    echo "⚠️ If you do this, though, the token will persist in your shell history."

# Install dependencies, hooks and configure secrets for GitHub Actions
init: config install

# Update dependencies and update pre-commit hooks
update:
  pdm sync
  pdm update
  pdm run pre-commit install-hooks
  pdm run pre-commit autoupdate

# Audit dependencies with pip-audit
@audit:
  pdm run pip-audit

# Run all pre-release checks
pre-release: audit check-commits check-bump

# Bump the version
bump: check-commits check-bump
  pdm run cz bump

# Release a new version
release: audit bump
  git push
  git push --tag

# Publish the package to PyPI
@publish repo="pypi":
  {{just_executable()}} check-repository {{repo}}
  pdm publish -r={{repo}}

# Commit with conventional commits
@commit: check-commits
  pdm run cz commit

alias c := commit

# Export production and dev dependencies
export:
  pdm export --prod -f=requirements > requirements.txt
  pdm export --no-default --dev -f=requirements > requirements-dev.txt

# Live preview the documentation
preview-docs:
  pdm run mike serve --config-file=docs/mkdocs.yml

# Check whether the commit messages follow the conventional commit format
check-commits:
  #! /usr/bin/env zsh
  set -euo pipefail

  local revs
  revs=($(git rev-list origin/main..HEAD))

  if [[ $#revs -eq 0 ]]; then
    echo "No commits to check."
    exit 0
  else
    pdm run cz check --rev-range origin/main..HEAD
  fi

# Check the version can be bumped without errors
@check-bump:
  pdm run cz bump --dry-run

# Assert a command is available
[private]
needs +commands:
  #!/usr/bin/env zsh
  set -euo pipefail
  for cmd in "$@"; do
    if ! command -v $cmd &> /dev/null; then
      echo "$cmd binary not found. Did you forget to install it?"
      exit 1
    fi
  done

# Check a publishing repo is configured
[private]
check-repository +repos:
  #!/usr/bin/env zsh
  for repo in "$@"; do
    local configs 1>/dev/null
    configs=($(pdm config repository.$repo)) 2>/dev/null
    if [[ $#configs -eq 0 ]]; then
      echo "No repository $repo found."
      echo "Request the push token, then run:"
      echo "pdm config repository.$repo.url <url>"
      echo "pdm config repository.$repo.username <username>"
      echo "pdm config repository.$repo.password <password>"
      exit 1
    fi
  done
