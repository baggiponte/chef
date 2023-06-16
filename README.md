<div align="center">

![chef logo](./docs/docs/assets/logo.gif)

[![pdm-managed](https://img.shields.io/badge/pdm-managed-blueviolet)](https://pdm.fming.dev)
[![pre-commit enabled](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![documentation mkdocs](https://img.shields.io/badge/documentation-mkdocs-0094F5)](https://www.mkdocs.org/)

</div>

`chef` is a [`cookiecutter`](https://www.cookiecutter.io/) template to develop internal packages and production ready Python code.

<img align="right" alt="coding" width="300" src="./docs/assets/ingredients.gif">

## ⚡ Features

- [`cruft`](https://github.com/cruft/cruft/) is used to ensure that your project is always up to date with this template.
- [`pdm`](https://github.com/pdm-project/pdm) as your dependency manager.
- [`pre-commit`](https://github.com/pre-commit/pre-commit) validates your commits.
- [`black`](https://github.com/psf/black) as code formatter.
- [`ruff`](https://github.com/charliermarsh/ruff) provides static code analysis and applies [`isort`](https://github.com/PyCQA/isort) import formatting.
- [`mypy`](https://github.com/python/mypy/) validates your type hints.
- [`pytest`](https://github.com/pytest-dev/pytest) runs your test suite.
- [`mkdocs`](https://github.com/mkdocs/mkdocs) builds your documentation, while [`mkdocs-material`](https://github.com/squidfunk/mkdocs-material) provides an elegant theme and [`mike`](https://github.com/jimporter/mike) automatically versions it.
- [`commitizen`](https://github.com/commitizen-tools/commitizen) ensures you follow Conventional commit style and generates your release changelogs.

> **Note**
>
> **Developer guidelines**
>
> - The template adopts to the `src` layout.
> - `mypy` should be configured with the strictest ruleset, though temporary per-module ignores are allowed.
> - `google` is the docstring style of choice.
> - `black` is used to format the code, while imports are sorted with `isort` style.
> - Follow [Semantic Versioning](https://semver.org/) for your releases.
> - Commit using the [Conventional Commit](https://www.conventionalcommits.org/en/v1.0.0/) style.

## 🛠️ How to

Install `pipx`, then use `pipx` to install `cruft`:

```bash
pipx install cruft
```

> **Warning**
>
> 🔎 Why `pipx`?
> `pip install --user` is not recommended, as it does not ensure dependency isolation. For this purpose, the [Python Packaging Authority (PyPA)](https://www.pypa.io/en/latest/) advises to use [`pipx`](https://pypa.github.io/pipx/). `pipx` installs and runs python CLIs in isolated environments. To install it, follow the instructions [here](https://pypa.github.io/pipx/#install-pipx).

### Create a New Project

```bash
cruft create git@github.com:baggiponte/chef
```

> **Note**
>
> 🎬 How to configure SSH
>
> Cloning over SSH is safer. Follow [this guide](https://www.youtube.com/watch?v=5o9ltH6YmtM).
> Alternatively, you can follow the steps in [this](https://github.com/git-merge-workshops/simplify-signing-with-ssh/blob/main/exercises/01-setup-workstation.md) workshop of GitHub's.

### Link an existing project to this template

```bash
cruft link git@github.com:baggiponte/chef
```

### Check or update

```bash
cruft check

cruft update
```

## 📝 Template fields

```json
{
  "author_name": "",
  "author_email": "",
  "repo_name": "",
  "package_name": "{{ cookiecutter.__repo_name.replace('-', '_') }}",
  "package_description": "",
  "package_emoji": "",
  "requires_python": "3.9"
}
```

- `author_name`: the maintainer name.
- `author_email`: the maintainer email address.
- `repo_name`: the repository name.
- `package_name`: the package name. Defaults to the `repo_name` where `-` are replaced with `_`.
- `package_description`: a one-line description of the package. It has to be effective and concise, so write it as if it would complete this prompt: "This library contains/offers ...".
- `package_emoji`: the emoji associated with the project.
- `requires_python`: the minimal python version required for the project.

## 🤗 Contributing

### Development

1. Clone the repository:

```bash
# using github cli
gh repo clone baggiponte/chef

# using git (SSH recommended)
git clone git@github.com:baggiponte/chef
```

2. Install `pdm`:

```bash
pipx install pdm
```
3. Install production and development dependencies.

The recommended approach is to use [`just`](https://github.com/casey/just). Install `just` with your favourite package manager, then run the following:

```
just setup
```

Alternatively, run the following:

```bash
pdm install --dev
pdm run pre-commit install --install-hooks
```

### Before submitting a PR

Run the following:

```
just pre-release
```

The following operations will be performed:

1. Format with `black` and `isort`.
2. Lint with `ruff`.
3. Run type checks with `mypy`.
4. Audit dependencies with `pip-audit`.
5. Check commit messages are consistent with Conventional Commits using `commitizen`.
6. Check whether a version bump is possible.
7. Run all tests.

## 📚 References and Credits

### Cookiecutter and Templates

- Wolt's [project template](https://blog.wolt.com/engineering/2022/08/11/project-template-for-modern-python-packages/) leverages `cookiecutter` and `cruft`.

### Typing and `mypy`

- [`mypy` in production at Spring](https://notes.crmarsh.com/using-mypy-in-production-at-spring)
- [Static types in Python, oh my(py)!](https://blog.zulip.com/2016/10/13/static-types-in-python-oh-mypy/) (one of the first posts of an enterprise using `mypy` to add types to an existing codebase)
- [Strictest `mypy` settings](https://blog.wolt.com/engineering/2021/09/30/professional-grade-mypy-configuration/)
- [Python is two languages now, and that's actually great](https://threeofwands.com/python-is-two-languages-now-and-thats-actually-great/)
