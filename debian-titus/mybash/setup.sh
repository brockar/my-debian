#!/bin/bash

RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'

command_exists() {
	command -v $1 >/dev/null 2>&1
}

checkEnv() {
	## Check for requirements.
	REQUIREMENTS='curl groups sudo'
	if ! command_exists ${REQUIREMENTS}; then
		echo -e "${RED}To run me, you need: ${REQUIREMENTS}${RC}"
		exit 1
	fi

	## Check Package Handeler
	PACKAGEMANAGER='apt yum dnf pacman zypper'
	for pgm in ${PACKAGEMANAGER}; do
		if command_exists ${pgm}; then
			PACKAGER=${pgm}
			echo -e "Using ${pgm}"
		fi
	done

	if [ -z "${PACKAGER}" ]; then
		echo -e "${RED}Can't find a supported package manager"
		exit 1
	fi

	## Check if the current directory is writable.
	GITPATH="$(dirname "$(realpath "$0")")"
	if [[ ! -w ${GITPATH} ]]; then
		echo -e "${RED}Can't write to ${GITPATH}${RC}"
		exit 1
	fi

	## Check SuperUser Group
	SUPERUSERGROUP='wheel sudo root'
	for sug in ${SUPERUSERGROUP}; do
		if groups | grep ${sug}; then
			SUGROUP=${sug}
			echo -e "Super user group ${SUGROUP}"
		fi
	done

	## Check if member of the sudo group.
	if ! groups | grep ${SUGROUP} >/dev/null; then
		echo -e "${RED}You need to be a member of the sudo group to run me!"
		exit 1
	fi

}

installDepend() {
	## Check for dependencies.
	DEPENDENCIES='autojump bash bash-completion tar bat'
	echo -e "${YELLOW}Installing dependencies...${RC}"
	sudo ${PACKAGER} install -yq ${DEPENDENCIES}
}

installStarship() {
	if command_exists starship; then
		echo "Starship already installed"
		return
	fi

	if ! curl -sS https://starship.rs/install.sh | sh; then
		echo -e "${RED}Something went wrong during starship install!${RC}"
		exit 1
	fi
}

linkConfig() {
	## Get the correct user home directory.
	USER_HOME=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6)
	## Check if a bashrc file is already there.
	OLD_BASHRC="${USER_HOME}/.bashrc"
	if [[ -e ${OLD_BASHRC} ]]; then
		echo -e "${YELLOW}Moving old bash config file to ${USER_HOME}/.bashrc.bak${RC}"
		if ! mv ${OLD_BASHRC} ${USER_HOME}/.bashrc.bak; then
			echo -e "${RED}Can't move the old bash config file!${RC}"
			exit 1
		fi
	fi

	echo -e "${YELLOW}Linking new bash config file...${RC}"
	## Make symbolic link.
	ln -svf ${GITPATH}/.bashrc ${USER_HOME}/.bashrc
	ln -svf ${GITPATH}/starship.toml ${USER_HOME}/.config/starship.toml
}

checkEnv
installDepend
installStarship
if linkConfig; then
	echo -e "${GREEN}Done!\nrestart your shell to see the changes.${RC}"
else
	echo -e "${RED}Something went wrong!${RC}"
fi
