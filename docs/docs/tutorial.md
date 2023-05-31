# 🚀 Tutorial

## 🛠️ How to

Install `pipx`, then use `pipx` to install `cruft`:

```bash
pipx install cruft
```

> **Warning**
>
> 🔎 Why `pipx`?
> `pip install --user` is not recommended, as it does not ensure dependency isolation. For this purpose, the [Python Packaging Authority (PyPA)](https://www.pypa.io/en/latest/) advises to use [`pipx`](https://pypa.github.io/pipx/). `pipx` installs and runs python CLIs in isolated environments. To install it, follow the instructions [here](https://pypa.github.io/pipx/#install-pipx).

### Create a new project

```bash
cruft create https://github.com/baggiponte/chef
```

### Link an existing project to this template

```bash
cruft link https://github.com/baggiponte/chef
```

### Check or update

```bash
cruft check https://github.com/baggiponte/chef

cruft update https://github.com/baggiponte/chef
```

## 📝 Template fields

```json
{
  "author_name": "",
  "author_email": "",
  "author_github_handle": "",
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
