IMAGE=${IMAGE:-densavchenko/heasoft}

mntpar=""
for mount in $MOUNTS; do
	mntpar=$mntpar"\"-v\", \"$mount\", " 
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
	  "--env", "USER_ID=1001",
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

$@
