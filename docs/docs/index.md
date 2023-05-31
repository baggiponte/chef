<center>

![chef logo](./assets/logo.gif)

_Zero-setup, production-grade, standard compliant Python project template_

[![pdm-managed](https://img.shields.io/badge/pdm-managed-blueviolet)](https://pdm.fming.dev)
[![pre-commit enabled](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![documentation mkdocs](https://img.shields.io/badge/documentation-mkdocs-0094F5)](https://www.mkdocs.org/)

</center>

`chef` is a [`cookiecutter`](https://www.cookiecutter.io/) template to develop internal packages and production ready Python code. `chef` provides a way to effortlessly enforce coding standards, and provides some stringent guidelines by default. Nevertheless, these configurations are malleable and can be softened on a per-project (or, better, per-submodule) basis. Here you will find the installation guidelines, as well as the overview of the technical and stylistic choices.

## 🔖 Index

- ⚡ [**Feature Overview**](./overview.md)
- 🚀 [**Tutorial**](./tutorial.md)
- ♻️ [**Dependency Management**](./pdm.md)
- 🎨 [**Code Style**](./style.md)
- 📚 [**Documentation Style**](./docs.md)
- 🏷️ [**Commit Style, Versioning and Changelog**](./commitizen.md)
- 📦 [**Publish to PyPI**](./publish.md)

## 🏫 Tutorial

### Create a new project

To create a new project, run the following:

```bash
cruft create git@github.com:baggiponte/chef
```

You will be prompted to fill these values:

```{ .json .no-copy }
{
  "author_name": "",
  "author_email": "",
  "repo_name": "",
  "package_name": "{{ cookiecutter.__repo_name.replace('-', '_') }}",
  "package_description": "",
  "package_emoji": "",
  "requires_python": "3.9",
}
```

- `author_name`: the maintainer name.
- `author_email`: the maintainer email address.
- `repo_name`: the repository name.
- `package_name`: the package name. Defaults to the `repo_name` where `-` are replaced with `_`.
- `package_description`: a one-line description of the package. It has to be effective and concise, so write it as if it would complete this prompt: "This library contains/offers ...".
- `package_emoji`: the emoji associated with the project.
- `requires_python`: the minimal python version required for the project.


### Link an existing project

```bash
cruft link git@github.com:baggiponte/chef
```

### Update your project with the upstream cookiecutter

```bash
cruft update
```
