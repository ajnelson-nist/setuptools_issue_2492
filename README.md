This repository is provided in support of a bug report for Python's [setuptools](https://github.com/pypa/setuptools).


## Usage

This test runs in a POSIX environment with networking, presuming Bash, Make, and Python 3 with `virtualenv` are installed.

After cloning the repository, run `make`.  `make` is expected to exit in an error state on the `check` recipe until [Issue 2492](https://github.com/pypa/setuptools/issues/2492) is resolved.


## Test outline

The `check` recipe runs a test defined in [`test.mk`](test.mk) on two directories:
* `using_setup_cfg`, where [`setup.cfg`](using_setup_cfg/setup.cfg) supplies the package version with an attribute descriptor.
* `using_setup_py`, where [`setup.py`](using_setup_py/setup.py) supplies the package version with the same syntax.


### Current status of "make check"

This is the current shell transcript of `make check`:

```
/Applications/Xcode.app/Contents/Developer/usr/bin/make PYTHON3=/opt/local/bin/python3.9 --file $PWD/test.mk --directory using_setup_cfg
INFO:Running check recipe in using_setup_cfg.
INFO:Python version is Python 3.9.1
INFO:setuptools.__version__ = 51.0.0
INFO:example_pkg.__version__ = 0.0.1
INFO:bdist_wheel file is expected to be: dist/example_pkg-0.0.1-py3-none-any.whl
INFO:bdist_wheel file is generated as:   dist/example_pkg-0.0.1-py3-none-any.whl
test -r dist/*0.0.1*whl
INFO:Test passed in using_setup_cfg!
/Applications/Xcode.app/Contents/Developer/usr/bin/make PYTHON3=/opt/local/bin/python3.9 --file $PWD/test.mk --directory using_setup_py
INFO:Running check recipe in using_setup_py.
INFO:Python version is Python 3.9.1
INFO:setuptools.__version__ = 51.0.0
INFO:example_pkg.__version__ = 0.0.1
INFO:bdist_wheel file is expected to be: dist/example_pkg-0.0.1-py3-none-any.whl
INFO:bdist_wheel file is generated as:   dist/example_pkg-attr_.example_pkg._version_-py3-none-any.whl
test -r dist/*0.0.1*whl
make[1]: *** [check] Error 1
make: *** [check] Error 2
```

This warning message appeared in the transcript of the build in `using_setup_py`:

```
UserWarning: The version specified ('attr: example_pkg.__version__') is an invalid version, this may not work as expected with newer versions of setuptools, pip, and PyPI. Please see PEP 440 for more details.
```
