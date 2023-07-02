<div align="center">

![chef logo](./docs/docs/assets/logo.gif)

[![pdm-managed](https://img.shields.io/badge/pdm-managed-blueviolet)](https://pdm.fming.dev)
[![pre-commit enabled](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![documentation mkdocs](https://img.shields.io/badge/documentation-mkdocs-0094F5)](https://www.mkdocs.org/)

</div>

`chef` is an opinionated [`cookiecutter`](https://www.cookiecutter.io/) template to develop internal packages and production ready Python code.

<img align="right" alt="coding" width="300" src="./docs/assets/ingredients.gif">

## ⚡ Features

`chef` offers the latest tooling to make development a breeze, while enforcing coding standards such as formatting, linting, dependency auditing and an elegant command runner with powerful default recipes.

- [`cruft`](https://github.com/cruft/cruft/) ensures that your project is always up to date with this template.
- [`pdm`](https://github.com/pdm-project/pdm) is a modern dependency manager.
- [`just`](https://github.com/casey/just/) is a modern rewrite of `make` in Rust 🦀
- [`pre-commit`](https://github.com/pre-commit/pre-commit) validates your commits.
- [`black`](https://github.com/psf/black) as code formatter.
- [`ruff`](https://github.com/charliermarsh/ruff) provides static code analysis and applies [`isort`](https://github.com/PyCQA/isort) import formatting.
- [`mypy`](https://github.com/python/mypy/) validates your type hints.
- [`pytest`](https://github.com/pytest-dev/pytest) runs your test suite.
- [`mkdocs`](https://github.com/mkdocs/mkdocs) builds your documentation, while [`mkdocs-material`](https://github.com/squidfunk/mkdocs-material) provides an elegant theme. [`mike`](https://github.com/jimporter/mike) takes care of versioning your docs.
- [`commitizen`](https://github.com/commitizen-tools/commitizen) ensures you follow [Conventional commit style](https://www.conventionalcommits.org/en/) and generates your release changelogs according to [SemVer](https://semver.org/)

> **Note**
>
> **Developer guidelines**
>
> - The template adopts to the `src` layout.
> - `mypy` is configured with a strict ruleset. The recommended approach to loosen those constraints is by temporary per-module ignores.
> - `google` is the docstring style of choice.
> - `black` is used to format the code, while imports are sorted with `isort` style.
> - Releases follow [Semantic Versioning](https://semver.org/).
> - Commit follow the [Conventional Commit](https://www.conventionalcommits.org/en/v1.0.0/) specification.

> **Note**
>
> **`just` a command runner**
>
> `just` recipes will save you a ton of time! Install [just](https://github.com/casey/just/tree/master#installation). To see the available recipes, run the following:
>
> ```bash
> just
> ```

## 🛠️ How to

Install `cruft`, [`pdm`](https://pdm.fming.dev/latest/#installation) and [`just`](https://github.com/casey/just#installation):

```bash
pipx install cruft
pipx install pdm

# for example, on macOS
brew install just
```

> **Warning**
>
> 🔎 Why `pipx`?
> `pip install --user` is not recommended, as it does not ensure dependency isolation. For this purpose, the [Python Packaging Authority (PyPA)](https://www.pypa.io/en/latest/) advises to use [`pipx`](https://pypa.github.io/pipx/). `pipx` installs and runs python CLIs in isolated environments. To install it, follow the instructions [here](https://pypa.github.io/pipx/#install-pipx).

### Create a New Project

If you want to create a new package, or any coding project, you just have to run two short commands.

1. Initialise the template:

```bash
cruft create git@github.com:baggiponte/chef
```

> **Note**
>
> 🎬 How to configure SSH
>
> Cloning over SSH is safer. Follow [this guide](https://www.youtube.com/watch?v=5o9ltH6YmtM).
> Alternatively, you can follow the steps in [this](https://github.com/git-merge-workshops/simplify-signing-with-ssh/blob/main/exercises/01-setup-workstation.md) workshop of GitHub's.

2. Install all default dependencies and setup the GitHub secrets to run the CI/CD pipelines, run the following `just` recipe:

```bash
just init
```

For this command to execute successfully, you need to have [`pdm`](https://pdm.fming.dev/latest/#installation) and the [GitHub CLI](https://github.com/cli/cli#installation) installed.

This recipe will set three GitHub secrets:

* `PDM_PUBLISH_REPO`: the URL to publish your package to.
* `PDM_PUBLISH_USERNAME`: the username of the account used to publish the package.
* `PDM_PUBLISH_PASSWORD`: the authentication token.

If you do not want to configure CI/CD on GitHub, you can simply run the following:

```
just install
```

This will only install the dev dependencies.

Please feel free to open a PR to configure a recipe to configure CI/CD on other providers, such as GitLab.

> **Note**
>
> The `init` command configures three GitHub secrets to use PDM to publish the package you are developing to PyPI. For the command to run successfully, you should configure PDM accordingly:
>
> ```bash
> pdm config repository.pypi.url "https://upload.pypi.org/legacy"
> pdm config repository.pypi.username "__token__" # literally this
> pdm config repository.pypi.password "<your-PyPI-token>"
> ```
>
> To get a PyPI token, you can follow the guidelines [here](https://packaging.python.org/en/latest/tutorials/packaging-projects/#uploading-the-distribution-archives).
> You could also register an account on `test.pypi.org` to test in your CI/CD whether your package can be uploaded.

### Link an existing project to this template

```bash
cruft link git@github.com:baggiponte/chef
```

### Check or update the template

```bash
cruft check

cruft update
```

## 🙋 FAQ

### How do I write conventional commits?

Conventional commits are enforced with [`commitizen`](https://commitizen-tools.github.io/commitizen/), which is configured as a `pre-commit` hook at pre-push time. **In other words, if you attempt to push to a remote repo and your commit messages do not follow the conventional commits, the push will be rejected**. However, `commitizen` also offers a git command to commit with the conventional commit specification with a terminal UI. With `just`, you can simply run the following:

```bash
just commit
```

Or even the shorter `just c`. A prompt will guide you through the commit.

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

1. Install `pdm` and `just`.

2. Clone the repository:

```bash
# using github cli
gh repo clone baggiponte/chef

# using git (SSH recommended)
git clone git@github.com:baggiponte/chef
```

3. Install the dependencies:

```
just install
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
