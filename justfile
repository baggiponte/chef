# List all available recipes
help:
  @just --list

# Setup git, install dependencies, install pre-commit hooks
setup:
  @if ! [[ -d .git ]]; then git init; fi
  pdm install --dev
  pdm run pre-commit install --install-hooks

alias init := setup

# Update dependencies and update pre-commit hooks
update:
  pdm sync
  pdm update
  pdm run pre-commit install-hooks
  pdm run pre-commit autoupdate

# Audit dependencies with pip-audit
@audit:
  pdm run pip-audit

# Check whether the commit messages follow the conventional commit format
@check-commits:
  pdm run cz check --rev-range origin/main..HEAD

# Check the version can be bumped without errors
@check-version:
  pdm run cz bump --check-consistency --dry-run

# Run all pre-release checks
pre-release: audit check-commits check-version

# Export production dependencies to requirements.txt
export:
  pdm export --prod -f=requirements > requirements.txt
  pdm export --no-default --dev -f=requirements > requirements-dev.txt

# Live preview the documentation
preview-docs:
  pdm run mike serve --config-file=docs/mkdocs.yml

# Release a new version
release: pre-release
  pdm run cz bump
  git push
  git push --tag

# Release a new version
alias bump := release
