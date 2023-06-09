<div align="center">

# {{ cookiecutter.__package_emoji }}{{ cookiecutter.__repo_name.replace('-', ' ').title() }}

[![pdm-managed](https://img.shields.io/badge/pdm-managed-blueviolet)](https://pdm.fming.dev)
[![cookiecutter chef](https://img.shields.io/badge/cookiecutter-chef-D4AA00?logo=cookiecutter&logoColor=fff)](https://github.com/baggiponte/chef)
<br>
[![code style black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/charliermarsh/ruff/main/assets/badge/v1.json)](https://github.com/charliermarsh/ruff)
[![imports isort](https://img.shields.io/badge/%20imports-isort-%231674b1)](https://pycqa.github.io/isort/)
[![checked with mypy](https://www.mypy-lang.org/static/mypy_badge.svg)](https://mypy.readthedocs.io/en/stable/)
[![pre-commit enabled](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
<br>
[![documentation mkdocs](https://img.shields.io/badge/documentation-mkdocs-0094F5)](https://www.mkdocs.org/)
[![docstyle google](https://img.shields.io/badge/%20style-google-459db9.svg)](https://numpydoc.readthedocs.io/en/latest/format.html)

</div>

## ⚡ Features

`{{ cookiecutter.__repo_name }}` is a {{ cookiecutter.__package_description.lower() }}.

## 📦 How to install

`{{ cookiecutter.__repo_name }}` can be installed with any package manager of your choice, though we use [`pdm`](https://pdm.fming.dev/latest/) for development.

```bash
pdm add {{ cookiecutter.__repo_name }}
```

If you need to install the unstable version, run:

```bash
# install from the main branch
pdm add git+ssh://git@github.com/{{ cookiecutter.author_github_handle }}/{{ cookiecutter.__repo_name }}
```

This is the same for any other package manager (e.g. `pip`, `poetry`...).

> **Note**
>
> 🎬 Install over SSH
>
> Under the hood, you package manager will still clone the repository. Cloning over SSH is safer: to set it up, follow [this guide](https://www.youtube.com/watch?v=5o9ltH6YmtM). Alternatively, you can follow the steps in [this](https://github.com/git-merge-workshops/simplify-signing-with-ssh/blob/main/exercises/01-setup-workstation.md) workshop of GitHub's.

In case you need to install a specific commit, branch or tag, you can use the following notation:

```bash
# install a specific commit, tag, branch
pdm add git+ssh://git@github.com/{{ cookiecutter.author_github_handle }}/{{ cookiecutter.__repo_name }}@<revision>
```

Where `<revision>` can be a commit hash, branch name, tag. This is especially useful when you want to test a feature branch.

## 🤗 Contributing

### Development

1. Install `pdm` and [`just`](https://github.com/casey/just#installation).

2. Clone the repository:

```bash
# using github cli
gh repo clone {{ cookiecutter.author_github_handle }}/{{ cookiecutter.__repo_name }}

# using git (SSH recommended)
git clone git@github.com:{{ cookiecutter.author_github_handle }}/{{ cookiecutter.__repo_name }}
```

> **Note**
>
> 🎬 How to configure SSH
>
> Cloning over SSH is safer. Follow [this guide](https://www.youtube.com/watch?v=5o9ltH6YmtM).
> Alternatively, you can follow the steps in [this](https://github.com/git-merge-workshops/simplify-signing-with-ssh/blob/main/exercises/01-setup-workstation.md) workshop of GitHub's.

2. Install `pdm`:

```bash
pipx install pdm
```

> **Warning**
>
> 🔎 Why `pipx`?
> `pip install --user` is not recommended, as it does not ensure dependency isolation. For this purpose, the [Python Packaging Authority (PyPA)](https://www.pypa.io/en/latest/) advises to use [`pipx`](https://pypa.github.io/pipx/). `pipx` installs and runs python CLIs in isolated environments. To install it, follow the instructions [here](https://pypa.github.io/pipx/#install-pipx).

3. Install production and development dependencies.

```
just install
```

### Before submitting a PR

Run the following:

```
just pre-release
just test
```

The following operations will be performed:

1. Format with `black` and `isort`.
2. Lint with `ruff`.
3. Run type checks with `mypy`.
4. Audit dependencies with `pip-audit`.
5. Check commit messages are consistent with Conventional Commits using `commitizen`.
6. Check whether a version bump is possible.
7. Run all tests.
