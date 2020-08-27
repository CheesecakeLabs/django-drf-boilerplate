"""
Does the following:

1. Inits git if used
3. Deletes config utils if not needed
"""
from __future__ import print_function
import os
import shutil
from subprocess import Popen

# Get the root project directory
PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)

def remove_file(filename):
    """
    generic remove file from project dir
    """
    fullpath = os.path.join(PROJECT_DIRECTORY, filename)
    if os.path.exists(fullpath):
        os.remove(fullpath)

def init_git():
    """
    Initialises git on the new project folder
    """
    GIT_COMMANDS = [
        ["git", "init"],
        ["git", "add", "."],
        ["git", "commit", "-a", "-m", "Initial Commit."]
    ]

    for command in GIT_COMMANDS:
        git = Popen(command, cwd=PROJECT_DIRECTORY)
        git.wait()

def remove_health_check():
    """
    Removes files needed for viper config utils
    """
    os.remove(os.path.join(
        PROJECT_DIRECTORY, "src", "helpers", "health_check.py"
    ))

def remove_circleci():
    """
    Removes files needed for viper config utils
    """
    shutil.rmtree(os.path.join(
        PROJECT_DIRECTORY, ".circleci"
    ))

if '{{ cookiecutter.enable_health_check }}'.lower() == 'n':
    remove_health_check()

if '{{ cookiecutter.use_circleci }}'.lower() == 'n':
    remove_circleci()

# Run git as last
if '{{ cookiecutter.use_git }}'.lower() == 'y':
    init_git()
else:
    remove_file(".gitignore")
