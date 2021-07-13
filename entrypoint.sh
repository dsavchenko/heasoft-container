#!/bin/bash

comm=${@:-fversion}

if [[ -z $USER_ID ]]; then
	echo "Starting with default username: heasoft"
elif [[ -z $GROUP_ID ]]; then
	if ! [[ $USER_ID =~ ^[0-9]+$ ]] ; then
		echo "LOCAL_UID is wrong"
		exit 1
	fi
	echo "Starting with UID : $USER_ID"
	usermod -u $USER_ID heasoft
	chown -Rh heasoft /home/heasoft
	chown -Rh heasoft /opt/heasoft
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
	usermod -u $USER_ID heasoft
	groupmod -g $GROUP_ID heasoft
	chown -Rh heasoft:heasoft /home/heasoft
	chown -Rh heasoft:heasoft /opt/heasoft
fi

exec /usr/sbin/gosu heasoft "$comm"
