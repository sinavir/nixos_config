#!/bin/sh

# Please update also shared/nix-conf.nix if you change this file

HOSTNAME=${HOSTNAME:=$(hostname)}
echo "Rebuilding for $HOSTNAME"
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

nix-shell --pure --run "nixos-rebuild switch \$$OPTIONS_VAR $@"


