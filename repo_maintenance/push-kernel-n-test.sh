#!/bin/sh -e

DIR=$PWD
git_bin=$(which git)

if [ -e ${DIR}/version.sh ]; then
	unset BRANCH
	unset KERNEL_TAG
	. ${DIR}/version.sh

	if [ ! "${BRANCH}" ] ; then
		BRANCH="master"
	fi

	if [ ! "${KERNEL_TAG}" ] ; then
		echo 'KERNEL_TAG undefined'
		exit
	fi

	${git_bin} commit -a -m "kernel v${KERNEL_TAG} rebase with rt: v${KERNEL_REL}${kernel_rt} aufs/wireguard/etc" -s
	echo "log: git push origin ${BRANCH}"
	${git_bin} push origin ${BRANCH}
fi

