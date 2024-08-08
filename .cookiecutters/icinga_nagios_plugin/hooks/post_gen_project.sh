#!/usr/bin/env bash

# When deploying from local disk it ignores the `.gitignore` in the project
# directory? Whatever, here is a workaround

mv "{{cookiecutter.project_name}}/gitignore" "{{cookiecutter.project_name}}/.gitignore"
