#!/bin/sh -v

# create directory
mkdir -p pacman
mkdir -p pacman_aur
mkdir -p packages

#clean cache
rm -f /var/cache/pacman/pkg/*
rm -f packages/*
rm -f pacman/*

#retrieve packages
pacman -Syy
for package in $( pacman -Q | cut -f 1 -d' ' | tr "\n" ' ' ) ; do
    pacman -Sw --noconfirm $package
done

#copy packages
cp /var/cache/pacman/pkg/* pacman/
cp ~/*.pkg.tar.xz pacman_aur/

cp ~/parallel*.tgz packages/ || echo "Please download icc into root's home"
