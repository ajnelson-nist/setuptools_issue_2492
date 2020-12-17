#!/usr/bin/make -f

# This software was developed at the National Institute of Standards
# and Technology by employees of the Federal Government in the course
# of their official duties. Pursuant to title 17 Section 105 of the
# United States Code this software is not subject to copyright
# protection and is in the public domain. NIST assumes no
# responsibility whatsoever for its use by other parties, and makes
# no guarantees, expressed or implied, about its quality,
# reliability, or any other characteristic.
#
# We would appreciate acknowledgement if the software is used.

SHELL := /bin/bash

# This Makefile's execution context will be one of /using_setup_cfg or /using_setup_py.
top_srcdir := $(shell cd .. ; pwd)

PYTHON3 ?= $(shell which python3.9 2>/dev/null || which python3.8 2>/dev/null || which python3.7 2>/dev/null || which python3.6 2>/dev/null || which python3)
ifeq ($(PYTHON3),)
$(error python3 not found)
endif

all: \
  check

.dist.done.log: \
  $(top_srcdir)/.venv.done.log \
  setup.cfg \
  setup.py
	@echo "INFO:Running .dist.done.log recipe in $$(basename $$PWD)." >&2
	rm -rf dist
	source $(top_srcdir)/venv/bin/activate \
	  && python3 setup.py \
	    bdist_wheel
	touch $@

check: \
  .dist.done.log
	@echo "INFO:Running check recipe in $$(basename $$PWD)." >&2
	@echo -n "INFO:Python version is " >&2
	@source $(top_srcdir)/venv/bin/activate \
	  && python3 \
	    --version \
	    >&2
	@echo -n "INFO:setuptools.__version__ = " >&2
	@source $(top_srcdir)/venv/bin/activate \
	  && python3 \
	    -c "import setuptools ; print(setuptools.__version__)" \
	    >&2
	@echo -n "INFO:example_pkg.__version__ = " >&2
	@$(PYTHON3) -c "import example_pkg ; print(example_pkg.__version__)" >&2
	@echo    "INFO:bdist_wheel file is expected to be: dist/example_pkg-0.0.1-py3-none-any.whl" >&2
	@echo -n "INFO:bdist_wheel file is generated as:   " >&2
	@ls dist/*.whl >&2
	test -r dist/*0.0.1*whl
	@echo "INFO:Test passed in $$(basename $$PWD)!" >&2

clean:
	@rm -f .dist.done.log
	@rm -rf *.egg-info build dist
