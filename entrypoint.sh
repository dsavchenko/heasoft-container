#!/bin/bash

if [[ -z $USER_ID ]]; then
	echo "Starting with default username: heasoft"
	exec /usr/sbin/gosu heasoft "$@"
elif [[ -z $GROUP_ID ]]; then
	if ! [[ $USER_ID =~ ^[0-9]+$ ]] ; then
		echo "LOCAL_UID is wrong"
		exit 1
	fi
	echo "Starting with UID : $USER_ID"
	useradd --shell /bin/bash -u $USER_ID -o -m user
	export HOME=/home/user
else
	if ! [[ $USER_ID =~ ^[0-9]+$ ]] ; then
		echo "LOCAL_UID is wrong"
		exit 1
	fi
	if ! [[ $GROUP_ID =~ ^[0-9]+$ ]] ; then
		echo "LOCAL_GID is wrong"
		exit 1
	fi
	echo "Starting with UID $USER_ID and GID $GROUP_ID"
	groupadd -o -g $GROUP_ID user
	useradd --shell /bin/bash -u $USER_ID -g $GROUP_ID -o -m user
	export HOME=/home/user
fi

exec /usr/sbin/gosu user "$@"