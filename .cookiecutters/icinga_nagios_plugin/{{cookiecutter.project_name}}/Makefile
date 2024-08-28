SHELL := /bin/bash
DEPENDENCIES := venv/dependencies.timestamp
STATIC_PYLINT := venv/pylint.timestamp
STATIC_BLACK := venv/black.timestamp
STATIC_MYPY := venv/mypy.timestamp
PYTHON_FILES := $(shell find . -path ./venv -prune -o -name '*.py' -print)
PACKAGE := {{cookiecutter.project_name}}
VENV := venv/venv.timestamp
VERSION := $(shell python3 -c 'import {{cookiecutter.project_name}}; print({{cookiecutter.project_name}}.__version__)')
BUILD_DIR := dist_$(VERSION)
BUILD := $(BUILD_DIR)/.build.timestamp
_WARN := "\033[33m[%s]\033[0m %s\n"  # Yellow text for "printf"
_TITLE := "\033[32m[%s]\033[0m %s\n" # Green text for "printf"
_ERROR := "\033[31m[%s]\033[0m %s\n" # Red text for "printf"

all: static-analysis test

$(VENV):
	python3 -m venv venv
	touch $(VENV)
$(DEPENDENCIES): $(VENV) requirements-make.txt requirements.txt
	# Install Python dependencies, runtime *and* test/build
	./venv/bin/python3 -m pip install --requirement requirements-make.txt
	./venv/bin/python3 -m pip install --requirement requirements.txt
	touch $(DEPENDENCIES)

$(STATIC_BLACK): $(PYTHON_FILES) $(DEPENDENCIES)
	# Check style
	@./venv/bin/black --check $(PYTHON_FILES)
	@touch $(STATIC_BLACK)
$(STATIC_MYPY): $(PYTHON_FILES) $(DEPENDENCIES)
	# Check typing
	@./venv/bin/mypy $(PYTHON_FILES)
	@touch $(STATIC_MYPY)
$(STATIC_PYLINT): $(PYTHON_FILES) $(DEPENDENCIES)
	# Lint
	@./venv/bin/pylint $(PYTHON_FILES)
	@touch $(STATIC_PYLINT)
.PHONY: static-analysis
static-analysis: $(DEPENDENCIES) $(STATIC_PYLINT) $(STATIC_MYPY) $(STATIC_BLACK)
	# Hooray all good

.PHONY: test
test: $(DEPENDENCIES)
	./venv/bin/pytest tests/

.PHONY: test-verbose
test-verbose: $(DEPENDENCIES)
	./venv/bin/pytest  -rP -o log_cli=true --log-cli-level=10 tests/

.PHONY: hooks
hooks:
	@if $(MAKE) -s confirm-hooks ; then \
	     git config -f .gitconfig core.hooksPath .githooks ; \
	     echo 'git config -f .gitconfig core.hooksPath .githooks'; \
	     git config --local include.path ../.gitconfig ; \
	     echo 'git config --local include.path ../.gitconfig' ; \
	fi

.PHONY: fix
fix: $(DEPENDENCIES)
	# Enforce style in-place with Black
	@./venv/bin/black $(PYTHON_FILES)

.PHONY: changelog-verify
changelog-verify: $(DEPENDENCIES)
	# Verify changelog format
	./venv/bin/kacl-cli verify
	# Verify changelog version matches current
	@if [ -z "$$(./venv/bin/kacl-cli current)" ] || [[ $(VERSION) == "$$(./venv/bin/kacl-cli current)" ]]; then true; else false; fi
	# Yay

.PHONY: package
package: changelog-verify $(BUILD) static-analysis test

$(BUILD): $(DEPENDENCIES)
	# Build the package
	@if grep --extended-regexp "^ *(Documentation|Bug Tracker|Source|url) = *$$" "setup.cfg"; then \
		echo 'FAILURE: Please fully fill out the values for `Documentation`, `Bug Tracker`, `Source`, and `url` in `setup.cfg` before packaging' && \
		exit 1; \
		fi
	mkdir --parents $(BUILD_DIR)
	./venv/bin/python3 -m build --outdir $(BUILD_DIR)
	touch $(BUILD)

.PHONY: publish
publish: package
	@test $${TWINE_PASSWORD?Please set environment variable TWINE_PASSWORD in order to publish}
	./venv/bin/python3 -m twine upload --username __token__ $(BUILD_DIR)/*

.PHONY: publish-test
publish-test: package
	@test $${TWINE_PASSWORD?Please set environment variable TWINE_PASSWORD in order to publish}
	./venv/bin/python3 -m twine upload --repository testpypi --username __token__ $(BUILD_DIR)/*

.PHONY: confirm-hooks
confirm-hooks:
	REPLY="" ; \
	printf "⚠ This will configure this repository to use \`core.hooksPath = .githooks\`. You should look at the hooks so you are not surprised by their behavior.\n"; \
	read -p "Are you sure? [y/n] > " -r ; \
	if [[ ! $$REPLY =~ ^[Yy]$$ ]]; then \
		printf $(_ERROR) "KO" "Stopping" ; \
		exit 1 ; \
	else \
		printf $(_TITLE) "OK" "Continuing" ; \
		exit 0; \
	fi \

.PHONY: clean
clean:
	# Cleaning everything but the `venv`
	rm -rf ./dist_*
	rm -rf ./{{cookiecutter.project_name}}.egg-info/
	rm -rf ./.mypy_cache
	rm -rf ./.pytest_cache
	find . -depth -name '__pycache__' -type d -exec rm -rf {} \;
	find . -name '*.pyc' -a -type f -delete
	# Done

.PHONY: clean-venv
clean-venv:
	rm -rf ./venv
	# Done
