image=densavchenko/heasoft:v6.28-ipy0.1
mounts=${HOME}/heasoft-container-data:/data:rw

build:
	docker build -t ${image} .

push: build
	docker push ${image}

install_kernel:
	IMAGE=${image} MOUNTS=${mounts} bash make.sh install_kernel

run_bash:
	IMAGE=${image} MOUNTS=${mounts} bash make.sh run_container bash
