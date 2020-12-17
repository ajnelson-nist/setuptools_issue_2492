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

PYTHON3 ?= $(shell which python3.9 2>/dev/null || which python3.8 2>/dev/null || which python3.7 2>/dev/null || which python3.6 2>/dev/null || which python3)
ifeq ($(PYTHON3),)
$(error python3 not found)
endif

all: \
  check

.venv.done.log:
	@echo "INFO:Running .venv.done.log recipe in top_srcdir." >&2
	rm -rf venv
	$(PYTHON3) -m virtualenv \
	  --python=$(PYTHON3) \
	  venv
	source venv/bin/activate \
	  && pip install \
	    --upgrade \
	    pip
	touch $@

check: \
  .venv.done.log
	$(MAKE) PYTHON3=$(PYTHON3) --file $$PWD/test.mk --directory using_setup_cfg
	$(MAKE) PYTHON3=$(PYTHON3) --file $$PWD/test.mk --directory using_setup_py

clean:
	@$(MAKE) --file $$PWD/test.mk --directory using_setup_py clean
	@$(MAKE) --file $$PWD/test.mk --directory using_setup_cfg clean
	@rm -f .venv.done.log
	@rm -rf venv
