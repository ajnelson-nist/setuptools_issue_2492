#!/usr/bin/env python3

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

import setuptools

# This function call is adapted from documentation on this page:
# https://packaging.python.org/tutorials/packaging-projects/#creating-setup-py
# Retrieved 2020-12-17.
# The config data is drawn from this page:
# https://setuptools.readthedocs.io/en/latest/userguide/declarative_config.html

if __name__ == "__main__":
    setuptools.setup(
      version="attr: example_pkg.__version__"
    )
