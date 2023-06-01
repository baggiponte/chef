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

check-bump:
  pdm run cz bump --check-consistency --dry-run

pre-push: audit check-bump

bump: pre-push
  pdm run cz bump
  git push
  git push --tag

alias release := bump
