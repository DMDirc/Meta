#!/bin/bash

# Script to checkout the client at a given point of time.
# Usage:
#
# checkoutAt.sh <meta|client|parser|util|plugins> <sha1>
#
# This will checkout <sha1> in the given repo, and then checkout the last
# commit in all other repos that happened before the time of requested commit.

REPO="${1}"
SHA1="${2}"

VALID_REPOS=(meta client parser util plugins)
containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

containsElement "${REPO}" "${VALID_REPOS[@]}"
RES=${?}

if [ "${SHA1}" = "" -o ${RES} -ne 0 ]; then
	echo "Usage:"
	echo "${0} <meta|client|parser|util|plugins> <sha1>"
	echo ""
	echo "This will checkout <sha1> in the given repo, and then checkout the last commit in all other repos that happened before the time of requested commit."
	exit 1;
fi;

CHECKOUTDIR="${PWD}"
if [ ! -e "${CHECKOUTDIR}/settings.gradle" -o "`grep "rootProject.name = 'dmdirc'" settings.gradle 2>&1`" = "" ]; then
	echo "'${PWD}' does not look like a DMDirc/meta checkout."
	exit 1;
fi;


getRepoDir() {
	if [ "${1}" = "meta" ]; then
		echo "${CHECKOUTDIR}/"
	else
		echo "${CHECKOUTDIR}/${1}"
	fi;
}

isCommit() {
	if [ "`git cat-file -t "${1}" 2>&1`" = "commit" ]; then
		echo "0"
	else
		echo "1"
	fi;
}

cd `getRepoDir "${REPO}"`

if [ `isCommit ${SHA1}` -eq 1 ]; then
	echo "Invalid commit in ${REPO}: ${SHA1}"
	exit 1;
fi;

# Get the requested commit.
echo -ne "\e[32m"
echo "In ${REPO}: "
echo -ne "\e[93m"; git show ${SHA1} -s --format="     Checking out: %H - %s"
echo -ne "\e[93m"; git show ${SHA1} -s --format="                   Author: %an / Committer: %cn / Date: %cD"
echo -e "\e[39m"


echo -ne "\e[90m"
git reset --hard
git checkout -f ${SHA1}
echo -e "\e[39m"

THISTIME=`git show ${SHA1} --pretty=format:%ct`

# Now get all the others...
for R in "${VALID_REPOS[@]}"
do
	if [ "${R}" != "${REPO}" ]; then
		cd `getRepoDir "${R}"`
		RSHA1=`git rev-list -1 --before="${THISTIME}" --all`
		echo -ne "\e[32m"
		echo "In ${R}: "
		echo -ne "\e[93m"; git show ${RSHA1} -s --format="     Checking out: %H - %s"
		echo -ne "\e[93m"; git show ${RSHA1} -s --format="                   Author: %an / Committer: %cn / Date: %cD"
		echo -e "\e[39m"

		echo -ne "\e[90m"
		git reset --hard
		git checkout -f ${RSHA1}
		echo -e "\e[39m"
	fi;
done;

cd "${CHECKOUTDIR}"
