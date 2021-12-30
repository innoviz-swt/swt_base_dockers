import os
from pathlib import Path
import sys


if sys.platform == "win32":
    pycmd = "python"
    venv = 'venv'
    venvbase = Path("venv/Scripts")
else:
    pycmd = "python3"
    venv = 'env'
    venvbase = Path("env/bin")


def venv_run_process(cmd: str):
    # run subprocess
    p = os.system(cmd)

    # validate error code
    if p != 0:
        msg = f"process exited with error code '{p}'"
        print(msg)
        raise Exception(msg)

    return p


def venv_setup():
    print("# venv setup")

    # python environment
    venv_run_process(f'{pycmd} -m venv {venv}')

    venv_run_process(f'{venvbase}/python -m pip install --upgrade pip')
    venv_run_process(f'{venvbase}/pip install -r requirements.txt')
    venv_run_process(f'{venvbase}/python envsetup.py')


def envsetup():
    from rapidenv.osh import run_process, run_process_with_stdout

    print("# pip install")
    run_process(f'{pycmd} -m pip install --upgrade pip')
    run_process(f'{pycmd} -m pip install -r requirements.txt')


if __name__ == "__main__":
    if not Path(f"{venv}").exists():
        venv_setup()
    else:
        envsetup()
