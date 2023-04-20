#!/bin/sh

# Please update also ./switch.sh and ./shared/nix-conf.nix if you change this file

HOSTNAME=${TARGET:=$(hostname)}
echo "Building for $HOSTNAME"
case $HOSTNAME in
	algedi)
		nix-shell --pure --run "nix-build <nixpkgs/nixos> -A system \$REBUILD_OPTIONS_UNSTABLE $@"
		;;
	mintaka)
		nix-shell --pure --run "nix-build <nixpkgs/nixos> -A system \$REBUILD_OPTIONS_UNSTABLE $@"
		;;
	polaris)
		nix-shell --pure --run "nix-build <nixpkgs/nixos> -A system \$REBUILD_OPTIONS_UNSTABLE $@"
		;;
	proxima)
		nix-shell --pure --run "nix-build <nixpkgs/nixos> -A system \$REBUILD_OPTIONS_UNSTABLE $@"
		;;
	*)
		echo "Cannot determine which nixpkgs version to use" >&2
		exit 2
		;;
esac


