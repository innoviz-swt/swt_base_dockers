import subprocess
import os
from pathlib import Path
import sys

venvbase = Path("venv/Scripts")


def venv_run_process(cmd: str):
    # run subprocess
    p = subprocess.Popen(cmd)

    p.wait()

    # validate error code
    if p.returncode != 0:
        msg = f"process exited with error code '{p.returncode}'"
        print(msg)
        raise Exception(msg)

    return p


def venv_setup():
    print("# venv setup")

    # python environment
    venv_run_process('python -m venv venv')

    venv_run_process(f'{venvbase}/python -m pip install --upgrade pip')
    venv_run_process(f'{venvbase}/pip install -r requirements.txt')
    venv_run_process(f'{venvbase}/python envsetup.py')


def envsetup():
    from rapidenv.osh import run_process, run_process_with_stdout

    print("# pip install")
    run_process(f'{venvbase}/pip install -r requirements.txt')


if __name__ == "__main__":
    if not Path('venv').exists():
        venv_setup()
    else:
        envsetup()
