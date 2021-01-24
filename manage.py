import sys

from rapidenv.osh import run_process, run_process_with_stdout

variants_map = {
    "ubunto-16.04": "xenial",
    "ubunto-18.04": "bionic",
    "ubunto-20.04": "focal",
}


def dist_variant(hub_user, repo_name, ver, build, variant, base, push):
    image_name = f"{hub_user}/{repo_name}:{ver}-{variant}"
    print(f"## {image_name} ## ")
    print("# build image")
    run_process(f"docker build . -t {image_name} "
                f"--rm --build-arg VER={ver} --build-arg BUILD={build} "
                F"--build-arg VARIANT={variant} --build-arg BASE={base} ")

    if push == "-p":
        print("# push image")
        run_process(f"docker push {image_name}")

    print("")


def dist():
    # https://docs.docker.com/docker-hub/repos/
    ver = (len(sys.argv) > 1 and sys.argv[1]) or '0.0.0'
    push = (len(sys.argv) > 2 and sys.argv[2]) or ''
    build = run_process_with_stdout('git rev-parse --short HEAD').strip()
    repo_name = "swt-base"
    hub_user = "innovizswt"

    print(f'################################################################')
    print(f'# {repo_name} distribution')
    print(f'# hub user: {hub_user}')
    print(f'# repo name: {repo_name}')
    print(f'# version: {ver}')
    print(f'# build: {build}')
    print(f'################################################################')
    print('')

    for (variant, base) in variants_map.items():
        dist_variant(hub_user, repo_name, ver, build, variant, base, push)


if __name__ == "__main__":
    dist()
