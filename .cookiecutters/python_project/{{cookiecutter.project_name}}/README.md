{{cookiecutter.project_name}}
===========

{{cookiecutter.project_name}} is a [Nagios]/[Icinga2] plugin which {{cookiecutter.project_description}}

Requires Python 3.9+

# Installation

You can install with [pip]:

```sh
python3 -m pip install {{cookiecutter.project_name}}
```

Or install from source:

```sh
git clone <url>
pip install {{cookiecutter.project_name}}
```

# Usage

\[[...]\]

# Limitations

\[[...]\]

# Contributing

Merge requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

To run the test suite:

```bash
# Dependent targets create venv and install dependencies
make
```

Please make sure to update tests along with any changes.

# License

{{cookiecutter.license}}


[Icinga2]: https://en.wikipedia.org/wiki/Icinga
[Nagios Plugin Development Guidelines]: https://nagios-plugins.org/doc/guidelines.html
[Nagios]: https://en.wikipedia.org/wiki/Nagios
[pip]: https://pip.pypa.io/en/stable/
