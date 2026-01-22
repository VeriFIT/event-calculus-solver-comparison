CONT_NAME=docker_fdec_1


attach:
	podman exec -it -w /fdec fdec bash

build:
	podman build --squash-all -t fdec -f ./Dockerfile ../

clean:
	podman container rm fdec
#	podman image rm fdec

up:
	podman run --init -d --name fdec -v "$$PWD"/../:/fdec -w /fdec fdec || podman restart --filter "status=exited" --filter "name=fdec"

down:
	podman stop -t 0 fdec

