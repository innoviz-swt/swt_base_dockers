import shutil
import os
import sys
from pathlib import Path

from rapidenv.osh import copy_path, run_process, run_process_with_stdout


def dist():
    # https://docs.docker.com/docker-hub/repos/
    ver = (len(sys.argv) > 1 and sys.argv[1]) or '0.0.0'
    push = (len(sys.argv) > 2 and sys.argv[2]) or ''
    build = run_process_with_stdout('git rev-parse --short HEAD').strip()
    repo_name="swt-xenial-docker"
    hub_user="innovizswt"
    
    print(f'################################################################')
    print(f'# {repo_name} distribution')
    print(f'# hub user: {hub_user}')
    print(f'# repo name: {repo_name}')
    print(f'# version: {ver}')
    print(f'# build: {build}')
    print(f'################################################################')
    print('')

    print("# build image")
    run_process(f"docker build . -t {hub_user}/{repo_name}:{ver} --rm --build-arg VER={ver} --build-arg BUILD={build}")

    if push == "-p":   
        print("# push image")
        run_process(f"docker push {hub_user}/{repo_name}:{ver}")

if __name__ == "__main__":
    dist()
