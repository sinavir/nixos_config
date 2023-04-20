#!/bin/sh

# Please update also ./switch.sh and ./shared/nix-conf.nix if you change this file

HOSTNAME=${TARGET:=$(hostname)}
CONFIG_DIR=${CONFIG_DIR:=/etc/nixos}
echo "Building for $HOSTNAME"
case $HOSTNAME in
	algedi)
		OPTIONS_VAR=REBUILD_OPTIONS_UNSTABLE
		;;                                                                                    
	mintaka)                                                                                      
		OPTIONS_VAR=REBUILD_OPTIONS_UNSTABLE
		;;                                                                                    
	polaris)                                                                                      
		OPTIONS_VAR=REBUILD_OPTIONS_UNSTABLE
		;;                                                                                    
	proxima)                                                                                      
		OPTIONS_VAR=REBUILD_OPTIONS_UNSTABLE
		;;
	*)
		echo "Cannot determine which nixpkgs version to use" >&2
		exit 2
		;;
esac

nix-shell --arg nixos-config \"$CONFIG_DIR/machines/$HOSTNAME/configuration.nix\" --pure --run "echo \$NIX_PATH; nix-build -A system \$$OPTIONS_VAR '<nixpkgs/nixos>' $@"

