#!/bin/sh

# Please update also shared/nix-conf.nix if you change this file

HOSTNAME=${HOSTNAME:=$(hostname)}
echo "Rebuilding for $HOSTNAME"
case $HOSTNAME in
	algedi)
		nix-shell --pure --run "nixos-rebuild switch \$REBUILD_OPTIONS_UNSTABLE $@"
		;;
	mintaka)
		nix-shell --pure --run "nixos-rebuild switch \$REBUILD_OPTIONS_UNSTABLE $@"
		;;
	polaris)
		nix-shell --pure --run "nixos-rebuild switch \$REBUILD_OPTIONS_UNSTABLE $@"
		;;
	proxima)
		nix-shell --pure --run "nixos-rebuild switch \$REBUILD_OPTIONS_STABLE $@"
		;;
	*)
		echo "Cannot determine which nixpkgs version to use" >&2
		exit 2
		;;
esac


