set -x

IMAGE=${IMAGE:-densavchenko/heasoft}

mntpar=""
shmntpar=""
for mount in $MOUNTS; do
	mntpar=$mntpar"\"-v\", \"$mount\", " 
	shmntpar=$shmntpar"-v $mount"
done

function install_kernel {
	mkdir -p ~/.local/share/jupyter/kernels/heasoft-docker

	cat <<- EOF > ~/.local/share/jupyter/kernels/heasoft-docker/kernel.json
	{
	"argv": [
	  "/usr/bin/docker",
	  "run",
	  "--rm",
	  "--network=host",
	  "-v", "{connection_file}:/connection-spec",
	  "-e", "DISPLAY",
	  "--env", "USER_ID=`id -u`",
	  "--env", "GROUP_ID=`id -g`",
	  ${mntpar}
	  "${IMAGE}",
	  "python",
	  "-m",
	  "ipykernel_launcher",
	  "-f",
	  "/connection-spec"
	],
	"display_name": "HEASOFT in container",
	"language": "python"
	}
	EOF
}

function run_container {
	/usr/bin/docker run \
		--rm -v "/tmp/.X11-unix:/tmp/.X11-unix:ro" \
		-e DISPLAY \
		--env USER_ID=`id -u` \
		--env GROUP_ID=`id -g` \
		${shmntpar} \
		-it ${IMAGE} \
		$@
}

$@
