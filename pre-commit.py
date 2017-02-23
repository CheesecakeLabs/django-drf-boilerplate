#!/usr/bin/env python3
"""
Pre-commit hook that checks errors with flake8.
Adapted from: https://github.com/cbrueffer/pep8-git-hook
"""
import os
import re
import shutil
import subprocess
import sys
import tempfile

# Ignore list:
# E501: 79-char per line limit
IGNORE_LIST = ['E501']


def system(*args, **kwargs):
    """
    Execute a system process and returns the output, errors and exit code
    """
    kwargs.setdefault('stdout', subprocess.PIPE)
    proc = subprocess.Popen(args, **kwargs)
    out, err = proc.communicate()
    return out, err, proc.returncode


def find_modified_and_added_py_files():
    """
    Find staged python files that are either modified or added files. This
    method ignores deleted files.
    """
    modified = re.compile('^[AM]+\s+(?P<name>.*\.py$)', re.MULTILINE)
    files, err, code = system('git', 'status', '--porcelain')

    if code != 0:
        raise Exception(err)

    return modified.findall(files.decode("utf-8"))


def create_temp_dir_staged(files):
    """
    Create and return a temporary directory with staged version of listed
    files.

    Arguments:
    files -- list with filenames
    """
    tempdir = tempfile.mkdtemp()

    for name in files:
        filename = os.path.join(tempdir, name)
        filepath = os.path.dirname(filename)

        if not os.path.exists(filepath):
            os.makedirs(filepath)

        with open(filename, 'w') as f:
            system('git', 'show', ':' + name, stdout=f)

    return tempdir


def main():
    # Create a temporary directory with staged python files
    files = find_modified_and_added_py_files()
    verify_dir = create_temp_dir_staged(files)

    # Build ignore list string and run flake8 on this directory
    ignore_violations = ','.join(IGNORE_LIST)
    out, err, code = system(
        'python',
        '-mflake8',
        '--ignore',
        ignore_violations,
        verify_dir
    )

    # Remove temporary directory
    shutil.rmtree(verify_dir)

    # If flake8 complains, show violations and exit with error
    if out:
        print("""Flake8 violations have been detected. Please fix them or
              force the commit with "git commit --no-verify".\n""")
        # Clean temporary directory name from output and display
        print(out.decode('utf-8').replace(verify_dir, ''))
        sys.exit(1)

    # If no output complains, but there was an error on flake8 command, exit
    # with error anyway
    if code != 0:
        sys.exit(1)
        raise Exception(err)


if __name__ == '__main__':
    main()
