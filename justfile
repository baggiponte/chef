setup:
  @if ! [[ -d .git ]]; then git init; fi
  pdm install --dev
  pdm run pre-commit install --install-hooks

update:
  pdm sync
  pdm update
  pdm run pre-commit install-hooks
  pdm run pre-commit autoupdate

audit:
  pdm run pre-commit run pip-audit

check-commits:
  pdm run cz check --rev-range origin/main..HEAD

check-version:
  pdm run cz bump --check-consistency --dry-run

pre-release: audit check-commits check-version

export:
  pdm export --prod -f=requirements.txt

preview-docs:
  pdm run mike serve --config-file=docs/mkdocs.yml

release: pre-release
  pdm run cz bump
  git push
  git push --tag

alias bump := release
