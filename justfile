setup:
  if ! [[ -d .git ]]; then git init; fi
  pdm install --dev
  pdm run pre-commit install --install-hooks

update:
  pdm update
  pdm run pre-commit install-hooks
  pdm run pre-commit autoupdate

audit:
  pdm run pre-commit run pip-audit

export:
  pdm export --prod -f=requirements.txt

preview-docs:
  pdm run mike serve --config-file=docs/mkdocs.yml

preview-bump:
  pdm run cz bump --check-consistency --dry-run

bump:
  pdm run cz bump
  git push
  git push --tag

release: audit bump
